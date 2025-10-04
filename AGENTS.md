# Repository Guidelines

## Project Structure & Module Organization
| Path | Purpose |
|---|---|
| `bin/` | Small tools (Bash, Swift, Rust, Python). Run from this folder when building Swift tools. |
| `config/` | App configs (`nvim`, `zellij`, `wezterm`, `lazygit`, `bat`, `helix`, `lsd`, `ghostty`). |
| `create-links` | Symlinks repo files into `$HOME` and `$HOME/.config`. |
| Root files | `zshrc`, `tmux.conf`, `gitconfig`, `githelpers`, `ideavimrc`, `p10k.zsh`, `fzf.zsh`. |
| `codex/`, `claude/` | Agent prompts, scripts, and local agent settings. |
| `git-templates/` | Git templates/hooks used by this repo. |

## Coding Style & Naming Conventions
- Match surrounding style in touched files; keep diffs minimal and consistent.
- Prefer descriptive names over comments; Never add descriptive or documenting comment.
- Scripts: Bash with `#!/usr/bin/env bash`; executable bit on tools in `bin/`.
- Naming: shell scripts `kebab-case.sh`, Python `snake_case.py`, Swift lowercase filenames, Rust follows `snake_case` identifiers.

## Commit & Pull Request Guidelines
- Commit messages: single, clear one-liners; no prefixes.

## Security & Configuration Tips
- Do not commit secrets or machine-specific credentials.
- Note macOS/Linux differences; `create-links` already handles platform-specific lazygit paths.
- Keep files reasonably short; prefer incremental changes.

## Tooling Hints
- Fast search: `rg`, `fd`; structured code queries: `ast-grep`.
- Diff review: `delta` or `difftastic` for readable, semantic diffs.
