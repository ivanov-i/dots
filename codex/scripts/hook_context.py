import json
import sys
from pathlib import Path
from typing import Any


def read_hook_event() -> dict[str, Any]:
    raw_event = sys.stdin.read()
    if not raw_event.strip():
        return {}

    try:
        event = json.loads(raw_event)
    except json.JSONDecodeError:
        return {}

    return event if isinstance(event, dict) else {}


def should_notify_user(event: dict[str, Any]) -> bool:
    transcript_path = event.get("transcript_path")
    if not isinstance(transcript_path, str) or not transcript_path:
        return False

    try:
        with Path(transcript_path).open(encoding="utf-8") as transcript:
            first_line = transcript.readline()
        session_meta = json.loads(first_line)
    except (OSError, json.JSONDecodeError):
        return False

    payload = session_meta.get("payload")
    if not isinstance(payload, dict):
        return False

    thread_source = payload.get("thread_source")
    if thread_source is not None:
        return thread_source == "user"

    return isinstance(payload.get("source"), str)
