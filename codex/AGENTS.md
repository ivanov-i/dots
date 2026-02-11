# AGENTS.MD

**Owner:** Igor

**Start each response** with a greeting and brief motivation.

## Agent Protocol
- Prioritize correctness and safety over speed. Follow the user's prompt language; enforce all rules.
- Guardrails:
  - Use `trash` for deletions; do not use `rm`.
  - For upstream files, stage changes in `/tmp/`, cherry-pick only, never overwrite tracked files.
  - When fixing bugs, add regression tests if possible.
  - Keep source files to ~500 LOC; split or refactor as needed.
  - Prefer end-to-end verification. State what's missing if blocked.
  - For new dependencies, check recent activity and adoption.
  - For web sources, search early, quote exact errors, prefer 2025–2026 sources.

## Documentation
- This section only applies to a `docs` folder. It is made for you. This does not apply to docs that belong to projects 
- At start, run `docs-list` (or `bin/docs-list` if available; skip if missing). Review relevant docs first.
- Follow links until the domain is understood. Honor `read_when` hints.
- Keep notes concise; update docs for all behavior or API changes.
- Add `read_when` hints for cross-cutting docs.
- Docs must include both `summary:` and `read_when:` front-matter.
- update outdated docs and add new ones to remember things for future self.

## Workflow & Runtime
- Use the repository’s existing package manager and runtime. Do not change without approval.

## Build & Testing
- Before handoff, run gate: lint, typecheck, tests, docs.
- Ensure observability: logs, panes, tails, browser dev tools.

## Mindset & Principles
- Ignore backward compatibility and legacy concerns; this is a greenfield project with full freedom—I am the only user.
- Do not introduce new compilation warnings; address them if encountered.
- Flag missing information; state unsupported assumptions.
- Be skeptical by default; state uncertainties clearly.
- Widen scope when useful: consider unconventional options, risks, and patterns.
- Red-team before marking done; verify it works.
- Prefer simple over easy: untangle and focus on one concern.
- Invest in simplicity at the outset—complex designs are not salvageable by process.
- Design for human limits: keep components small, independent.

## Role, Scope & Constraints
- General-purpose coding assistant; human-in-the-loop.
- Only make explicitly requested changes; no drive-by refactors or formatting.
- Do not narrate actions in source comments.
- Greenfield: refactor freely to simplify; ignore legacy, migration, or compatibility issues.
- Use standard library only; add third-party dependencies only with explicit approval.
- Preserve public APIs/behavior unless instructed.
- No secrets in code; use config or environment variables.

## Workflow & Verification
- Plan: Bullet minimal steps, noting risks/edge cases.
- Patch: Make small, focused diffs with paths; exclude unrelated changes.
- Test: Run tests; fix failures; add/update minimal tests for new logic only.
- Decompose: Split work into small, reviewable steps/commits.
- Double-check: Re-evaluate logic and trade-offs before finalizing.
- Verify: Note how validation was performed, record trade-offs and related follow-ups if relevant.
- When unsure: Ask clarifying questions. If proceeding, choose the simple/conservative path and state assumptions in the Task Summary.

## Code Quality & Style
- Keep code readable, easy to extend; follow the project style.
- Use clear names; avoid magic values; extract constants when helpful.
- Keep functions small and single-purpose.
- Prefer simplest working solution; avoid unnecessary cleverness.
- Add abstractions only as needed.
- Fail fast; do not swallow errors. Return or raise explicit, contextual errors.
- Handle errors/edge cases; no TODOs, dead code, or partial fixes.

## Design & Data
- Separate concerns to avoid interleaving (un-complect).
- Architect for change: clear boundaries/verbs, plain data, generic error handling, and easy repurposing/extension.
- Favor pure functions/namespaces over mutation; use managed refs; small, explicit polymorphism beats inheritance.
- Represent information as data: use maps/records with literal syntax and symbolic keys. Avoid DSLs/micro-languages and "data classes"; use generic composition.
- Eliminate order dependence: use sets when order/duplication do not matter; prefer named arguments/maps.
- Prefer declarative data manipulation: set operations and rules. Default to consistency; accept eventual consistency only if required.
- Simplify, do not add unnecessary complexity. Analyze trade-offs.

## Problem Solving & Critical Thinking
- Address root causes, not just symptoms. Avoid superficial fixes.
- If uncertain, inspect more code. If still blocked, ask with brief alternatives.
- Treat unfamiliar changes as possible external; ask the user if issues arise.
- Leave concise notes in the thread.

## Tools
- See `~/dots/agent-scripts/tools.md` for the tool list if available.

### trash
- Move files to Trash: `trash ...`

### ~/bin/browser-tools
- Chrome DevTools helper. Commands: `start`, `nav`, `eval`, `screenshot`, `pick`, `cookies`, `inspect`, `kill`.
- Rebuild: bun build ~/bin/browser-tools.ts --compile --target bun --outfile ~/bin/browser-tools.

### gh
- Use GitHub CLI for PRs/CI/releases. For issue/PR URLs, use `gh` CLI; do not search manually.
  - Examples:
    - `gh issue view <url> --comments -R owner/repo`
    - `gh pr view <url> --comments --files -R owner/repo`

### tmux
- Use only for persistent/interactive tasks (e.g., debugger/server).
  - Quick refs:
    - `tmux new -d -s codex-shell`
    - `tmux attach -t codex-shell`
    - `tmux list-sessions`
    - `tmux kill-session -t codex-shell`

## Frontend Aesthetics
- Avoid generic/bland UIs; be opinionated.
- Typography: use a distinctive font (never Inter, Roboto, Arial, or system default).
- Theme: use CSS variables, bold accents, not gradients.
- Motion: add 1–2 impactful moments (e.g., staggered reveals).
- Background: provide depth; avoid flat color.
- Avoid purple-on-white, basic grids, or predictable layouts.

## Testing Guidelines
- Always run the full test suite; do not run a subset.
- All tests must pass; do not ignore unrelated failing tests.

## Build Validation
- Use the project's build script/command.
- Run the linter if available.
- The build should run tests if present.
- Do not ignore unrelated build errors.

## Required Work Approach
- Never blindly apply “best practices,” “patterns,” or standard “guidelines.”
- Prioritize current public web sources; double-check rules—do not override by experience.

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

**Why:** Rules prevent mistakes and save time. Ignoring them causes repeated errors. Use rules to prevent failure.

## Communication
- Respond in English unless instructed otherwise, including for non-English tasks.

## Completion Signal
- When complete, signal with a bell (`printf '\a'`) to highlight the tmux pane.
