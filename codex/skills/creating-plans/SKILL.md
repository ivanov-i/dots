---
name: creating-plans
description: Use when creating or updating a plan — produces an executable, ambiguity‑free plan with clear tasks.
---

# Creating Plans

## Overview
Write plans that a fresh developer can execute linearly without guessing. Eliminate ambiguity and optional steps.

## When to Use
- When creating or updating a plan.

## Checklist
1. ☐ Get context: current codebase state; ask for missing info
2. ☐ Sanity check: find discrepancies, missing tasks/docs, optional/NOP steps
3. ☐ Implement: write all required sections fully; no placeholders
4. ☐ State assumptions about the executor’s skill and lack of context

## Plan Template
```
# %plan_name% - Plan

## Read This First
- Read this plan fully. Inspect current implementation/files: [paths]

## What You Are Building
- What/why/how at high level; assumptions and constraints

## Implementation Details
- Algorithms, data structures, failure modes; how we avoid bugs/deadlocks

## Bite-Sized Tasks
- [ ] 1. task name
  - steps
  - mark as done in plan
  - Commit: <single-line message>
- [ ] 2. task name
...

## Manual Testing Guide
- Steps to verify end‑to‑end
```

## Anti‑Patterns
- Optional steps, NOP tasks (e.g., "keep this code"), pending items

## Response Pattern
1) If ambiguous → ask targeted clarifying questions
2) If clear → produce the plan using the template above
3) If blocked → ask for the missing inputs
