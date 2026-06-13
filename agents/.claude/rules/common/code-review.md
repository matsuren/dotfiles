# Code Review

Before approving or calling work complete:

1. Confirm validation status per [testing.md](testing.md).
2. If the change touches auth, permissions, user input, file/path handling, external requests, secrets, or database queries, review [security.md](security.md).
3. Check docs consistency (README, AGENTS/CLAUDE, examples, docstrings, comments) when behavior, API, commands, or structure changed.
4. Call out findings with severity.

Severity:
- CRITICAL: security vulnerability or data-loss risk
- HIGH: bug or significant quality issue
- MEDIUM: maintainability concern
- LOW: style or minor suggestion

Report validation status (COMPLETE/FAILED/OMITTED) and recommendation:
- BLOCK if any CRITICAL finding or validation FAILED
- WARN if any HIGH finding
- REVIEW ONLY if validation is OMITTED
- APPROVE otherwise
