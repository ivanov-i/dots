## Coding Style & Naming Conventions
- Match surrounding style in touched files; keep diffs minimal and consistent.
- Prefer descriptive names over comments; Never add descriptive or documenting comment.
- Scripts: Bash with `#!/usr/bin/env bash`; executable bit on tools in `bin/`.
- Naming: shell scripts `kebab-case.sh`, Python `snake_case.py`, Swift lowercase filenames, Rust follows `snake_case` identifiers.
- Keep files reasonably short; prefer incremental changes.
- Note macOS/Linux differences; `create-links` already handles platform-specific lazygit paths.

