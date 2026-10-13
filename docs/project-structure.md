---
summary: 'Top-level project structure and path purposes.'
read_when:
  - Navigating the repo or adding new files.
---
## Project Structure & Module Organization
| Path | Purpose |
|---|---|
| `bin/` | Small tools (Bash, Swift, Rust, Python). Run from this folder when building Swift tools. |
| `config/` | App configs (`nvim`, `zellij`, `wezterm`, `lazygit`, `bat`, `helix`, `lsd`, `ghostty`). |
| `config/launchd/` | macOS launch agents, linked into `~/Library/LaunchAgents` by `create-links`. |
| `create-links` | Symlinks repo files into `$HOME` and `$HOME/.config`. |
| Root files | `zshenv`, `zshrc`, `tmux.conf`, `gitconfig`, `githelpers`, `ideavimrc`, `p10k.zsh`, `fzf.zsh`. |
| `codex/`, `claude/` | Agent prompts, scripts, and local agent settings. |
| `git-templates/` | Git templates/hooks used by this repo. |

## Trashsweeper service

`com.ivanov.trashsweeper` runs `~/bin/trashsweeper` at login and every 10 minutes
while the Mac is awake and the user is logged in. It deletes the oldest Trash
items until at least 10 GiB is free. The plist uses this Mac's absolute paths.

Grant `/Users/ivanov/dots/bin/trashsweeper` Full Disk Access in System Settings →
Privacy & Security so the background service can read Trash.

After building the binary with `cd bin && ./build.sh` and running `create-links`,
load the service with:

```sh
launchctl enable "gui/$(id -u)/com.ivanov.trashsweeper"
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.ivanov.trashsweeper.plist
```

Inspect it with `launchctl print "gui/$(id -u)/com.ivanov.trashsweeper"`.
Stop it with `launchctl bootout "gui/$(id -u)/com.ivanov.trashsweeper"`.
Logs are `~/Library/Logs/trashsweeper.log` and `~/Library/Logs/trashsweeper.err.log`.
