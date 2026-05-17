# API Notes

Official references:

- API: https://degoog-org.github.io/degoog/api.html
- Environment variables: https://degoog-org.github.io/degoog/env.html
- Search engines: https://degoog-org.github.io/degoog/engines.html
- Runtime/Docker notes: https://github.com/degoog-org/degoog

- Default base URL: `http://localhost:4444`; override with `DEGOOG_BASE_URL` or `--base-url`.
- Local startup uses this skill's `docker-compose.yml`: `docker compose -f docker-compose.yml up -d degoog`.
- `scripts/search.py` never starts Docker; it only searches and reports whether local startup is needed.
- If port `4444` is occupied and `/api/search` does not return valid JSON, report the conflict instead of starting Degoog.
- API-key protection is intentionally unsupported; use a local Degoog instance without API-key protection.
- GET `/api/search?q=<query>&type=web&page=1` returns JSON.
- POST `/api/search` accepts JSON with `query`, `type`, `page`, `lang`, `time`, `dateFrom`, `dateTo`, and `engines`.
- Types: `web`, `images`, `videos`, `news`.
- Time filters: `any`, `hour`, `day`, `week`, `month`, `year`, `custom`.
- Useful response fields: `results[].title`, `results[].url`, `results[].snippet`, `results[].source`, `results[].score`, `relatedSearches`, `engineTimings`, `totalTime`.
