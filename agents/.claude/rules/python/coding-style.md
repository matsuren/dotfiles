---
paths:
  - "**/*.py"
  - "**/*.pyi"
---

# Python Coding Style

- Follow PEP 8.
- Prefix module-internal names with `_`.
- Use type annotations on public function signatures.
- Use `uv` instead of `python` / `python3` when running project commands.
- Prefer repo-native format/lint/type-check commands; otherwise use `ruff format`, `ruff check`, and `mypy` or `ty`.
