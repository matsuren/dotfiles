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
- Use keyword arguments for all function calls except built-ins, standard-library APIs, and third-party APIs where positional use is idiomatic (e.g. `np.array([1, 3, 4])`, `len(x)`, `os.path.join(a, b)`).
