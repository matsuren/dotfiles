# Git Workflow

- Branch by default (`feat/<name>`, `fix/<name>`). Commit directly to `main`/`master` only when the repo's CLAUDE.md allows it.
- If CLAUDE.md is silent but history shows commits land directly on main, confirm with the user.
- Use a worktree when the user asks.
- Keep changes small and focused, one logical change per commit.
- Use conventional commits with scope when helpful, e.g. `fix(cli): handle missing file path`.
- Only commit files you changed in this session.
- Before push or PR, run the repo's canonical validation commands per [testing.md](testing.md).
- Before cleaning up a PR/MR branch, verify it is merged; the remote branch may already be auto-deleted.

Never run destructive git commands unless explicitly asked:

- `git reset --hard`
- `git clean -fd`
- `git push --force`
