# Git Workflow

- Never commit directly to `main` or `master`.
- Make changes on a branch.
- For new features, prefer `feature/<name>`.
- For bug fixes, prefer `fix/<name>`.
- Use a worktree when the user asks.
- Keep changes small, safe, and focused.
- Keep commits atomic.
- Only commit files you changed in this session.
- Do not modify unrelated files.
- Before push or PR, run the repo's canonical validation commands per [testing.md](testing.md).

Never run destructive git commands unless explicitly asked:

- `git reset --hard`
- `git clean -fd`
- `git push --force`

## Commit Messages

Use conventional commits when making commits:

- Use imperative mood
- Keep one logical change per commit
- Use scope when helpful
- Examples:
  - feat: add websocket bridge
  - fix(cli): handle missing file path
  - feat(api)!: send an email to the customer when a product is shipped

## Pull Requests

When creating a PR:

1. Review the full diff against the base branch.
2. Summarize the change clearly.
3. Include a concrete test plan when possible.
4. Check whether GitHub CLI is available before claiming PR creation is blocked:
   - `git remote -v`
   - `command -v gh`
   - `gh auth status` if needed
5. Verify the PR is merged before attempting branch cleanup, because the remote branch may already have been auto-deleted.
