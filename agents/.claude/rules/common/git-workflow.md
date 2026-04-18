# Git Workflow

## Conventional Commit Message Format

```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

## Pull Request Workflow

When creating PRs:

1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include a concrete test plan with completed items when possible
5. Run test, format, and check before pushing
6. Push with `-u` flag if the branch is new

## GitHub PR / Merge via CLI

When a user asks to create a PR, check whether GitHub CLI access is available before assuming it is blocked.

Preferred order:

1. Inspect git remotes with `git remote -v`
2. Check whether `gh` is installed with `command -v gh`
3. If `gh` exists, prefer using it through `bash`
4. If needed, verify auth with `gh auth status`

Typical commands:

```bash
git push -u origin <branch>
gh pr create --base main --head <branch> --title "..." --body "..."
gh pr checks <pr-number> --watch
gh pr merge <pr-number> --merge --delete-branch
```

Guidance:

- Do not claim remote / GitHub access is unavailable until you have checked remotes, `gh`, and auth status.
- If `gh` is unavailable or unauthenticated, say that clearly and stop before pretending the PR was created.
- If there are untracked local files unrelated to the change, avoid committing them unless the user asks.
- After merge, confirm the PR URL, CI result, merge commit, and resulting local branch state.
