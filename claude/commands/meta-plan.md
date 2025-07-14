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
- Find relevant code flows
- Identify database tables involved
- Understand existing patterns
- Look for similar features already implemented

### 1.3 Document Current State
- List the current flow step-by-step
- Identify exact files, forms, and statuses
- Note what works and what doesn't

## Phase 2: Solution Design

### 2.1 Study Similar Features
- Find comparable functionality that already works
- Note patterns used in the codebase
- Identify reusable components

### 2.2 Design the Solution
- Break down into logical phases
- Each phase should be independently verifiable
- Consider database changes separately from code changes

### 2.3 Identify Risks
- What could go wrong?
- What edge cases exist?
- What needs validation?

## Phase 3: Plan Structure

### 3.1 Context Section
Include:
- Problem explanation in simple terms
- Why the change is needed
- How to find relevant code
- Understanding of the system architecture

### 3.2 Rules and Restrictions
- Implementation rules (testing, commits)
- Forbidden practices (with examples)
- Validation requirements

### 3.3 Implementation Phases
Each phase needs:
- Clear explanation of WHY this change
- Exact files and changes
- Code snippets where helpful
- Verification steps

### 3.4 Validation Points
For each phase:
- Mandatory stop point
- Subagent review requirement
- Detailed testing steps
- Expected outcomes

## Phase 4: Writing the Plan

### 4.1 Structure Template
```markdown
# Implementation Plan: [Feature Name]

## Context and Problem Statement
### What is [Feature]?
### The Problem
### How to Find the Current Flow
### Understanding the [System Part]
### How [Similar Feature] Works

## Overview

## Important Rules

## FORBIDDEN: Things You Must NOT Do

## CRITICAL: Validation Requirements

## Phase N: [What This Phase Does]
### Why This Change?
### Task N.1: [Specific Task]
### Verification Point N - STOP HERE!
```

### 4.2 Writing Guidelines
- Be specific about file paths and line numbers
- Provide enough context for someone unfamiliar with the code
- Include examples of what NOT to do
- Make validation steps reproducible

### 4.3 Common Sections to Include
1. **Database migrations** - Always separate phase
2. **Code changes** - Group related changes
3. **Configuration** - If needed
4. **Testing** - Final validation phase

## Phase 5: Testing Documentation

### 5.1 Create Testing Document
- List all forms/tables involved
- Provide step-by-step testing scenarios
- Include database queries for verification
- Write in the language testers understand

### 5.2 Include What Can Be Customized
- Database fields that can be modified
- i18n entries
- Configuration options

## Checklist for Plan Completion

- [ ] Problem clearly explained
- [ ] Current state documented
- [ ] Solution broken into verifiable phases
- [ ] Each phase has clear WHY
- [ ] Forbidden practices listed
- [ ] Validation requirements explicit
- [ ] Subagent review included
- [ ] Testing document created
- [ ] All relevant files identified
- [ ] Examples provided where helpful

## Key Principles

1. **Never Assume - Always Ask** - If anything is unclear, ask the user for clarification
2. **Assume Zero Knowledge** - Explain everything as if the developer knows nothing about this part of the system
3. **Phases Must Be Independent** - Each phase should be committable and verifiable on its own
4. **No Implicit Steps** - Every action must be explicit
5. **Reproducible Validation** - Anyone should be able to verify the changes
6. **Prevent Scope Creep** - Be explicit about what NOT to do

## Common Pitfalls to Avoid

1. **Making Assumptions** - Guessing what the user wants instead of asking
2. **Vague Instructions** - "Update the service" vs "Add STATUS_NAME to line 24"
3. **Missing Context** - Not explaining why a change is needed
4. **Assuming Knowledge** - "Just add a button" vs explaining the entire form system
5. **No Validation Steps** - "It should work" vs specific testing instructions
6. **Allowing Scope Creep** - Not explicitly forbidding unrelated changes

## Example Research Commands

When researching for a plan, use:
```bash
# Find where a status is used
grep -r "STATUS_NAME" .

# Find forms related to a feature
find . -name "*.java" | xargs grep -l "FormName"

# Understand the flow
# Look at Service classes that handle the feature
# Check Repository classes for database queries
# Find existing similar handlers/buttons

# Check database structure
# Look for migration files that create relevant tables
# Find existing buttons/forms in migrations
```

## Final Notes

A good implementation plan:
- Can be followed by someone who has never seen the codebase
- Prevents common mistakes through explicit rules
- Has clear checkpoints for validation
- Results in minimal, focused changes
- Includes everything needed for testing