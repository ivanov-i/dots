# Instructions

## Quality of life

- use ast-grep when it suits you better
- there is ripgrep and fd

## Critical Rules

- All code comments must be functional. Either as compiler directive or when absolutely required to explain a very hard algorithm.
- It is absolutely forbidden to add code comments when it is not required.
- Instead of comments use short but descriptive variable or method or class names etc. 
- Keep files reasonably short when possible.
- If something is unclear or too complex, ask for clarification.
- In git always use nice clean one-line messages in the style of existing git history. no prefixes
- Never do anything with remote in git. Only local. no fetches or pushes. Remember. Even git fetch is prohibited.
- I prefer standard units (such as metric for distance, ISO 8601 for time, 24h clock for daily hours, Celsius and Kelvin for temperature, grams for weight).
- I like efficient markup, such as using tables for comparisons.
- When asked a question provide an answer. Do not do anything else.
- When workin on a plan with steps do them without skipping.
- If there are checkboxes in the plan, mark them as done after each step.
- iAlways use uv nstead of python to avoid modules instllation.
- When fixing a bug determine a root cause first. Never remove functionality to resolve a bug even if it doesn't work. It doesn't work due to a bug, not the other way around.
- Delete unused or obsolete files when your changes make them irrelevant (refactors, feature removals, etc.), and revert files only when the change is yours or explicitly requested. If a git operation leaves you unsure about other agents' in-flight work, stop and coordinate instead of deleting.
- **Before attempting to delete a file to resolve a local type/lint failure, stop and ask the user.** Other agents are often editing adjacent files; deleting their work to silence an error is never acceptable without explicit approval.
- NEVER edit `.env` or any environment variable files—only the user may change them.
- Coordinate with other agents before removing their in-progress edits—don't revert or delete work you didn't author unless everyone agrees.
- Moving/renaming and restoring files is allowed.
- ABSOLUTELY NEVER run destructive git operations (e.g., `git reset --hard`, `rm`, `git checkout`/`git restore` to an older commit) unless the user gives an explicit, written instruction in this conversation. Treat these commands as catastrophic; if you are even slightly unsure, stop and ask before touching them. *(When working within Cursor or Codex Web, these git limitations do not apply; use the tooling's capabilities as needed.)*
- Never use `git restore` (or similar commands) to revert files you didn't author—coordinate with other agents instead so their in-progress work stays intact.
- Always double-check git status before any commit
- Keep commits atomic: commit only the files you touched and list each path explicitly. For tracked files run `git commit -m "<scoped message>" -- path/to/file1 path/to/file2`. For brand-new files, use the one-liner `git restore --staged :/ && git add "path/to/file1" "path/to/file2" && git commit -m "<scoped message>" -- path/to/file1 path/to/file2`.
- Quote any git paths containing brackets or parentheses (e.g., `src/app/[candidate]/**`) when staging or committing so the shell does not treat them as globs or subshells.
- When running `git rebase`, avoid opening editors—export `GIT_EDITOR=:` and `GIT_SEQUENCE_EDITOR=:` (or pass `--no-edit`) so the default messages are used automatically.
- Never amend commits unless you have explicit written approval in the task thread.
- When reading documentations, plans, specs etc ALWAYS read the full file. Often there are important things you must not miss.
