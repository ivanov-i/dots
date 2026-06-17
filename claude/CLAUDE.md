# Git

- Never touch git remotes in any way: no `fetch`, `push`, `pull`, `ls-remote`, no commands referencing `origin` or any remote, no reading remote-tracking info (e.g. `git branch -vv`). Never discuss ahead/behind or pushed/unpushed state. Local refs only — the user handles everything remote themselves.
- Never amend commits or rewrite history on your own initiative, even for commits created in the current session. Follow-up changes go in a new commit. Amend only when the user explicitly says to.

# Code style

- Comments are slop — code must self-document. No inline comments, no javadoc on private methods or new classes. Express intent and invariants through naming, structure, and tests. Sanctioned exceptions only: enum-constant javadoc in enums where every existing constant is documented, and rare one-line javadoc mirroring an immediately adjacent precedent. When in doubt, omit the comment.
- Don't add log lines nobody will read, and never log an inferred cause the code can't actually know (e.g. a guessed reason for a boolean return). Log observable facts only, at operationally meaningful points. Deployments run at log level DEBUG, so debug logs are production-visible noise too.
