---
name: git
description: git
---

# Git
- if explicitely asked to commit, skip build/test/lint etc
- Commits: Follow the repo style. If a ticket number is not explicitely provided try to infer it from the current branch.
- Safe by default: `git status/diff/log`. Push only when user asks. Do not ask to push. do not touch remote.
- `git checkout` ok for PR review / explicit request.
- Branch changes require user consent.
- Destructive ops forbidden unless explicit (`reset --hard`, `clean`, `restore`, `rm`, …).
- Don’t delete/rename unexpected stuff; stop + ask.
- No repo-wide S/R scripts; keep edits small/reviewable.
- Avoid manual `git stash`; if Git auto-stashes during pull/rebase, that’s fine (hint, not hard guardrail).
- If user types a command (“pull and push”), that’s consent for that command.
- No amend unless asked.
- Multi-agent: check `git status/diff` before edits; ship small commits.
