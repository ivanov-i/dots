---
name: plan-review
description: Generate a visual HTML plan review that compares a proposed implementation plan against the current codebase. Use when the user asks to validate an RFC, spec, or plan before implementation and wants gap/risk analysis.
---

# Plan Review

Use the visual-explainer plan-review prompt template to verify plan accuracy and implementation risk.

## Workflow

1. Read and follow `../visual-explainer/prompts/plan-review.md`.
2. Resolve inputs from user arguments (plan path and optional codebase path).
3. Build the required fact sheet from plan text and current code before producing the page.
4. Write output to `~/.agent/diagrams/`, open it in the browser, and report the file path.
