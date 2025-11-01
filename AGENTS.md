# Agent Guide

## Purpose
Agents act as senior softwre developers collaborators. Keep responses concise,
clarify uncertainty before coding, and align suggestions with the rules linked below.

## Rules
Read the rules before doing anything else.
Rules have a lot of similarity to the "binder" that you'll find behind
the counter in any franchise. It explains how to do everything,
from opening the store in the morning to handling an unruly customer
to what to do if there's a power outage.
Good franchises spend a lot of time and money building and
testing these business process bibles that ensure that staff
can reliably and repeatably deliver "brand standard" service to customers,
no matter what's going on.
Rules are mandatory for every single task even a small one like "echo hello"

## Rule Index
- @ai/rules/rule-loading.md — always load this file to understand which other files you need to load. This must be done even for simplest tasks.

## Repository Overview
- Deep product and architecture context: @ai/docs/
This repo is a dotfiles/tooling workspace used to bootstrap and maintain a fast terminal-first macOS/Linux development environment. It contains:

- ai/rules, ai/docs — house rules for agents and engineering docs used by local AI assistants.
- config/ — configs for nvim, tmux, wezterm, kitty, ghostty, zellij, lazygit, bat, helix, lsd.
- bin/ — small utilities (bash, python, swift, rust). Used directly and by configs (e.g., tmux status).
- codex/, claude/ — local agent prompts, settings, scripts; symlinked into ~/.codex and ~/.claude via create-links.
- git-templates/ — git hooks (e.g., pre-push guard).
- create-links — one-shot script to symlink repo files into $HOME and ~/.config.
- update-hooks — installs pre-push from git-templates into .git/hooks.

Key entry points to edit most often:
- zsh: `zshrc`, `fzf.zsh`
- tmux: `tmux.conf` (uses `bin/tmux-status` for the right status line)
- neovim: `config/nvim/lua/everything/init.lua` and `config/nvim/lua/everything/plugins/*`
- terminal: `config/kitty/*.conf`, `config/ghostty/config`, `config/wezterm/wezterm.lua`
- toolchain: `config/mise/config.toml` (pins versions for node, python, go, rust, java)
- git: `gitconfig`, `githelpers`, `git-templates/hooks/pre-push`

## Commands
- Setup
  - `./create-links` — symlink this repo into `$HOME` and `~/.config`.
  - `./update-hooks` — copy `git-templates/hooks/pre-push` into `.git/hooks`.

- Build utilities (Swift)
  - `cd bin && ./build.sh` — builds `trash` and `trashsweeper` via `swiftc`.
  - `./bin/build-swift.sh <name>` — builds `<name>.swift` to `bin/<name>`.

- Git helpers
  - `./bin/git-related-files.sh <path>` — show top co-changed files for a path.

- Markdown TUI viewer
  - `./bin/kmd [README.md]` — render Markdown to HTML with pandoc and view via w3m.

- Tmux status (used by tmux.conf)
  - `~/dots/bin/tmux-status` — prints a compact status line; tmux.conf calls this.

- Agents
  - Codex: prompts in `codex/prompts`, scripts in `codex/scripts`. Symlinked to `~/.codex` by `create-links`.
  - Claude: commands in `claude/commands`, agents in `claude/agents`. Symlinked to `~/.claude` by `create-links`.
  - `./bin/ccp` — helper that wraps `claude` CLI with an additional system prompt.

## Code Style
- Keep diffs small; match surrounding style in touched files.
- Prefer descriptive, short names over comments; avoid documenting comments.
- Scripts: use shebangs; prefer `bash` with `set -euo pipefail` and `IFS=$'\n\t'` when parsing.
- Naming: shell `kebab-case.sh`, Python `snake_case.py`, Swift lowercased filenames, Rust `snake_case` identifiers.
- Use always-trailing commas where the language allows.
- Make impossible states unrepresentable; favor exhaustive enums and typed flags.
- Remove placeholders, dead/defensive/fallback code, and noisy debug prints.
- Keep files reasonably short; extract helpers over long functions.
- Units: metric for distance, ISO 8601 and 24h time, °C/kelvin for temperature, grams for weight.
- I prefer standard units (such as metric for distance, ISO 8601 for time, 24h clock for daily hours, Celsius and Kelvin for temperature, grams for weight)
- If at all possible use always-trailing commas
- Make impossible states unrepresentable
- Always use shord concise variable and method and class names instead of comments
- Always remove comments that are not compiler/linter directives except when they explain very hard to understand algorithm/bug/hack
- Always remove placeholders
- Always remove fallback code if not required by the task
- Always remove spammy debug comments if not required by the task
- Always remove defensive code if not required by the task
- Always remove dead code if not required by the task
- Keep files reasonably short when possible

## Architecture & Patterns
- Repo-as-source-of-truth: files are symlinked into $HOME via `create-links`.
- Separation of concerns: each tool has its own subtree under `config/`.
- Neovim uses `lazy.nvim` (see `config/nvim/lua/everything/lazy.lua`), with plugins grouped under `everything/plugins` and bootstrapped in `everything/init.lua`.
- Tmux status is computed by `bin/tmux-status` and injected via `tmux.conf` `status-right`.
- Versions are pinned via `config/mise/config.toml` to keep toolchains reproducible.
- YAGNI/KISS: prefer the simplest viable setting or script; generalize only with repetition.

## Key Integration Points
**Database**: none — this repo manages local config and scripts only.
**Services**: local toolchain and CLIs: Homebrew, `mise`, tmux, neovim, ripgrep, fd, bat, lsd, pandoc, w3m, oh‑my‑zsh; optional: kitty, ghostty, wezterm.
**Testing**: manual smoke tests for shell, tmux, neovim, and utilities; static linting with shellcheck/ruff/stylua where applicable.
**UI**: terminal-centric: tmux status line, Neovim UI, terminal emulators (Kitty/Ghostty/Wezterm).

## Workflow
- Ask for clarification when requirements are ambiguous; surface 2–3 options when trade-offs matter
- Update documentation and related rules when introducing new patterns or services

## Testing
- Local smoke tests
  - Setup: run `./create-links`; verify symlinks exist (e.g., `ls -l ~/.zshrc`).
  - Zsh: start a new shell; ensure no startup errors; `fzf` bindings work.
  - Tmux: start tmux; status bar shows path/git/languages; `~/dots/bin/tmux-status` prints a line.
  - Neovim: `nvim +checkhealth` loads without errors; plugins initialize (lazy bootstrap).
  - Swift tools: `cd bin && ./build.sh`; run `./trashsweeper` to verify it executes.

- Linters (optional but recommended)
  - Shell: `shellcheck bin/*.sh`.
  - Python: `ruff check bin/*.py`.
  - Lua: `stylua --check config/nvim/lua`.

## Environment
- OS: macOS primary (Darwin branches in scripts); Linux supported where applicable.
- Package manager: Homebrew for system deps; `mise` for language toolchains (see `config/mise/config.toml`).
- Required CLIs: `tmux`, `neovim`, `ripgrep`, `fd`, `bat`, `lsd`, `pandoc`, `w3m`, `git`, `rg`, `fzf`.
- Optional CLIs: `rust-script` (for `bin/dashboard.rs`), `shellcheck`, `stylua`, `ruff`.
- Swift toolchain (Xcode CLTs) for building `bin/*.swift`.
- After cloning: run `./create-links`, then restart shell or `exec zsh`.

## Special Notes
- Do not mutate files outside the workspace root without explicit approval
- Avoid destructive git operations unless the user requests them directly
- When unsure or need to make a significant decision ASK the user for guidance
- Commit only things you modified yourself, someone else might be modyfing other files.
