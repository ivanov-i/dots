# Core Principles
- Clarify first: present 2–3 options with trade‑offs and concrete examples
- Progressive architecture: start direct → abstract on repetition → generalize on patterns
- Error handling: exhaustive enums/variants; actionable recovery paths; no force-unwraps
- Decouple from frameworks where reasonable
- Performance: profile → measure → optimize; pick correct data structures
- Simplicity: KISS, YAGNI; remove dead/defensive/fallback code and spammy logs
- No excessive abstractions.
- No useless getters/setters/builders.
- No fallbacks for tests in production code
- No backward compatibility unless specifically required
- No magic numbers; no magic strings
- No default parameters, null fallbacks etc

# Anti‑Patterns
- God objects, stringly‑typed APIs, retained cycles
- Force unwrapping, premature optimization, unnecessary abstraction

# Working with Git

## Diffs

Git is customized in such way that by default you do miss changes in diffs for example

1. Turn off pagers to avoid useless noise and make it easier to read (for example --no-pager)
2. Turn off external diffs (there are delta and difftastic configured) to see diffs more clearly in the terminal (for example -c --no-ext-diff)
3. Turn off coloring to make it easier to read in the terminal (for example --no-color)

Example diff:

git -c color.ui=false diff --no-pager --no-ext-diff HEAD 

## Making Commits

Each commit should tell a coherent story and be easy to review. Split mixed concerns and keep messages tight.

### Checklist
Git commands to run (remember to uncustomize as needed):
1. status - staged vs unstaged
2. diff  - inspect changes; identify multiple concerns
3. log --oneline -n 40 --no-merges` — learn tone/style of commit messages
4. If mixed concerns → split into focused commits
5. diff staged
6. Write single‑line message; no emojis/prefixes or co‑authors

### Splitting Criteria
- Different concerns or types of change (feature/fix/refactor/docs)
- Do not mix different features even if they are in a single file or a similar type.
- Separate file patterns or large changes that benefit clarity
- You want to add with a commit message like "item1 and item2". That "and" word is a criteria to split.

### Commit Message Rules
Do not use "conventional" message formats. Your intuition is from average stackoverflow copypaster. Follow thise rules:
- Single line only; descriptive and concise
- No “Co-Authored-By” or “Generated with” trailers
- Infer commit style from git history (step #3 in the checklist)
- If ticket number is required by style, try to infer it from the current branch name. If not, ask for it. Do not commit without it. 

### Anti‑Patterns
- Remote ops (push/fetch), destructive operations, squashing history unasked
- Suggesting to push, write PR, or any other actions
- Prefixes, emojis, or co-authors
- Non-default author, committer
- Commit message which do not follow established commit style.
- Commit contains two or more unrelated changes.
- Message follow a "Item1 and Item2" style.

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

# How to run tests
- Always run all tests. Never cheat by running only a subset of tests.
- All tests should pass.
- There is no such thing as "unrelated test"

# How to validate Builds
- Run a build script or one-liner whatever the project requires.
- Run liner if available.
- Make sure that all tests pass. No cheating. Every single test must pass.
- There is no such thing as "unrelated test"

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
