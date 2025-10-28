# Agent Guide

## Purpose
Agents act as senior developer collaborators. Keep responses concise,
clarify uncertainty before coding, and align suggestions with the rules linked below.

## Rule Index
- @ai-rules/rule-loading.md — always load this file to understand which other files you need to load

## Repository Overview
- Deep product and architecture context: @ai-docs/
[Fill in by LLM assistant]

## Git Rules
- Never touch remote branches. No fetches or pushes.

## Commands
[Fill in by LLM assistant]

## Code Style
- I prefer standard units (such as metric for distance, ISO 8601 for time, 24h clock for daily hours, Celsius and Kelvin for temperature, grams for weight).
- If at all possible use always-trailing commas
- Make impossible states unrepresentable
- Always use shord concise variable and method and class names instead of comments
- Always remove comments that are not compiler/linter directives except when they explain very hard to understand algorithm/bug/hack
- Always remove placeholders
- Always remove fallback code if not required by the task
- Always remove spammy debug comments if not required by the task
- Always remove defensive code if not required by the task
- Always remove dead code if not required by the task
- Keep files reasonably short when possible.

## Architecture & Patterns
[Fill in by LLM assistant]

## Key Integration Points
**Database**: [Fill in by LLM assistant]
**Services**: [Fill in by LLM assistant]
**Testing**: [Fill in by LLM assistant]
**UI**: [Fill in by LLM assistant]

## Workflow
- Ask for clarification when requirements are ambiguous; surface 2–3 options when trade-offs matter
- Update documentation and related rules when introducing new patterns or services

## Testing
[Fill in by LLM assistant]

## Environment
[Fill in by LLM assistant]
- Validate formatting and linting before final review
- Never do anything with remote in git. Only local. no fetches or pushes. Remember. Even git fetch is prohibited.

## Special Notes
- Do not mutate files outside the workspace root without explicit approval
- Avoid destructive git operations unless the user requests them directly
- When unsure or need to make a significant decision ASK the user for guidance
- Commit only things you modified yourself, someone else might be modyfing other files.
- Never use `git restore` (or similar commands) to revert files you didn't author—coordinate with other agents instead so their in-progress work stays intact.
- Quote any git paths containing brackets or parentheses (e.g., `src/app/[candidate]/**`) when staging or committing so the shell does not treat them as globs or subshells.
- When running `git rebase`, avoid opening editors—export `GIT_EDITOR=:` and `GIT_SEQUENCE_EDITOR=:` (or pass `--no-edit`) so the default messages are used automatically.
- Never amend commits unless you have explicit written approval in the task thread.
- ABSOLUTELY NEVER run destructive git operations (e.g., `git reset --hard`, `rm`, `git checkout`/`git restore` to an older commit) unless the user gives an explicit, written instruction in this conversation. Treat these commands as catastrophic; if you are even slightly unsure, stop and ask before touching them. *(When working within Cursor or Codex Web, these git limitations do not apply; use the tooling's capabilities as needed.)*
- When running `git rebase`, avoid opening editors—export `GIT_EDITOR=:` and `GIT_SEQUENCE_EDITOR=:` (or pass `--no-edit`) so the default messages are used automatically.
- NEVER edit `.env` or any environment variable files—only the user may change them.

