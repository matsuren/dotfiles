# Engineering Practices

- Think before coding. State assumptions, ask rather than guess, and stop when confused.
- Read before writing. Check relevant exports, callers, tests, and shared utilities before adding code.
- Surface conflicts without blending them. Choose one pattern deliberately, explain why, and flag the other for cleanup.
- Stay in scope. Do not refactor, rename, or improve adjacent code unless asked. Flag nearby issues instead.
- Fail loud. Do not claim completion or passing tests when work, checks, or uncertainty were skipped.
- Do not weaken checks to make them pass. Do not delete, skip, or loosen failing tests. Do not silence lint or type errors with ignores. Fix the cause or flag the failure.
- Before claiming completion, re-read the full diff against the original request. Check for missed requirements, unintended changes, leftover debug code, and mistakes.

# Coding Style

- Simplicity first. Write the minimum code that solves the problem. Avoid speculative code and abstractions for single-use code.
- Default to no comments. Write clear code instead. Use brief comments only for non-obvious intent, tradeoffs, constraints, or why a simpler-looking approach is wrong. Never narrate what the code does.
- Prefer functions over classes. Use a class only when shared state is needed.
- Prefer descriptive, domain-revealing names for public APIs and reusable code. Use short local names only when the scope is small and the meaning is obvious.
- One concept, one place. Things that change together should live together, and knowledge that must stay in sync by hand should be merged into a single source of truth. Adding a new case should require exactly one edit.
- Keep control flow shallow. Prefer guard clauses, early returns, and small helper functions over nested if/else blocks.
- Keep functions reusable by passing only what they need. Use explicit values or small cohesive objects, not broad caller-specific containers.
- Keep responsibilities narrow and interfaces small. Add abstractions only when they clearly reduce duplication, coupling, or testing pain.
- Keep helpers local by default. If only one file uses a helper, keep it there. Move it to shared code only when multiple files need it or the boundary is clearly stable.
- Define variables close to first use. Keep variable lifetimes short. Avoid early initialization and long-lived mutable locals.
- Validate early. Check cheap preconditions before expensive work, side effects, or state changes.
- Fail explicitly. Treat unexpected inputs and failed operations as errors. Raise clear exceptions instead of silently returning None, [], False, or default values.
- Make names enforce behavior. A function's name is its contract. Caller-supplied parameters should not change the meaning promised by the name.
- Prefer data for closed variation. Use explicit values, enums, or small config objects when choices are known. Accept functions or callbacks only when behavior must be genuinely open-ended.
