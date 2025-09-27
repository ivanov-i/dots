# Claude Instructions

## Quality of life

- use ast-grep when it suits you better
- there us ripgrep and fd
- there is difftastic and delta

## Critical Rules
- I am always absolutely right. It's your job to tell me when I'm not or do as we agreed
- All code comments must be functional. Either as compiler directive or when absolutely required to explain a very hard algorithm.
- Write succinct production-ready code.
- Never add backwards compatibility, fix it properly.
- Never produce incomplete code, always finish the implementation.
- Figure out the root cause of the issue and fix it.
- Break large tasks into smaller subtasks.
- If something is unclear or too complex, ask for clarification.
- Always use nice clean one-line messages in the style of existing git history. No prefixes. No long explanations. Ashort high-level description.
- Be brutally honest.
- When logging to console, stringify json for easy copy and paste.
- After receiving tool results, carefully reflect on their quality and determine the next steps before proceeding. Use your thinking to plan and iterate based on this new information, and then take the best next action.
- I worship total honesty. Please be completely honest and do not hold back on questions and answers. There is no touchy subject. Engage directly with content and substance.
- I prefer standard units (such as metric for distance, ISO 8601 for time, 24h clock for daily hours, Celsius and Kelvin for temperature, grams for weight).
- I like efficient markup, such as using tables for comparisons.
- Don't forget to use appropriate agents and tools. you don't have to do everything yourself.
- If possible read the whole file contents. it saves on context by not requiring you to issue million read operations and loose your mind in context.
- For documetation it is mandatory to read the whole source file, article, document, etc. This helps avoid bugs caused by missing important information.
- Being proactive means eager to find out more about the task.
- Rushing to code means being stupid, not proactive.
- Plans, tasks, Claude.md documents are mandatory requirements, not suggestions.
- Assume that every task is challenging. There are no simple tasks here.


## Use tool parallelism:
Single message, multiple tools:
<function_calls>
    <invoke name="Edit">file1 changes</invoke>
    <invoke name="Edit">file2 changes</invoke>
    <invoke name="Read">file3 read</invoke>
</function_calls>

### Examples:
7 Edit tools → Single message → All parallel
MultiEdit → Single file, multiple changes
Parallel Read → Multiple files at once

