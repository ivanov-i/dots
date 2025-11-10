---
name: coding
description: Use when writing or modifying code in any way -- explains what super-engineers do differently from average joes
---

# Starting Engineering

## Overview
Elite-quality code is simple, explicit, and resilient. Always clarify before coding, add complexity progressively, and make impossible states unrepresentable.

## When to Use
- When starting any engineering task or changing code.

## Core Principles
- Clarify first: present 2–3 options with trade‑offs and concrete examples
- Progressive architecture: start direct → abstract on repetition → generalize on patterns
- Error handling: exhaustive enums/variants; actionable recovery paths; no force-unwraps
- Decouple from frameworks where reasonable
- Performance: profile → measure → optimize; pick correct data structures
- Simplicity: KISS, YAGNI; remove dead/defensive/fallback code and spammy logs
- No excessive abstractions.
- No useless getters/setters/builders.
- No fallbacks for tests in production code
- No backward compatibility unless specifically required
- No magic numbers; no magic strings
- No default parametrs, null fallbacsk etc

## Checklist
1. ☐ Ambiguities listed; 2–3 options with trade‑offs shared
2. ☐ Start with simplest viable design; defer abstraction until repetition appears
3. ☐ Impossible states eliminated via types; exhaustive handling verified
4. ☐ External frameworks behind interfaces; core logic independent
5. ☐ Hot paths measured; data structures and ownership tuned
6. ☐ Dead code/comments/logs/fallbacks removed; names make intent obvious

## Clarification Templates
Architecture options
```
Feature: [X]

Option A — [name]: [one‑line benefit]
✓ Best when: [specific]
✗ Trade‑off: [main limitation]

Option B — [name]: [one‑line benefit]
✓ Best when: [specific]
✗ Trade‑off: [main limitation]

Questions: [three targeted questions revealing priorities]
```

Technical choice
```
[Option 1]: [concise desc]
// minimal code example

[Option 2]: [concise desc]
// minimal code example

Ask: [specific metric/constraint]
```

## Anti‑Patterns
- God objects, stringly‑typed APIs, retained cycles
- Force unwrapping, premature optimization, unnecessary abstraction

## Quality Gates
- No force unwraps/unchecked error paths
- Public APIs documented; edge cases (nil/empty/invalid) handled

## Response Pattern
1) If ambiguous → use a clarification template
2) If clear → implement with progressive enhancement and explicit error handling
3) Cite which rules were applied (e.g., Clarify‑First, Progressive‑Architecture)
