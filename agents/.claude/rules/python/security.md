---
paths:
  - "**/*.py"
  - "**/*.pyi"
---

# Python Security

See [common/security.md](../common/security.md).

Prefer environment variables for secrets.
If static security scanning is needed, use `bandit -r src/`.
