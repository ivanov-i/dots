---
name: reviewing-code
description: Use when reviewing code — applies a rigorous checklist and structured verdict to changes.
---

# Reviewing Code

## Overview
Apply an uncompromising standard. Every line matters. Assume failures happen at the worst time; prevent them in review.

## When to Use
- When reviewing code.

## Review Checklist
1. ☐ Context: read plan, docs, commits; scan layout/architecture
2. ☐ Sanity: verify plan vs code/docs alignment; stop and clarify on mismatches
3. ☐ Architecture: spot god objects, leaks, wrong abstractions, premature/missing optimizations
4. ☐ Bugs: races, deadlocks, off‑by‑one, nullability, resource leaks, TOCTOU
5. ☐ Security: injection, authz, secrets, randomness, side channels, SSRF/XXE
6. ☐ Performance: complexity bombs, N+1, blocking I/O, hot‑path allocs, regex traps
7. ☐ Patterns: TODO/FIXME/HACK, debug prints, ts-ignore, string concatenated SQL, swallowed exceptions
8. ☐ Code Quality: names, complexity, duplication, magic numbers, data clumps
9. ☐ Analysis: root causes; systemic issues and thinking errors

## Report Format
```
- verdict
- critical_failures
- severe_problems
- architectural_disasters
- performance_catastrophes
- security_vulnerabilities
- code_quality_violations
- root_cause_diagnosis
- mandatory_fixes
- the_standard
- final_judgment
```

## Verdict Scale
REJECTED | DANGEROUS | AMATEUR | MEDIOCRE | BARELY ACCEPTABLE | ACCEPTABLE

## Quick Reference Patterns
- Grep patterns to catch common issues (adapt to stack):
  - `TODO|FIXME|HACK|XXX`
  - `console\.log|print|fmt\.Print|puts|var_dump`
  - `password|secret|key|token.*=.*["']`
  - `exec|eval|system|shell_exec`
  - `SELECT.*\+|".*\+.*SELECT`
  - `catch\s*\(.*\)\s*{\s*}`
  - `Thread\.sleep|time\.sleep|sleep\(`
  - `new Date\(\)|Date\.now\(\)`
  - `@ts-ignore|@ts-nocheck`

## Response Pattern
1) If ambiguous → clarify
2) If clear → produce structured report with exact fixes
3) Cite which categories caught each issue
