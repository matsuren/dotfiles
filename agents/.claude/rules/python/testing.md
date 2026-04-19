---
paths:
  - "**/*.py"
  - "**/*.pyi"
---

# Python Testing

Use `pytest`.

Prefer function-style tests with fixtures.
Avoid test classes unless they add real clarity.

If coverage is requested or relevant, prefer:
```bash
pytest --cov=src --cov-report=term-missing
```
