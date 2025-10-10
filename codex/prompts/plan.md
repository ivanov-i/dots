---
description: Plan according to the user's request, without starting the implementation.
---

Great. I need your help to write out a comprehensive  implementation plan.

Assume that the engineer has zero context for our codebase and questionable taste. document everything they need to know. which files to touch for each task, code, testing, docs they might need to check. how to test it.give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. frequent commits.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. assume they don't know good test design very well.  

The plan should contain checboxes for each task. Also there must be a section explaining how to follow the plan (one task at a time, strict order, mark after a task is fone, no bulk implementation< no out of order)

# Optimize for Simplicity

Start with the minimal viable solution
Check if the goal can be achieved by modifying existing solutions
Consider if anything can be removed rather than added
Prefer straightforward approaches over complex ones

# Consider Edge Cases

What could go wrong at each step?
What are the fallback options?
Where might iterations be needed?

please write out this plan, in full detail, into $INSTRUCTIONS
