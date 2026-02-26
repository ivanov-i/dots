---
name: fact-check
description: Verify factual accuracy of a document against the codebase and git evidence, then correct inaccuracies in place. Use when the user asks to validate HTML review pages, markdown plans/specs, or other code-claiming documents.
---

# Fact Check

Use the visual-explainer fact-check prompt template for strict claim verification and in-place corrections.

## Workflow

1. Read and follow `../visual-explainer/prompts/fact-check.md`.
2. Resolve the target document from user input (explicit path or default behavior defined in the prompt).
3. Extract verifiable claims, classify each claim, and apply surgical corrections in place.
4. Add a verification summary in the target document format and report what was corrected.
