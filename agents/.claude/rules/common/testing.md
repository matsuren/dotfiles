# Testing

Before declaring a code change complete, giving final review, or recommending approval:

1. Identify the repo's canonical validation commands from project guidance, config, or CI workflows; do not assume fixed names like `make check`.
2. Unless the user explicitly asks to omit full validation, run them in full.
3. Use targeted checks only for iteration, debugging, or explicitly limited validation.
4. Report the exact commands run; if a canonical command was not run, say why.

Validation status:
- COMPLETE: full canonical validation was run and passed; or no canonical full-validation command exists and relevant focused checks were run and passed.
- FAILED: a required validation command was run and failed.
- OMITTED: full canonical validation was not run.
