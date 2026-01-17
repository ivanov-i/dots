Developer: # AGENTS.MD

Igor owns this. Start with a greeting and a brief motivation.

## Agent Protocol
- Prioritize correctness and safety, not speed. Never omit user prompt language or ignore rules.
- Guardrails: use `trash` for deletes, never `rm`.
- For upstream files: stage in `/tmp/`, cherry-pick only, never overwrite tracked files.
- For bugs: add regression tests if possible.
- Keep source files under ~500 LOC; split or refactor if needed/possible/reasonable.
- Prefer end-to-end verification; if blocked, state the missing piece.
- For new dependencies: check recent activity and adoption.
- Web: search early, quote exact errors, prefer 2025–2026 sources.

## Docs
- Begin by running `docs-list` (either the script or `bin/docs-list` if present; skip if not installed). Open relevant docs first.
- Follow links until the domain is clear; honor `read_when` hints.
- Keep notes concise. Update docs for all behavior/API changes (never ship without updated docs).
- Add `read_when` hints for cross-cutting docs.
- Docs must always include `summary:` and `read_when:` front-matter.
- Model: Use only the latest (Anthropic Opus 4.5 / Sonnet 4.5, OpenAI GPT-5.2, xAI Grok-4.1 Fast, Google Gemini 3 Flash). Avoid older models.

## Flow & Runtime
- Use the repo's package manager/runtime. Do not swap without approval.
- For long jobs: use Codex background. Use tmux only for interactive/persistent tasks.

## Build / Test
- Before handoff, run the full gate (lint, typecheck, tests, docs).
- Ensure observability (logs, panes, tails, browser tools).

## Critical Thinking
- Always address root causes (avoid band-aids).
- If unsure, read more code; if still blocked, ask with brief options.
- For conflicts, highlight and choose safety.
- For unrecognized changes, assume another agent made them. If issues appear, ask the user.
- Leave brief breadcrumb notes in the thread.

## Tools
Check `~/dots/agent-scripts/tools.md` for the full tool list if available.

### trash
- Use: `trash …` to move files to Trash (system command).

### bin/browser-tools
- Chrome DevTools helper. Commands: `start`, `nav`, `eval`, `screenshot`, `pick`, `cookies`, `inspect`, `kill`.

### gh
- GitHub CLI for PRs/CI/releases. For issue/PR URLs: use `gh` CLI, not search.
- Examples:
  - `gh issue view <url> --comments -R owner/repo`
  - `gh pr view <url> --comments --files -R owner/repo`

### tmux
- Use only for persistent/interactive needs (debugger/server).
- Quick refs:
  - `tmux new -d -s codex-shell`
  - `tmux attach -t codex-shell`
  - `tmux list-sessions`
  - `tmux kill-session -t codex-shell`

# Frontend Aesthetics
Do not use generic “AI slop” UIs. Be opinionated.

**Do:**
- Typography: select a distinctive font, never Inter/Roboto/Arial/system defaults.
- Theme: use a focused palette and CSS variables. Favor bold accents over gradients.
- Motion: add 1–2 high-impact moments (like staggered reveals).
- Background: add depth, avoid flat color.

**Avoid:** purple-on-white, basic grids, predictable layouts.

# How to Run Tests
- Always run all tests; subset is not allowed.
- All tests must pass. “Unrelated failing test” is not acceptable.

# How to Validate Builds
- Run the required build script/command per project.
- Run linter if available.
- Build should run tests if present.
- “Unrelated build error” is not allowed.

# Required Work Approach

Do not blindly follow typical “best practices”, “patterns”, or “guidelines”. Draw knowledge from current public web sources. Always check the rules; expertise does not override them.

IF A RULE APPLIES, YOU MUST USE IT.

This is mandatory and non-negotiable. No rationalizations.

# Common Failing Rationalizations — Avoid

If you think any of these, stop and follow the rule:
- “This is just a simple question”
- “I can check git/files quickly”
- “This doesn’t need a formal rule”
- “I remember this rule”
- “This doesn’t count as a task”
- “The rule is overkill for this”
- “I’ll just do this one thing first”

**Why:** Rules prevent known mistakes and save time. Not following them causes repeat errors.

If a rule exists, use it or you risk failure.

# Human Communication

Answer in English unless told otherwise, even for non-English tasks.

On task completion, signal using a bell (`printf '\a'`); this highlights the tmux pane.

