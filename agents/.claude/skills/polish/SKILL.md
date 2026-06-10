---
name: polish
description: Run the builtin /simplify and /code-review --fix commands together in one invocation. Use when the user asks to "polish" the changes, do a "full review", "review and simplify", "simplify and review", or wants both quality cleanup and a bug-hunting review of the current changes in a single pass.
---

# Polish

Run `simplify` then `code-review --fix` over the current diff, each in its own subagent via the Agent tool: `model: "sonnet"` for simplify, `model: "opus"` for code-review. Subagents share the working tree, so their fixes land directly. Forward any user arguments (effort level, `--comment`, PR number) to code-review on top of `--fix`.

## Steps

1. If there is nothing to review (no uncommitted changes, branch commits, or PR argument), say so and stop.
2. Sonnet subagent: invoke the `simplify` skill and apply its fixes. It must flag suspected bugs in its report instead of fixing them — a cleanup that silently changes behavior hides the bug from the reviewer.
3. After it finishes, Opus subagent: invoke `code-review` with `--fix` plus user arguments, giving it simplify's report so flagged or modified code gets extra attention. Never run the two subagents in parallel — both edit the same working tree, and running review second means the final state gets reviewed.
4. Report one combined summary: simplify's changes; review findings with severities and which were fixed; whether any finding touches code simplify modified; validation status (checks run and results). Don't deduplicate or soften findings between the passes — they look for different things.

Subagents start cold, so each prompt must include: the repo path and what the diff consists of; an instruction to invoke the named skill via the Skill tool rather than improvise a review; "do not commit anything"; and what to report back (changes per file, findings with severities, validation commands and results).
