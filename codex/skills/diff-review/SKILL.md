---
name: diff-review
description: Generate a visual HTML diff review with before/after architecture, code review findings, and decision context. Use when the user asks to review changes against a branch, commit, range, PR, or current working tree.
---

# Diff Review

Use the visual-explainer diff-review prompt template to perform deep, evidence-backed change analysis.

## Workflow

1. Read and follow `../visual-explainer/prompts/diff-review.md`.
2. Resolve diff scope from user input (branch, commit, PR, range, or default behavior defined in the prompt).
3. Build the required fact sheet, then generate the HTML review exactly per template constraints.
4. Write output to `~/.agent/diagrams/`, open it in the browser, and report the file path.
