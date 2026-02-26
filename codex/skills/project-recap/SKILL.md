---
name: project-recap
description: Generate a visual HTML project recap that rebuilds context from current code and recent activity. Use when the user asks for a mental-model refresh, recent-change narrative, architecture snapshot, or cognitive-debt inventory.
---

# Project Recap

Use the visual-explainer project-recap prompt template to produce a high-signal context recovery page.

## Workflow

1. Read and follow `../visual-explainer/prompts/project-recap.md`.
2. Resolve the time window and free-form context from user input using the template rules.
3. Build the required fact sheet from repository evidence before generating the recap.
4. Write output to `~/.agent/diagrams/`, open it in the browser, and report the file path.
