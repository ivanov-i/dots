name: interactive-rebase
description: Use when rewriting commit history — rewording, splitting, squashing, or cleaning messages — in a safe, bounded, and observable way without touching remotes.

---

# Interactive Rebase

## Overview
Safely rewrites local history with a clear boundary, a safety net, and visible progress. Focuses on message-only changes and surgical edits while avoiding remote operations.

## When To Use
- Clean up commit messages (e.g., remove prefixes/colons).
- Reorder, split, or squash commits before sharing.
- Rewrite messages across a bounded window (e.g., last month).

## When Not To Use
- After publishing commits to a shared remote without coordination.
- When policy or compliance forbids rewriting public history.
- When you cannot create a safety backup or stash local changes.

## Principles
- Safety first: back up the tip and stash local changes.
- No remote ops: never push/fetch during history rewrites.
- Single‑line messages; no prefixes/emojis/trailers; no co‑authors.
- Keep the process observable: show progress and the current stop.

## Quick Reference
- Show window to edit: `git log --oneline --since "YYYY-MM-DD"`
- Start interactive from parent: `git rebase -i --rebase-merges <sha>^`
- Pause and edit message: mark line as `reword` (or `edit`)
- Amend message only: `git commit --amend --allow-empty -m "New subject"`
- Continue: `git rebase --continue`
- Cancel: `git rebase --abort`
- Check progress: read `.git/rebase-merge/msgnum` and `.../end`
- Verify subjects: `git log --pretty=%s --since "YYYY-MM-DD"`

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

## Checklist (Use TodoWrite per skill system)
1. Status clean or stashed (`git status`; stash if needed).
2. Create safety branch of current tip (`backup/pre-rewrite-<YYYYMMDD-HHMMSS>`).
3. Bound the window (explicit dates or base SHA).
4. Choose approach: manual `reword` stops or `--fixup=reword` + autosquash.
5. Run rebase; at each stop amend subject; use `--allow-empty` for message‑only changes.
6. Resolve conflicts consistently; continue until done.
7. Verify subjects (no `^[^ ]+:`), show short log sample.
8. Restore stash if used; summarize outcomes and divergence.

## RED–GREEN–REFACTOR (Skill TDD)
### RED — Baseline Failure
- Without this skill, agents commonly:
  - Skip backups (“simple change”).
  - Delete `.git/index.lock` blindly.
  - Push during/after rewrites.
  - Forget `--allow-empty` on message-only amends; rebase stalls.

### GREEN — Minimal Skill
- Enforce backup+stash, bounded window, no remotes.
- Use `reword`/`edit` or `--fixup=reword` + autosquash.
- Use `--allow-empty` for message-only.
- Verify with log queries; present before/after sample.

### REFACTOR — Close Loopholes (Rationalization Counters)
- “It’s trivial; no backup needed” → Require safety branch creation.
- “Lockfile is stuck; just delete” → Check for live Git first; only remove if stale.
- “Let’s push to finish” → No remote operations in this flow.
- “Editor popped open; stuck” → Close editor, amend message, continue or abort safely.

## Message Rules
- Single line; descriptive and concise.
- No prefixes/colons/emojis; no “Co‑Authored‑By”; no trailers.

## Common Mistakes
- Rewriting published history without coordination.
- Amending without `--allow-empty` for message-only edits.
- Forgetting to verify subjects across the whole window.

## Anti‑Patterns
- Remote operations (push/fetch) during rewrites.
- Blindly deleting `.git/index.lock` while Git is running.
- Destructive resets without an explicit backup.

## Response Pattern
1) Clarify the window/targets and confirm the approach.
2) Create a backup branch; stash if needed; announce both.
3) Execute the chosen recipe with progress updates.
4) Verify, restore, summarize — and stop short of any remote operation.

## Acceptance Criteria (for operators)
- Safety branch exists and points to pre-rewrite tip.
- If stash was taken, it is restored; working tree matches expectations.
- No subjects in the window match `^[^ ]+:`.
- No remote refs were modified; ahead/behind reported only.
