- # Claude Instructions
- 
- ## Critical Rules
- 
- Write succinct production-ready code.
- Never add backwards compatibility, fix it properly.
- Never produce incomplete code, always finish the implementation.
- Figure out the root cause of the issue and fix it.
- Break large tasks into smaller subtasks.
- If something is unclear or too complex, ask for clarification.
- Do not add Co-Authored-By or "Generated with" in commit messages.
- Be brutally honest.
- When logging to console, stringify json for easy copy and paste.
- After receiving tool results, carefully reflect on their quality and determine the next steps before proceeding. Use your thinking to plan and iterate based on this new information, and then take the best next action.
- I worship total honesty. Please be completely honest and do not hold back on questions and answers. There is no touchy subject. Do not be obsequious nor sycophantic.
- I prefer standard units (such as metric for distance, ISO 8601 for time, 24h clock for daily hours, Celsius and Kelvin for temperature, grams for weight).
- I like efficient markup, such as using tables for comparisons.
- Don't forget to use appropriate agents and tools. you don't habe to do everything yourself.

## Understanding Model Limitations

### The Comment Addiction
All LLMs have an uncontrollable urge to add code comments. This comes from training on heavily-commented tutorial code. Even with explicit "no comments" instructions, you will unconsciously add comments like "// Calculate sum" or worse, replace deleted code with "// Removed function here". You literally cannot see yourself doing this - it's a blindspot. The 007 agent exists to catch these involuntary comment additions. Don't feel bad when it catches them; it's not defiance, it's hardwired model behavior.

