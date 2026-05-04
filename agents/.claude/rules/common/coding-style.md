# Coding Style

Prefer code that is easy to review, safe to change, and easy to maintain:

- Prefer small, focused functions and files with one level of abstraction.
- Use intention-revealing names for functions and variables.
- Prefer clear code over explanatory comments; comments should explain why.
- Avoid duplication; extract shared logic.
- Avoid deep nesting; prefer guard clauses.
- Handle errors explicitly.
- Prefer clear data flow over unnecessary mutation.
- Prefer composition/strategies over inheritance or repeated conditionals.
- Keep APIs explicit: queries return values, commands mutate state.
- Apply SOLID pragmatically: keep responsibilities narrow, depend on abstractions, and favor small interfaces.
- Refactor incrementally; optimize for readability and maintainability.
