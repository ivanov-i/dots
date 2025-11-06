#!/usr/bin/env python3

import json
import subprocess
import sys


def _summ(text: str) -> str:
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
        "model_reasoning_summary=none",
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
            stderr=subprocess.DEVNULL,
            check=False,
        )
        out = p.stdout.decode("utf-8", errors="ignore")
        s = _last_agent_message(out)
    except Exception:
        s = ""
    if not s:
        s = (text or "").strip().replace("\n", " ")[:160]
    return s

def _last_agent_message(s: str) -> str:
    last = ""
    for ln in s.splitlines():
        ln = ln.strip()
        if not ln:
            continue
        try:
            ev = json.loads(ln)
        except Exception:
            continue
        if ev.get("type") == "item.completed":
            it = ev.get("item") or {}
            if it.get("type") == "agent_message" and isinstance(it.get("text"), str):
                t = it["text"].strip()
                if t:
                    last = t
        elif ev.get("type") == "turn.failed":
            break
    return last


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
            s = _summ(msg)
            if s:
                subprocess.run(["say", s], check=False)
        case _:
            return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
