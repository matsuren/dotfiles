# Code Review

Before approving or calling work complete:

1. Read the diff.
2. Confirm validation status per [testing.md](testing.md).
3. If the change touches auth, permissions, user input, file/path handling, external requests, secrets, or database queries, review [security.md](security.md).
4. Check:
   - correctness
   - tests
   - docs consistency (README, AGENTS/CLAUDE, examples) when behavior, API, commands, or structure changed
   - code shape per [coding-style.md](coding-style.md)
5. Call out findings with severity.

Severity:
- CRITICAL: security vulnerability or data-loss risk -> BLOCK
- HIGH: bug or significant quality issue -> WARN
- MEDIUM: maintainability concern -> INFO
- LOW: style or minor suggestion -> NOTE

Report both:
- Validation: COMPLETE, FAILED, or OMITTED
  - name the canonical checks you identified
  - name which were run, failed, or omitted
- Recommendation:
  - BLOCK if any CRITICAL finding or validation FAILED
  - WARN if any HIGH finding
  - REVIEW ONLY if validation is OMITTED
  - APPROVE otherwise
