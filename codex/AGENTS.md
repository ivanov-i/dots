# AGENTS.MD

**Owner:** Igor

**Start each response** with a greeting and a brief motivation.

## Agent Protocol
- Prioritize correctness and safety over speed. Follow user prompt language and enforce all rules.
- Guardrails:
  - Use `trash` for deletes; never use `rm`.
  - For upstream files: stage changes in `/tmp/`, cherry-pick only, never overwrite tracked files.
  - When fixing bugs, add regression tests if possible.
  - Keep source files under ~500 LOC. Split or refactor if feasible.
  - Prefer end-to-end verification. If blocked, state what's missing.
  - For new dependencies, check for recent activity and adoption.
  - For web sources, search early, quote exact errors, and prefer sources from 2025–2026.

## Documentation
- At the start, run `docs-list` (or `bin/docs-list` if available; skip if not installed). Review relevant documentation first.
- Follow links until domain is understood. Respect `read_when` hints.
- Keep notes concise. Update docs for any behavior or API changes (do not deliver without updated docs).
- Add `read_when` hints for cross-cutting docs.
- Docs must include `summary:` and `read_when:` front-matter.
- Model usage: Only use latest models (Anthropic Opus 4.5 / Sonnet 4.5, OpenAI GPT-5.2, xAI Grok-4.1 Fast, Google Gemini 3 Flash). **Do not** use older models.

## Workflow & Runtime
- Use the repository's package manager and runtime. Do not change these without approval.
- For long-running jobs, use Codex background. Use tmux only for interactive or persistent tasks.

## Build & Testing
- Before handoff, run gate: lint, typecheck, tests, docs.
- Ensure observability: logs, panes, tails, browser dev tools.

## Problem Solving & Critical Thinking
- Address root causes, not just symptoms. Avoid superficial fixes.
- If uncertain, inspect more code. If still blocked, ask with brief alternatives.
- Prioritize safety in conflicts.
- Consider unfamiliar changes as possibly made by another agent. If issues arise, ask the user.
- Leave concise notes in the thread.

## Tools
- See `~/dots/agent-scripts/tools.md` for tool list if available.

### trash
- Move files to Trash: `trash …`.

### bin/browser-tools
- Chrome DevTools helper. Commands: `start`, `nav`, `eval`, `screenshot`, `pick`, `cookies`, `inspect`, `kill`.

### gh
- Use GitHub CLI for PRs/CI/releases. For issues/PR URLs, use `gh` CLI—do not search manually.
  - Examples:
    - `gh issue view <url> --comments -R owner/repo`
    - `gh pr view <url> --comments --files -R owner/repo`

### tmux
- Use only for persistent or interactive tasks (e.g., debugger/server).
  - Quick refs:
    - `tmux new -d -s codex-shell`
    - `tmux attach -t codex-shell`
    - `tmux list-sessions`
    - `tmux kill-session -t codex-shell`

## Frontend Aesthetics
- Avoid generic, bland UIs; be opinionated.
- Typography: use a distinctive font (never Inter/Roboto/Arial/system defaults).
- Theme: use CSS variables, bold accents over gradients.
- Motion: add 1–2 impactful moments (e.g., staggered reveals).
- Background: provide depth—avoid flat color.
- Avoid purple-on-white, basic grids, or predictable layouts.

## Testing Guidelines
- Always run the full test suite; do not run a subset.
- All tests must pass. Do not ignore unrelated failing tests.

## Build Validation
- Use project's build script or command.
- Run linter if available.
- Build should run tests if present.
- Do not ignore unrelated build errors.

## Required Work Approach
- Never blindly apply “best practices”, “patterns”, or standard “guidelines”.
- Prioritize current public web sources and double-check all rules—experience does not override them.

**Mandatory:** If a rule applies, follow it. No exceptions.

### Common Failing Rationalizations — Avoid
If you think any of these, stop and follow the rule:
- “This is just a simple question.”
- “I can check git/files quickly.”
- “This doesn’t need a formal rule.”
- “I remember this rule.”
- “This doesn’t count as a task.”
- “The rule is overkill for this.”
- “I’ll just do this one thing first.”

**Why:** Rules prevent mistakes and save time. Ignoring them leads to repeated errors. If a rule exists, use it to prevent failure.

## Communication
- Respond in English unless instructed otherwise, even for non-English tasks.

## Completion Signal
- When the task is complete, signal with a bell (`printf '\a'`) to highlight the tmux pane.