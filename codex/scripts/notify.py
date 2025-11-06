#!/usr/bin/env python3

import json
import subprocess
import sys


def summarize(text: str) -> str:
    if not text:
        return ""
    prompt = (
        "Summarize the entire assistant message below into one short, clear, speech-friendly sentence (max 160 chars). "
        "Rewrite concisely; do not clip. Keep key outcome, action, or numbers. No code, URLs, quotes, or disclaimers.\n\n"
        "ASSISTANT MESSAGE:\n" + text
    )
    cmd = [
        "codex",
        "-a",
        "never",
        "-s",
        "read-only",
        "exec",
        "--json",
        "-m",
        "gpt-5",
        "-c",
        "model_reasoning_effort=minimal",
        "-c",
        "model_reasoning_summary=detailed",
        "-c",
        "model_verbosity=low",
        "-c",
        "notify=[]",
        "--skip-git-repo-check",
        "-",
    ]
    try:
        p = subprocess.run(
            cmd,
            input=prompt.encode("utf-8"),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=False,
        )
        out = p.stdout.decode("utf-8", errors="ignore")
        s, failed, err, types, usage, reason = _parse_events(out)
        if not s:
            if failed and err:
                _log(f"notify failed: {err}")
            elif p.returncode != 0:
                _log(f"notify rc={p.returncode}")
            elif out.strip() == "":
                se = p.stderr.decode("utf-8", errors="ignore").strip()
                if se:
                    _log(f"notify stderr: {se}")
            else:
                ut = f" usage={usage}" if usage else ""
                rs = f" reasoning={(reason[:120] if reason else '')}"
                _log(f"notify no agent_message; types={','.join(types)}{ut}{rs}")
    except Exception as e:
        _log(f"notify exception: {e}")
        s = ""
    if not s:
        s = "Turn Complete!"
    return s

def _parse_events(s: str):
    last = ""
    failed = False
    err = ""
    types = []
    usage = {}
    reason = ""
    for ln in s.splitlines():
        ln = ln.strip()
        if not ln:
            continue
        try:
            ev = json.loads(ln)
        except Exception:
            continue
        t = ev.get("type")
        if isinstance(t, str):
            types.append(t)
        if t == "item.completed":
            it = ev.get("item") or {}
            if it.get("type") == "agent_message" and isinstance(it.get("text"), str):
                txt = it["text"].strip()
                if txt:
                    last = txt
            elif it.get("type") == "reasoning" and isinstance(it.get("text"), str):
                rt = it["text"].strip()
                if rt:
                    reason = rt
        elif t == "error":
            m = ev.get("message")
            if isinstance(m, str) and m:
                err = m
        elif t == "turn.failed":
            failed = True
            e = ev.get("error") or {}
            m = e.get("message") if isinstance(e, dict) else None
            if isinstance(m, str) and m:
                err = m
            break
        elif t == "turn.completed":
            u = ev.get("usage")
            if isinstance(u, dict):
                for k in ("input_tokens", "cached_input_tokens", "output_tokens"):
                    v = u.get(k)
                    if isinstance(v, int):
                        usage[k] = v
            break
    return last, failed, err, types, usage, reason


def _log(msg: str) -> None:
    try:
        print(msg, file=sys.stderr, flush=True)
    except Exception:
        pass


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: notify.py <NOTIFICATION_JSON>")
        return 1

    try:
        notification = json.loads(sys.argv[1])
    except json.JSONDecodeError:
        return 1

    match notification_type := notification.get("type"):
        case "agent-turn-complete":
            msg = notification.get("last-assistant-message", "")
            if not msg:
                return 0
            s = summarize(msg)
            if s:
                subprocess.run(["say", s], check=False)
        case _:
            return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
