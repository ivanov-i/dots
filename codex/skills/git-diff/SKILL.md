---
name: git-diff
description: git diff
---

# Diffs

Git is customized in such way that by default you do miss changes in diffs for example

1. Turn off pagers to avoid useless noise and make it easier to read (for example --no-pager)
2. Turn off external diffs (there are delta and difftastic configured) to see diffs more clearly in the terminal (for example --no-ext-diff)
3. Turn off coloring to make it easier to read in the terminal (for example --no-color)

Example diff:

git --no-pager diff --no-color --no-ext-diff
