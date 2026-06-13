# Security

- Never hardcode secrets; use environment variables or a secret manager.
- Never pass user input unsanitized to shell commands, SQL queries, or file paths.

If a security issue is found: STOP, assess severity, fix CRITICAL issues first, rotate any
exposed secrets, scan for similar issues. For a full audit, run `/security-review`.
