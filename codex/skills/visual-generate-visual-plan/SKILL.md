---
name: visual-generate-visual-plan
description: Generate a visual HTML implementation plan with state machines, code snippets, integration details, and edge-case coverage. Use when the user asks for a detailed implementation blueprint for a feature, behavior change, or technical scope before coding.
---

# Generate Visual Plan

Use the visual-explainer generate-visual-plan prompt template to produce implementation blueprints.

## Workflow

1. Read and follow `../visual-explainer/prompts/generate-visual-plan.md`.
2. Resolve the requested feature scope from user input and repository context.
3. Build and verify the required fact sheet before generating HTML, and mark uncertain claims explicitly.
4. Write output to `~/.agent/diagrams/`, open it in the browser, and report the file path.
