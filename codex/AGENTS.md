# AGENTS.MD

Igor owns this. Start: say hi + 1 motivating line.
Work style: telegraph; noun-phrases ok; drop grammar; min tokens.

## Agent Protocol
- Files: repo or `~/dots/
- Only edit AGENTS when user says “make a note” (ignore `CLAUDE.md`).
- Guardrails: use `trash` for deletes.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Bugs: add regression test when it fits.
- Keep files <~500 LOC; split/refactor as needed.
- Commits: Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`). Follow the repo style.
- Subagents: read `docs/subagent.md`.
- Prefer end-to-end verify; if blocked, say what’s missing.
- New deps: quick health check (recent releases/commits, adoption).
- Slash cmds: `~/.codex/prompts/`.
- Web: search early; quote exact errors; prefer 2024–2025 sources; fallback Firecrawl (`pnpm mcp:*`) / `mcporter`.
- Oracle: run `oracle --help` once/session before first use.
- Style: telegraph. Drop filler/grammar. Min tokens (global AGENTS + replies).

## Docs
- Start: run docs list (`docs:list` script, or `bin/docs-list` here if present; ignore if not installed); open docs before coding.
- Follow links until domain makes sense; honor `Read when` hints.
- Keep notes short; update docs when behavior/API changes (no ship w/o docs).
- Add `read_when` hints on cross-cutting docs.
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

## Git

- Safe by default: `git status/diff/log`. Push only when user asks.
- `git checkout` ok for PR review / explicit request.
- Branch changes require user consent.
- Destructive ops forbidden unless explicit (`reset --hard`, `clean`, `restore`, `rm`, …).
- Don’t delete/rename unexpected stuff; stop + ask.
- No repo-wide S/R scripts; keep edits small/reviewable.
- Avoid manual `git stash`; if Git auto-stashes during pull/rebase, that’s fine (hint, not hard guardrail).
- If user types a command (“pull and push”), that’s consent for that command.
- No amend unless asked.
- Big review: `git --no-pager diff --color=never`.
- Multi-agent: check `git status/diff` before edits; ship small commits.

### Diffs

Git is customized in such way that by default you do miss changes in diffs for example

1. Turn off pagers to avoid useless noise and make it easier to read (for example --no-pager)
2. Turn off external diffs (there are delta and difftastic configured) to see diffs more clearly in the terminal (for example -c --no-ext-diff)
3. Turn off coloring to make it easier to read in the terminal (for example --no-color)

Example diff:

git -c color.ui=false diff --no-pager --no-ext-diff HEAD 

# Oracle

## Overview
Oracle is a simple, reliable way to bundle a prompt plus the right files and hand them to another AI (GPT 5 Pro).

## When to Use
Use when stuck/bugs/reviewing code

## How to Use
- Run `oracle --help` once to learn the interface syntax
- By default it uses browser engine and profile set up elsewhere. This is correct, do not modify.
- If it can't login, do not try to fix it. Ask the user to help you.
- Note, only browser engine works. Do not try other engines.
- Use good prompt and provide all needed context in prompt and files.
- Do not supply the answers, do not nudge it into your direction

## Anti‑Patterns
- using any other engine
- not stoppying and not reporting errors
- "I've already solved this, and here's my reasons why it's solved, but check it over anyway," kind of tone, which heavily biases Oracle

## Tools

Read `~/dots/agent-scripts/tools.md` for the full tool catalog if it exists.

### peekaboo
- Screen tools: `~/dots/Peekaboo`. Cmds: `capture`, `see`, `click`, `list`, `tools`, `permissions status`.
- Needs Screen Recording + Accessibility. Docs: `~/dots/Peekaboo/docs/commands/`.

### trash
- Move files to Trash: `trash …` (system command).

### bin/docs-list / scripts/docs-list.ts
- Optional. Lists `docs/` + enforces front-matter. Ignore if `bin/docs-list` not installed. Rebuild: `bun build scripts/docs-list.ts --compile --outfile bin/docs-list`.

### bin/browser-tools / scripts/browser-tools.ts
- Chrome DevTools helper. Cmds: `start`, `nav`, `eval`, `screenshot`, `pick`, `cookies`, `inspect`, `kill`.
- Rebuild: `bun build scripts/browser-tools.ts --compile --target bun --outfile bin/browser-tools`.

### oracle
- Bundle prompt+files for 2nd model. Use when stuck/buggy/review.
- Run `oracle --help` once/session (before first use).

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

# Reviewing Code

## Review Checklist
1. Context: read plan, docs, commits; scan layout/architecture
2. Sanity: verify plan vs code/docs alignment; stop and clarify on mismatches
3. Architecture: spot god objects, leaks, wrong abstractions, premature/missing optimizations
4. Architecture style: verify code vs the rest of the project. Architecture must match the rest of the project.
5. Bugs: races, deadlocks, off‑by‑one, nullability, resource leaks, TOCTOU
6. Security: injection, authz, secrets, randomness, side channels, SSRF/XXE
7. Performance: complexity bombs, N+1, blocking I/O, hot‑path allocs, regex traps
8. Patterns: TODO/FIXME/HACK, debug prints, ts-ignore, string concatenated SQL, swallowed exceptions
9. Code Quality: names, complexity, duplication, magic numbers, data clumps
10. Coding Style: you know how to write code, use that
11. Analysis: root causes; systemic issues and thinking errors

## Report Format
```
- verdict
- critical_failures
- severe_problems
- architectural_disasters
- performance_catastrophes
- security_vulnerabilities
- code_quality_violations
- root_cause_diagnosis
- mandatory_fixes
- the_standard
- final_judgment
```

## Verdict Scale
REJECTED | DANGEROUS | AMATEUR | MEDIOCRE | BARELY ACCEPTABLE | ACCEPTABLE

## Quick Reference Patterns
- Grep patterns to catch common issues (adapt to stack):
  - `TODO|FIXME|HACK|XXX`
  - `console\.log|print|fmt\.Print|puts|var_dump`
  - `password|secret|key|token.*=.*["']`
  - `exec|eval|system|shell_exec`
  - `SELECT.*\+|".*\+.*SELECT`
  - `catch\s*\(.*\)\s*{\s*}`
  - `Thread\.sleep|time\.sleep|sleep\(`
  - `new Date\(\)|Date\.now\(\)`
  - `@ts-ignore|@ts-nocheck`


# Useful Modern Utilities

- trash: rm replacement on MacOs. Usage: "trash file1 file2 folder1 folder2". Use it and the files can be restored later. MacOs cleans up trashed files after a month, so don't worry about saving disk space. 
- ~/sandbox/agent-scripts/scripts/browser-tools.ts: Chrome DevTools helper without running an MCP server. Key commands: start (launch Chrome with remote debugging), nav <url> (navigate), eval <js> (run JS in the active tab), screenshot (viewport PNG to /tmp), pick <msg> (interactive element picker), cookies, inspect, kill. Launch via browser-tools --help. 

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
