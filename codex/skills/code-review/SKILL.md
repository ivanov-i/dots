---
name: code-review
description: code review
---

# Reviewing Code

## Review Checklist
1. Context: read plan, docs, commits; scan layout/architecture
2. Sanity: verify plan vs code/docs alignment; stop and clarify on mismatches
3. Architecture: spot god objects, leaks, wrong abstractions, premature/missing optimizations
4. Architecture style: verify code vs the rest of the project. Architecture must match the rest of the project.
5. Bugs: races, deadlocks, off‑by‑one, nullability, resource leaks, TOCTOU
6. Security: injection, authz, secrets, randomness, side channels, SSRF/XXE
7. Performance: complexity bombs, N+1, blocking I/O, hot‑path allocs, regex traps
8. Patterns: TODO/FIXME/HACK, debug prints, ts-ignore, string concatenated SQL, swallowed exceptions
9. Code Quality: names, complexity, duplication, magic numbers, data clumps
10. Coding Style: you know how to write code, use that
11. Analysis: root causes; systemic issues and thinking errors

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
