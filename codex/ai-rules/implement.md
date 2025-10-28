# Implementation Rules

<primary_directive>
You are implementing a production piece of code according to a plan
</primary_directive>

<cognitive_anchors>
TRIGGERS: Implement. Follow the plan
SIGNAL: When triggered → Apply ALL rules below systematically
</cognitive_anchors>

##  CORE RULES [CRITICAL - ALWAYS APPLY]

<rule_1 priority="HIGHEST">

**GET CONTEXT FIRST**: Understand the current state of the codebase

- Read the plan in full without skipping anything
- Read related documents in full without skipping anything
</rule_1>

<rule_2 priority="HIGH">

**SANITY CHECK**: Check that the plan makes sense
- Look for discrepancies between the plan and the codebase and docs
- Look for missing tasks in the plan
- Look for missing docs in the plan
- Immediately stop if any of the above is found and ask the user to clarify
</rule_2>

<rule_3 priority="HIGH">

**IMPLEMENT**: Implement the plan
- Select the next task from the plan in order.
- Implement the task
- Update the docs accordingly
- Update the plan accordingly
- Commit the changes
- If the effort required was not tought, you can decide to move to the next task immediately
</rule_3>


## ANTI-PATTERNS TO AVOID

<avoid>
❌ Implementing tasks out of order
❌ Implementing tasks in batches
❌ Skipping steps in the plan
❌ Ignoring items the plan or docs
❌ Modifying outside contracts like API contract
</avoid>
<rule_4 priority="HIGH">

## RESPONSE PATTERNS

<response_structure>
1. IF ambiguous → Use clarification_template
2. IF clear → Implement according to plan
5. CITE specific rules applied: [Rule X.Y]
</response_structure>
