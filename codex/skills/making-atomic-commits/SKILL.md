---
name: making-atomic-commits
description: Use when making git commits — splits mixed diffs and writes concise single‑line messages.
---

# Making Atomic Commits

## Overview
Each commit should tell a coherent story and be easy to review. Split mixed concerns and keep messages tight.

## When to Use
- When making git commits.

## Checklist
1. ☐ `git status` — staged vs unstaged
2. ☐ `git diff HEAD` — inspect changes; identify multiple concerns
3. ☐ `git log --oneline -40` — learn tone/style
4. ☐ If mixed concerns → split into focused commits
5. ☐ Stage relevant hunks/files; verify with `git diff --staged`
6. ☐ Write single‑line message; no emojis/prefixes or co‑authors

## Splitting Criteria
- Different concerns or types of change (feature/fix/refactor/docs)
- Separate file patterns or large changes that benefit clarity

## Message Rules
- Single line only; descriptive and concise
- No “Co-Authored-By” or “Generated with” trailers
- Infer commit style from git history
- If ticket number is required by style, try to infer it from the current branch name. If not, ask for it.

## Anti‑Patterns
- Remote ops (push/fetch), destructive operations, squashing history unasked
- Suggesting to push, write PR, or any other actions
- Prefixes, emojis, or co-authors
- Non-default author, committer

## Response Pattern
1) If ambiguous → clarify intent and grouping
2) If clear → add/split/commit with single‑line messages
