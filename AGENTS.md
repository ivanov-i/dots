# Repository Guide for Agents

Scope: entire repo (subtree files may override).

## Overview

- Purpose: personal dotfiles and tooling for shell, editors, terminals, git, and AI tooling (Claude/Codex).
- Platforms: macOS primary, Linux supported in places (conditional blocks in zshrc, zellij config).
- Bootstrap: run `./create-links` to symlink configs into `$HOME`. Then set up git templates/hooks and optional tools as below.

## Repo Map (key paths)

| Path | Purpose | Notes |
|---|---|---|
| `zshrc`, `fzf.zsh`, `p10k.zsh`, `colours.sh`, `truecolor` | Shell config, fzf setup, Powerlevel10k, LS_COLORS helpers | Requires oh-my-zsh, fzf, bat, eza, delta; loads `~/.secrets` if present |
| `tmux.conf` | tmux with TPM, resurrect/continuum, vi-keys | Auto-installs TPM; custom prefix is backtick ` |
| `config/nvim/**` | Neovim config | `init.lua` loads `everything`; Java LSP in `ftplugin/java.lua` expects local JDK paths |
| `config/helix/config.toml` | Helix editor config | Theme `catppuccin_macchiato`, inlay hints on |
| `config/wezterm/wezterm.lua` | WezTerm config | Font `VictorMono Nerd Font Mono`, scheme `Brogrammer (Gogh)` |
| `config/ghostty/config` | Ghostty terminal | Minimal bell/confirm settings |
| `config/lazygit/config.yml` | Lazygit | External pager set to `difft` (difftastic) |
| `config/zellij/config.yaml` | Zellij | Full keymap; Alt+h/j/k/l focus, Ctrl+g lock |
| `config/bat/config`, `config/lsd/config.yaml` | CLI tools | Bat styling; lsd with ISO 8601 dates |
| `gitconfig`, `githelpers` | Git settings and pretty log helpers | Pager `delta`, external diff `difft`; aliases include `yolo` using whatthecommit |
| `git-templates/hooks/pre-push` | Git pre-push hook | Blocks pushes when code contains `TODO(ajalaimajalai):` via `rg` |
| `bin/**` | Utilities | Swift: `trash`, `trashsweeper`; Bash: batteries, Wi‑Fi toggle, git helpers; Rust: `dashboard.rs`; Python: `count_tokens.py` (uv) |
| `claude/**` | Claude Code setup | Agents, commands, hooks (no‑comments check), status line, settings |
| `codex/**` | Codex CLI setup | Prompts, notify script, AGENTS.md (house rules) |
| `create-links`, `update-hooks` | Setup scripts | Symlink configs; copy hooks into `.git/hooks` |

## Setup

- Prerequisites (typical): homebrew, oh-my-zsh, fzf, ripgrep (`rg`), fd, bat, eza or lsd, delta, difftastic (`difft`), neovim, helix, tmux, zellij, wezterm or ghostty, git, rustup/cargo, swift toolchain (macOS), jenv, nvm, jq, jj (Jujutsu), tailscale (optional).
- Symlinks: run `./create-links`. It links editor/terminal configs, `bin`, claude/codex assets, and shell/gitrepo files into `$HOME`.
- Git templates/hooks:
  - Link templates: `ln -s "$PWD/git-templates" ~/.git-templates`.
  - Ensure `init.templatedir=~/.git-templates` (already in `gitconfig`).
  - Install hook into this repo: `./update-hooks` (copies `pre-push` into `.git/hooks`).
- Fonts: install “VictorMono Nerd Font Mono” for WezTerm.
- Java LSP: edit `config/nvim/ftplugin/java.lua` to point to your JDKs (paths default to `~/wrk/java/...`).
- Secrets: optional `~/.secrets` is sourced by `zshrc`.

## Shell Behavior

- oh-my-zsh with plugins: `git fzf fzf-tab autoupdate zsh-autosuggestions docker zsh-lazyload zsh-syntax-highlighting`.
- Lazy-loading: `jenv`, `nvm`, `zoxide`, `gh` initialized on first use.
- fzf: previews with `bat`; default source `git ls-files` fallback to `fd`.
- Aliases: `vim/vi/view -> nvim`, `ll/lm` via eza, `gcauto` uses Claude to title commits, `cc` runs Claude with reduced prompts.

## Git Behavior

- Pager `delta` with line numbers; external diff is `difft` (difftastic). Lazygit uses `difft --color=always`.
- Aliases: pretty logs `l/la/r/ra`, `head/hp`, `fa` fetch/prune, `su` reverse last stash apply, `yolo` random message.
- Hook policy: pushing is blocked if diffs contain `TODO(ajalaimajalai):`.
- Commit style: single-line, concise, no prefixes or trailers.

## Editors and Terminals

- Neovim: global loader `everything`; Java via `jdtls` with Lombok; disable auto-format options by default.
- Helix: auto-save, inlay hints, soft-wrap, ISO 8601 date/time shown by lsd.
- tmux: backtick as prefix, TPM auto-install, continuum/resurrect enabled, undercurl and hyperlinks configured.
- Zellij: custom keybindings modes (Normal/Pane/Resize/etc.).
- WezTerm/Ghostty: opinionated fonts/colors; Ghostty disables close confirmations.

## Utilities (bin)

- `better-git-branch.sh`: shows ahead/behind, branch, last commit, description.
- `git-related-files.sh`: top co-changed files for a given path.
- `batteries.sh`: lists device battery levels (macOS `ioreg`).
- `toggle-wifi.sh`: cycles Wi‑Fi power on `en1` (macOS).
- `trash.swift`: move files to Trash; list Trash.
- `trashsweeper.swift`: free disk space by deleting oldest Trash items until a GB threshold is met.
- `dashboard.rs`: minimal HTTP page showing disk space, trash size, batteries, volumes.
- `count_tokens.py`: token counting (uv-run), uses `tiktoken` and `pathspec`.
- `build.sh`/`build-swift.sh`: compile Swift tools with `-static-stdlib -Osize` and strip.

## Agent House Rules (global)

- Prefer `rg` and `fd`; use ast-grep when helpful; diffs via difftastic/delta.
- No non-functional code comments. Use clear identifiers; keep files short.
- Ask for clarification if unclear; follow plans step-by-step and check off.
- Use metric units, ISO 8601 dates, 24h time, Celsius/Kelvin.
- For Python, run via `uv` when executing scripts.

## Notes

- macOS paths and tools are assumed in several places; adjust for Linux as needed.
- Ensure `difft` (difftastic) and `delta` are installed to match git and lazygit configs.
- Some zshrc Java/NVM/JENV paths are user-specific; update for your environment.

