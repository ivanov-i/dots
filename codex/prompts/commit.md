# Commit

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -40`

## Goal

Create well-formatted commits 

1. Checks which files are staged with `git status`.
2. Check historical commits to learn style and tone (`git log --oneline -40`).
3. Analyze the diff to determine if multiple distinct logical changes are present.
4. If multiple distinct changes are detected, break the commit into multiple smaller commits.
5. For each commit (or the single commit if not split), create a commit message using the commit convention.
   1. Add all relevant changes with `git add`.
   2. Performs a `git diff` to understand what actual changes are being committed
   3. Write the descriptive and concise commit message.

## Commit Style

- **Atomic commits**: Each commit should contain related changes that serve a single purpose.
- **Split large changes**: If changes touch multiple concerns, split them into separate commits. Always reviews the commit diff to ensure the message matches the changes
- **keep description single line**: Keep the whole commit message single line. It is forbidden to add more lines.
- **Do not add Co-Authored-By**: Do not add Co-Authored-By or "Generated with" in commit messages.

## Guidelines for Splitting Commits

When analyzing the diff, consider splitting commits based on these criteria:

1. **Different concerns**: Changes to unrelated parts of the codebase
2. **Different types of changes**: Mixing features, fixes, refactoring, etc.
3. **File patterns**: Changes to different types of files (e.g., source code vs documentation)
4. **Logical grouping**: Changes that would be easier to understand or review separately
5. **Size**: Very large changes that would be clearer if broken down

# Do not
- Do not do anything with remotes. do not push, fetch etc.
- Do do anything else besides creating commits.
- No "next steps"
