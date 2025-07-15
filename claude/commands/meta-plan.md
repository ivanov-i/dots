# Meta-Plan: How to Create an Implementation Plan

## Purpose
This document describes how to create detailed implementation plans for software development tasks.

## Phase 1: Problem Understanding and Research

### 1.1 Understand the Problem
**CRITICAL: Never guess or assume. If anything is unclear, ask questions.**

Examples of questions to ask when needed:
- If the task is vague: "What exactly needs to be implemented?"
- If the reason is unclear: "Why is this change needed?"
- If constraints are unknown: "Are there any specific requirements I should follow?"
- If the scope is ambiguous: "What should and shouldn't be changed?"

Only proceed when you have a clear understanding of the task. Don't make assumptions about what the user wants.

### 1.2 Research Current Implementation
**CRITICAL: Research exhaustively. The quality of your plan depends on understanding the current system.**

Research strategy:
1. **Find all occurrences** - Don't stop at the first match
   ```bash
   # Search for enums, constants, hardcoded values
   grep -r "CONSTANT_NAME" src/
   
   # Find all forms and handlers
   grep -r "FormName" src/
   
   # Search in migrations too
   grep -r "pattern" src/main/resources/db/migration/
   ```

2. **Trace the complete flow** - From user action to database
   - Start with UI (forms, buttons)
   - Follow through handlers
   - Check services and repositories
   - Verify database structure

3. **Count hardcoded occurrences** - Know exactly how many places need changes
   - Document each location with file and line number
   - Understand what each does

4. **Identify patterns** - How does the system handle similar cases?
   - Look for existing dynamic/configurable features
   - Note database-driven vs code-driven logic

### 1.3 Document Current State
Document findings with concrete evidence:
- Exact file paths and line numbers
- Current behavior with examples
- Database schema and sample data
- Number of hardcoded occurrences found

### 1.4 Understand System Architecture
Before proposing changes, understand:
- **Entities vs Configurations** - What's an entity (payment_mode) vs saved data (payment_method)
- **Form System** - How forms, buttons, and handlers work together
- **Database-Driven Features** - What's configurable vs hardcoded
- **Existing Patterns** - How similar features are implemented

## Phase 2: Solution Design

### 2.1 Choose the Right Approach
**CRITICAL: Prefer configuration over code changes.**

Decision tree:
1. Can it be solved with database configuration? → Do that
2. Can we reuse existing patterns? → Copy them
3. Do we need new abstractions? → Usually NO
4. Should we modify enums/constants? → Almost never

### 2.2 Design Principles
1. **Minimal Code Changes** - Less code = fewer bugs
2. **Database-Driven** - Configuration in DB allows runtime changes
3. **Reuse Infrastructure** - Don't create new handlers if existing ones work
4. **Preserve Compatibility** - Existing functionality must not break

### 2.3 Solution Pattern Selection
Common patterns and when to use them:
- **Replace Hardcoded Checks** → Use database fields
- **Add New Types** → Use database entries, not enum values
- **Dynamic Behavior** → Add configuration columns
- **Multiple Variants** → Use name/alias pattern

### 2.4 Phase Breakdown Strategy
1. **Database First** - Schema changes before code
2. **One Check at a Time** - Replace hardcoded checks individually
3. **Preserve Working State** - System works after each phase
4. **Test Infrastructure Last** - Add examples/tests after core changes

## Phase 3: Plan Structure

### 3.1 Context Section
Must include:
1. **What It Is** - Explain the feature in simple terms
2. **The Problem** - Why change is needed (business reason)
3. **Current Limitations** - Concrete examples with code/data
4. **How to Find It** - Exact search commands that reveal the issue

Example:
```markdown
### The Problem
Currently only ONE manual payment system exists (MODERATED with hardcoded card number).

Current limitations:
- `PaymentModeName.MODERATED` is hardcoded in 5 places
- Only one set of requisites (hardcoded in i18n)
- Cannot add new manual payment systems without code changes
```

### 3.2 Implementation Phases
Structure phases by:
1. **Database migrations** - Always first
2. **Replace hardcoded check #1** - One at a time
3. **Replace hardcoded check #2** - Continue systematically
4. **Add examples/tests** - After core functionality works

Each phase must include:
- **Why This Change?** - Business/technical reason
- **Current Code** - Show exact code being replaced
- **New Code** - Show exact replacement
- **Imports/Fields** - Don't forget these!

### 3.3 Code Examples
Always show before/after:
```markdown
**Current code** (around line 95):
```java
if (paymentModeName == PaymentModeName.MODERATED) {
    return ctx.withForm(PUT_MONEY_MODERATED_PAYMENT_REQUISITES_FORM.getName());
}
```

**Change to**:
```java
PaymentMode paymentMode = paymentModeRepository.findByTenantAndName(tenant, paymentModeName);
if (paymentMode.getDepositRequisitesFormName() != null) {
    return ctx.withForm(paymentMode.getDepositRequisitesFormName());
}
```
```

### 3.4 Validation Requirements
Make validation concrete and actionable:
```markdown
**VALIDATION STEPS**:
```
To validate Phase 2:
1. Check ReplenishmentRequestService changes:
   - Uses paymentModeRepository to find payment mode
   - Gets status from deposit_initial_status field
   - Falls back to WAITING if null
2. Test MODERATED still works:
   - Create manual payment request
   - Check database: SELECT status FROM replenishment_request WHERE ...
   - Status should be MANUAL_PAYMENT_CONFIRMATION
```
```

## Phase 4: Writing the Plan

### 4.1 Structure Template
```markdown
# Implementation Plan: [Feature Name]

## Implementation Recommendations (Lessons Learned)
### Key Patterns to Follow
[Document patterns specific to this implementation]

### Critical Understanding
[Key concepts the implementer must understand]

## Context and Problem Statement
### What is [Feature]?
### The Problem
### How to Find the Current Flow
### Understanding the Current Implementation
### How [Goal Feature] Works

## Overview
[One paragraph summary]

## Important Rules
[Standard rules about testing, commits, etc.]

## FORBIDDEN: Things You Must NOT Do
[Specific forbidden actions with examples]

## CRITICAL: Validation Requirements
[Detailed validation process]

## Phase N: [Descriptive Phase Title]
### Why This Change?
### Task N.1: [Specific task]
### Verification Point N - STOP HERE!
```

### 4.2 Writing Style Guidelines
1. **Be Specific** - "around line 95" not "in the method"
2. **Show Evidence** - "hardcoded in 5 places" with list
3. **Explain Decisions** - Why this approach over alternatives
4. **Include Queries** - Actual SQL to verify changes
5. **Think Like QA** - How would someone test this?

### 4.3 Common Sections to Include
1. **Database changes** - Schema, data, migrations
2. **Each hardcoded replacement** - Separate phases
3. **Configuration examples** - Show it works
4. **Admin guide** - How to use the feature

## Phase 5: Testing Documentation

### 5.1 Create Separate Testing Document
Create `[feature]-testing-guide.md` with:
1. **Overview** - What changed in user terms
2. **Prerequisites** - What needs to be set up
3. **Test Scenarios** - Step-by-step user actions
4. **Verification Queries** - SQL to check results
5. **Common Issues** - What might go wrong
6. **Admin Guide** - How to configure feature

### 5.2 Testing Checklist Format
```markdown
## Testing Checklist
- [ ] Original functionality still works
- [ ] New functionality works as designed
- [ ] Edge cases handled
- [ ] Database integrity maintained
- [ ] No hardcoded values remain
```

## Research Techniques

### Finding Hardcoded Values
```bash
# Find enum usage
grep -r "EnumName\." src/

# Find specific enum values
grep -r "EnumName\.VALUE" src/

# Find in specific file types
find . -name "*.java" -exec grep -l "PATTERN" {} \;

# Count occurrences
grep -r "PATTERN" src/ | wc -l

# Find with context
grep -r -B3 -A3 "PATTERN" src/
```

### Understanding Database Structure
```bash
# Find table creation
grep -r "CREATE TABLE table_name" src/main/resources/db/migration/

# Find column additions
grep -r "ALTER TABLE.*ADD COLUMN" src/main/resources/db/migration/

# Find data insertions
grep -r "INSERT INTO table_name" src/main/resources/db/migration/
```

### Tracing Code Flow
1. Start with forms/UI
2. Find handlers
3. Trace to services
4. Check repositories
5. Verify database

## Quality Checklist for Plan

### Research Quality
- [ ] Found ALL hardcoded occurrences (with count)
- [ ] Understood complete flow (UI to DB)
- [ ] Identified similar patterns in codebase
- [ ] Documented current limitations with evidence

### Solution Quality
- [ ] Chose simplest approach (configuration over code)
- [ ] Reused existing infrastructure
- [ ] Maintained backward compatibility
- [ ] Made feature configurable not hardcoded

### Plan Quality
- [ ] Phases are independent and verifiable
- [ ] Each phase has clear "why"
- [ ] Code examples show before/after
- [ ] Validation steps are concrete
- [ ] Forbidden practices explicitly listed

### Documentation Quality
- [ ] Context explains business need
- [ ] Testing guide created separately
- [ ] Admin configuration documented
- [ ] Common issues addressed

## Key Principles (Updated)

1. **Research Exhaustively** - Find ALL occurrences, not just first one
2. **Configuration Over Code** - Database-driven is always better
3. **Show Evidence** - "5 hardcoded checks" not "several places"
4. **One Change Per Phase** - Makes debugging easier
5. **Preserve Compatibility** - Existing functionality must not break
6. **Think Like QA** - Include specific test scenarios
7. **Document for Admins** - Show how to use the feature

## Common Pitfalls to Avoid (Updated)

1. **Incomplete Research** - Missing some hardcoded occurrences
2. **Over-Engineering** - Creating abstractions instead of using DB
3. **Breaking Changes** - Not preserving existing functionality
4. **Vague Validation** - "Test it works" vs specific SQL queries
5. **Missing Imports** - Forgetting to document required imports
6. **No Admin Guide** - Not explaining how to use feature
7. **Enum Modifications** - Adding enum values instead of DB entries

## Final Notes

A good implementation plan:
- Shows you found ALL occurrences of the problem
- Provides evidence for every claim
- Chooses configuration over code changes
- Includes concrete validation queries
- Documents how admins will use the feature
- Results in minimal code changes
- Makes the system more flexible, not more complex