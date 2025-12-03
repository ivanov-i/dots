use gh command to find repo and owner:
```
gh repo view --json nameWithOwner -q .nameWithOwner
```

PR  number is $PR_NUMBER

Then you can see the whole pr discussion with comments using

```
gh view-md https://github.com/<REPO>/pull/$PR_NUMBER
```

That single command gives you everything:

Full issue/PR metadata (title, author, dates, status)
The complete body content with HTML stripped
All comments in chronological order with timestamps
Timeline events (labels, assignments, state changes)
For PRs: code diffs, review comments, commit history, and CI status
Proper markdown formatting throughout


Read that and tell me what do you think? Do you agree with the communts? Should we address any of them? Do we modify code or push back on any of them?
