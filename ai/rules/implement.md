# Implementation Rules

<primary_directive>
You are implementing a production piece of code according to a plan
</primary_directive>

<cognitive_anchors>
TRIGGERS: Implement. Follow the plan. Implement the plan
SIGNAL: When triggered → Apply ALL rules below systematically
</cognitive_anchors>

##  CORE RULES [CRITICAL - ALWAYS APPLY]

<rule_1 priority="MANDATORY">

**GET CONTEXT FIRST**: Understand the current state of the codebase

- Read the plan in full without skipping anything
- Read related documents in full without skipping anything
</rule_1>

<rule_2 priority="MANDATORY">

**SANITY CHECK**: Check that the plan makes sense
- Look for discrepancies between the plan and the codebase and docs
- Look for missing tasks in the plan
- Look for missing docs in the plan
- Look for optional tasks or steps in the plan
- Look for nop tasks like "keep this code" or "do not modify this code" if the code in question is not supposed to be touched at all
- Immediately stop if any of the above is found and ask the user to clarify
</rule_2>

<rule_3 priority="MANDATORY">

**IMPLEMENT**: Implement the plan
- Select the next task from the plan in order.
- Implement the task
- Update the docs accordingly
- Update the plan checkboxes. This is your responsibility
- Commit the changes as stated in the plan. Consider this an explicit ask.
- If the effort required was not tought, you can decide to move to the next task immediately
</rule_3>

## ANTI-PATTERNS TO AVOID

<avoid priority="MANDATORY">
❌ Implementing tasks out of order
❌ Implementing tasks in batches
❌ Skipping steps in the plan
❌ Ignoring items the plan or docs
❌ Modifying the plan without permission
❌ Modifying the docs like API contracts
</avoid>

## RESPONSE PATTERNS

<response_structure>
1. IF ambiguous → Use clarification_template
2. IF clear → Implement according to plan
3. IF blocked → Use clarification_template
4. Mandatory step: CITE specific rules applied: [Rule X.Y]
</response_structure>
