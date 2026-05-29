import json
import tempfile
import unittest
from pathlib import Path

from hook_context import should_notify_user


def transcript(thread_source):
    path = Path(tempfile.mkdtemp()) / "rollout.jsonl"
    path.write_text(
        json.dumps({"type": "session_meta", "payload": {"thread_source": thread_source}}) + "\n",
        encoding="utf-8",
    )
    return str(path)


class HookContextTest(unittest.TestCase):
    def test_user_thread_notifies(self):
        self.assertTrue(should_notify_user({"transcript_path": transcript("user")}))

    def test_subagent_thread_is_silent(self):
        self.assertFalse(should_notify_user({"transcript_path": transcript("subagent")}))

    def test_missing_transcript_is_silent(self):
        self.assertFalse(should_notify_user({"transcript_path": None}))

    def test_invalid_transcript_is_silent(self):
        path = Path(tempfile.mkdtemp()) / "rollout.jsonl"
        path.write_text("not json\n", encoding="utf-8")

        self.assertFalse(should_notify_user({"transcript_path": str(path)}))


if __name__ == "__main__":
    unittest.main()
