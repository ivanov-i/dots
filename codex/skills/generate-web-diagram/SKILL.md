---
name: generate-web-diagram
description: Generate a self-contained visual HTML diagram and open it in the browser. Use when the user asks for architecture diagrams, flowcharts, schemas, timelines, dashboards, or any technical visual explanation that should be rendered as a page instead of terminal ASCII.
---

# Generate Web Diagram

Use the visual-explainer prompt template for one-shot diagram generation.

## Workflow

1. Read and follow `../visual-explainer/prompts/generate-web-diagram.md`.
2. Substitute the user request into the template input context.
3. Execute the full visual-explainer workflow from that prompt, including reference/template reads.
4. Write output to `~/.agent/diagrams/`, open it in the browser, and report the file path.
