# for uvx:

#!/usr/bin/env python3

import json
import os
import re
import subprocess
import sys


FAST_MODEL = "gpt-5-mini"  # explicit fast, non-thinking model


def _summ(text: str) -> str:
    if not text:
        return ""
    prompt = (
        "Return exactly one JSON object with a single key 's'. "
        "'s' must be a short, speech-friendly summary of the ASSISTANT MESSAGE below, max 160 characters, plain language, no quotes/URLs/code/disclaimers.\n\n"
        "ASSISTANT MESSAGE:\n" + text + "\n\n"
        "Output ONLY JSON like {\"s\":\"...\"}."
    )
    cmd = [
        "codex",
        "-a",
        "never",
        "-s",
        "read-only",
        "exec",
        "-m",
        FAST_MODEL,
        "-c",
        "model_verbosity=low",
        "-c",
        "model_reasoning_effort=low",
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
        out = p.stdout.decode("utf-8", errors="ignore").strip()
        s = _parse_one_json_field(out, "s")
    except Exception:
        s = ""
    if not s:
        s = (text or "").strip().replace("\n", " ")[:160]
    return s


def _parse_one_json_field(s: str, key: str) -> str:
    s = s.strip()
    if not s:
        return ""
    try:
        obj = json.loads(s)
        v = obj.get(key)
        return v.strip() if isinstance(v, str) else ""
    except Exception:
        # Try to locate the first {...} block if extra noise is present
        m = re.search(r"\{.*\}", s, flags=re.S)
        if not m:
            return ""
        try:
            obj = json.loads(m.group(0))
            v = obj.get(key)
            return v.strip() if isinstance(v, str) else ""
        except Exception:
            return ""


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
