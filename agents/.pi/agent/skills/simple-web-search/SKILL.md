---
name: simple-web-search
description: Search the web via a local search tool. Use for current facts, source discovery, fact checking, citations, latest releases, release notes, changelogs, and version checks.
---

# Simple Web Search

Use when the user needs current public information or web citations.

## Search

Resolve paths relative to this skill directory, then run:

```bash
python3 scripts/search.py "<query>" --max-results 5
python3 scripts/search.py "coding trend news" --type news --time week --max-results 5
```

Useful filters: `--type web|news|images|videos`, `--time hour|day|week|month|year`.

Use the resolved absolute path to `scripts/search.py`; do not rely on the user's current working directory.

## Query

- Preserve the user's target.
- Prefer official sources: project site, docs, GitHub releases, official blog.
- If the target is unclear, ask one clarifying question.

## Workflow

1. Run the search command.
2. If output says `local Degoog is not running`, start the bundled local search tool:
   ```bash
   docker compose -f docker-compose.yml up -d degoog
   ```
   Resolve `docker-compose.yml` relative to this skill directory, then retry once.
3. If output says port `4444` is in use, do not start the tool; tell the user another program may be using the port.
4. If `items` is empty, retry once with a broader or more explicit query.
5. Use only URLs from `items[].url` as citations. Do not invent citations.

## Answer

- Summarize briefly.
- Include source URLs from `items[].url`.
- Say when results are uncertain or only indirect sources were found.

## Maintenance

Read `references/api.md` only when changing `scripts/search.py`, diagnosing odd results, or changing startup.
