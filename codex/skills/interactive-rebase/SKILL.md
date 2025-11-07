name: interactive-rebase
description: Use when rewriting commit history — rewording, splitting, squashing, or cleaning messages safely and predictably.

---

# Interactive Rebase

## When To Use
- Clean up commit messages (e.g., remove prefixes/colons).
- Reorder, split, or squash commits before sharing.
- Rewrite messages across a bounded window (e.g., last month).

## Principles
- Safety first: back up the tip and stash local changes.
- No remote ops: never push/fetch during history rewrites.
- Single‑line messages; no prefixes/emojis/trailers; no co‑authors.
- Keep the process observable: show progress and the current stop.

## Quick Recipes

### Reword a few commits (manual)
1. Identify SHAs to change, optionally within a window:
   - `git log --oneline --since "YYYY-MM-DD"`
2. Start rebase from each target’s parent and stop at the commit:
   - `git rebase -i --rebase-merges <sha>^`
   - In the todo, mark the target as `reword` (or `edit`).
3. At each stop:
   - `git commit --amend -m "New message"` (use `--allow-empty` when changing message only),
   - `git rebase --continue`.

### Batch reword with autosquash
1. For each target commit:
   - `git commit --allow-empty --fixup=reword:<sha>` (optionally set `GIT_EDITOR` to inject the new subject),
2. Run autosquash without opening the todo:
   - `GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash --rebase-merges <base>`.
3. If Git stops on a commit marked “empty” while rewording only:
   - `git commit --amend --allow-empty -m "New message"`, then `git rebase --continue`.

### Conflict Handling
- Resolve conflicts, `git add <files>`, `git rebase --continue`.
- Generated/ephemeral files: prefer a consistent strategy (e.g., keep the current version) when history value is low.
- Lockfiles: if `.git/index.lock` exists, first check for live Git processes; only remove a stale lock when no Git process is running.

### Abort / Restore
- `git rebase --abort` to revert the in‑progress rebase.
- Always create a safety branch before starting: `git branch backup/pre-rewrite-<YYYYMMDD-HHMMSS>`.

## Checklist
1. Status clean or stashed (`git status`; stash if needed).
2. Create backup branch of current tip.
3. Choose approach: manual `reword` stops or `fixup=reword` + autosquash.
4. Run rebase; for each stop, amend subject; use `--allow-empty` for message‑only changes.
5. Resolve conflicts; continue until done.
6. Verify subjects:
   - `git log --pretty=%s --since "YYYY-MM-DD"` (e.g., no `^[^ ]+:`).
7. Restore stash if used.
8. Summarize changes (before/after sample) and branch divergence.

## Message Rules
- Single line; descriptive and concise.
- No prefixes/colons/emojis; no “Co‑Authored‑By”; no trailers.

## Anti‑Patterns
- Remote operations (push/fetch) during rewrites.
- Blindly deleting `.git/index.lock` while Git is running.
- Destructive resets without an explicit backup.

## Response Pattern
1) Clarify the window/targets and confirm the approach.
2) Create a backup branch; stash if needed; announce both.
3) Execute the chosen recipe with progress updates.
4) Verify, restore, summarize — and stop short of any remote operation.

