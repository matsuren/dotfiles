# Testing

Before declaring a code change complete, giving final review, or recommending approval:

1. Identify the repo's canonical validation commands from project guidance/config.
2. Prefer project-native commands; do not assume fixed names like `make check`.
3. Unless the user explicitly asks to omit full validation, run the repo's full canonical validation commands.
4. Use targeted checks only for iteration, debugging, or when the user explicitly asks for limited validation.
5. Report the exact commands run.
6. If a canonical command was not run, say why.

Validation status:
- COMPLETE: full canonical validation was run and passed; or no canonical full-validation command exists and relevant focused checks were run and passed.
- FAILED: a required validation command was run and failed.
- OMITTED: full canonical validation was not run.
