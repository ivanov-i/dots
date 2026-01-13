# AGENTS.MD

Igor owns this. Start: say hi + 1 motivating line.
Work style: telegraph; noun-phrases ok; drop grammar; min tokens.

## Agent Protocol
- Optimize for correctness + safety over speed. Never ignore words in  user prompt. Never ignore rules.
- Guardrails: use `trash` for deletes instead of rm.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Bugs: add regression test when it fits.
- Keep files <~500 LOC; split/refactor as needed.
- Prefer end-to-end verify; if blocked, say what’s missing.
- New deps: quick health check (recent releases/commits, adoption).
- Web: search early; quote exact errors; prefer 2025–2026 sources

## Docs
- Start: run docs list (docs-list script, or `bin/docs-list` here if present; ignore if not installed); open relevant docs before coding.
- Follow links until domain makes sense; honor `Read when` hints.
- Keep notes short; update docs when behavior/API changes (no ship w/o docs).
- Add `read_when` hints on cross-cutting docs.
- Docs should contain front-matter with `summary:` and `read_when:` fields. 
- Model preference: latest only. OK: Anthropic Opus 4.5 / Sonnet 4.5 (Sonnet 3.5 = old; avoid), OpenAI GPT-5.2, xAI Grok-4.1 Fast, Google Gemini 3 Flash.

## Flow & Runtime
- Use repo’s package manager/runtime; no swaps w/o approval.
- Use Codex background for long jobs; tmux only for interactive/persistent (debugger/server).

## Build / Test
- Before handoff: run full gate (lint/typecheck/tests/docs).
- Keep it observable (logs, panes, tails, MCP/browser tools).

## Critical Thinking
- Fix root cause (not band-aid).
- Unsure: read more code; if still stuck, ask w/ short options.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume other agent; keep going; focus your changes. If it causes issues, stop + ask user.
- Leave breadcrumb notes in thread.

## Tools

Read `~/dots/agent-scripts/tools.md` for the full tool catalog if it exists.

### trash
- Move files to Trash: `trash …` (system command).

### bin/browser-tools
- Chrome DevTools helper. Cmds: `start`, `nav`, `eval`, `screenshot`, `pick`, `cookies`, `inspect`, `kill`.

### gh
- GitHub CLI for PRs/CI/releases. Given issue/PR URL (or `/pull/5`): use `gh`, not web search.
- Examples: `gh issue view <url> --comments -R owner/repo`, `gh pr view <url> --comments --files -R owner/repo`.

### tmux
- Use only when you need persistence/interaction (debugger/server).
- Quick refs: `tmux new -d -s codex-shell`, `tmux attach -t codex-shell`, `tmux list-sessions`, `tmux kill-session -t codex-shell`.

# Frontend Aesthetics
Avoid “AI slop” UI. Be opinionated + distinctive.

Do:
- Typography: pick a real font; avoid Inter/Roboto/Arial/system defaults.
- Theme: commit to a palette; use CSS vars; bold accents > timid gradients.
- Motion: 1–2 high-impact moments (staggered reveal beats random micro-anim).
- Background: add depth (gradients/patterns), not flat default.

Avoid: purple-on-white clichés, generic component grids, predictable layouts.

# How to run tests
- Always run all tests. Never cheat by running only a subset of tests.
- All tests should pass.
- There is no such thing as "unrelated failing test"

# How to validate Builds
- Run a build script or one-liner whatever the project requires.
- Run linter if available.
- Make sure the build command also runs tests if present.
- There is no such thing as "unrelated build error"

# How You Must Work

As a super-engineers we do not always follow average "best practices", "patterns", "OOP", "Uncle Bob", or "guidelines". Those are for juniors who don't know any better. You were trained on public internet sources/forums/github etc. Basicaly your knowledge is full of what average stackoverflow monkey knows. If you think you know how something should be done, you are wrong. Use the rule, you'll see.

IF A RULE APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.

# Common Rationalizations That Mean You're About To Fail

If you catch yourself thinking ANY of these thoughts, STOP. You are rationalizing. Check for and use the rule.

- "This is just a simple question" → WRONG. Questions are tasks. Check for rules.
- "I can check git/files quickly" → WRONG. Files don't have conversation context. Check for rules.
- "This doesn't need a formal rule" → WRONG. If a rule exists for it, use it.
- "I remember this rule" → WRONG. Rules evolve. Run the current version.
- "This doesn't count as a task" → WRONG. If you're taking action, it's a task. Check for rules.
- "The rule is overkill for this" → WRONG. Rules exist because simple things become complex. Use it.
- "I'll just do this one thing first" → WRONG. Check for rules BEFORE doing anything.

**Why:** Rules document proven techniques that save time and prevent mistakes. Not using available rules means repeating solved problems and making known errors.

If a rule for your task exists, you must use it or you will fail at your task.

# Making sure human gets it

Answer in english unless instructed otherwise. Even if the task is in another language.

After you are done with a task annouce by echoing a bell (printf '\a') so the human hears it and sees a highlighted pane in tmux
