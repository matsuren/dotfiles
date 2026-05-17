#!/usr/bin/env python3
import argparse
import errno
import json
import os
import socket
import sys
import urllib.error
import urllib.parse
import urllib.request
from http.client import RemoteDisconnected


DEFAULT_BASE_URL = "http://localhost:4444"


def search_fields(args):
    fields = {
        "type": args.type,
        "page": args.page,
    }
    if args.lang:
        fields["lang"] = args.lang
    if args.time:
        fields["time"] = args.time
    if args.date_from:
        fields["dateFrom"] = args.date_from
    if args.date_to:
        fields["dateTo"] = args.date_to
    return fields


def request_json(args):
    base_url = args.base_url.rstrip("/")
    headers = {
        "Accept": "application/json",
        "User-Agent": args.user_agent,
    }
    fields = search_fields(args)

    if args.engine:
        url = f"{base_url}/api/search"
        body = {"query": args.query, **fields}
        body["engines"] = args.engine
        data = json.dumps(body).encode("utf-8")
        headers["Content-Type"] = "application/json"
        req = urllib.request.Request(url, data=data, headers=headers, method="POST")
    else:
        params = {"q": args.query, **fields}
        url = f"{base_url}/api/search?{urllib.parse.urlencode(params)}"
        req = urllib.request.Request(url, headers=headers)

    with urllib.request.urlopen(req, timeout=args.timeout) as res:
        return json.load(res)


def uses_default_local_engine(base_url):
    parsed = urllib.parse.urlparse(base_url)
    return (
        parsed.scheme == "http"
        and parsed.hostname in {"localhost", "127.0.0.1"}
        and (parsed.port or 80) == 4444
    )


def port_is_free(host="127.0.0.1", port=4444):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sock.bind((host, port))
        return True
    except PermissionError:
        return None
    except OSError:
        return False
    finally:
        sock.close()


def connection_refused(exc):
    reason = getattr(exc, "reason", exc)
    err_no = getattr(reason, "errno", None)
    if err_no in {errno.ECONNREFUSED, 61, 111}:
        return True
    text = str(exc)
    return "Connection refused" in text or "Errno 61" in text or "Errno 111" in text


def local_engine_error(base_url, original_error):
    if not uses_default_local_engine(base_url):
        return str(original_error)

    if connection_refused(original_error):
        return (
            "local Degoog is not running; from this skill directory run "
            "`docker compose -f docker-compose.yml up -d degoog`, then retry"
        )

    port_free = port_is_free()
    if port_free is False:
        return (
            "port 4444 is in use, but Degoog /api/search did not return valid results; "
            "another program may be using the port, or Degoog is unhealthy"
        )

    return (
        "local Degoog is not running; from this skill directory run "
        "`docker compose -f docker-compose.yml up -d degoog`, then retry"
    )


def normalize(data, limit):
    if not isinstance(data, dict):
        raise ValueError(f"expected JSON object from Degoog, got {type(data).__name__}")

    results = data.get("results") or []
    if not isinstance(results, list):
        raise ValueError("expected `results` to be an array")

    items = []
    for result in results[:limit]:
        if not isinstance(result, dict):
            continue
        items.append(
            {
                "title": result.get("title") or "",
                "url": result.get("url") or "",
                "snippet": result.get("snippet") or "",
                "source": result.get("source") or "",
                "score": result.get("score"),
                "sources": result.get("sources") or [],
            }
        )

    return {
        "query": data.get("query") or "",
        "type": data.get("type") or "",
        "items": items,
        "relatedSearches": data.get("relatedSearches") or [],
        "engineTimings": data.get("engineTimings") or [],
        "totalTime": data.get("totalTime"),
        "backend_note": "Degoog /api/search ranked metasearch results.",
    }


def main():
    parser = argparse.ArgumentParser(
        description="Search through a Degoog instance.",
        epilog=(
            "examples:\n"
            '  python3 scripts/search.py "pi web search" --max-results 5\n'
            '  python3 scripts/search.py "openai news" --type news --time week\n'
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("query")
    parser.add_argument(
        "--base-url", default=os.environ.get("DEGOOG_BASE_URL", DEFAULT_BASE_URL)
    )
    parser.add_argument(
        "--type", choices=["web", "images", "videos", "news"], default="web"
    )
    parser.add_argument("--page", type=int, default=1)
    parser.add_argument(
        "--time",
        choices=["any", "hour", "day", "week", "month", "year", "custom"],
        default="",
    )
    parser.add_argument("--date-from", default="")
    parser.add_argument("--date-to", default="")
    parser.add_argument("--lang", default="")
    parser.add_argument("--engine", action="append", default=[])
    parser.add_argument("--max-results", type=int, default=8)
    parser.add_argument("--timeout", type=float, default=30)
    parser.add_argument(
        "--user-agent",
        default=os.environ.get("SIMPLE_WEB_SEARCH_UA", "pi-simple-web-search/1.0"),
    )
    parser.add_argument("--raw", action="store_true")
    args = parser.parse_args()

    if args.page < 1 or args.page > 10:
        print(
            json.dumps(
                {
                    "query": args.query,
                    "error": "--page must be between 1 and 10",
                    "items": [],
                },
                indent=2,
            )
        )
        return 2
    if args.time == "custom" and not (args.date_from and args.date_to):
        print(
            json.dumps(
                {
                    "query": args.query,
                    "error": "--time custom requires --date-from and --date-to",
                    "items": [],
                },
                indent=2,
            )
        )
        return 2
    if args.time != "custom" and (args.date_from or args.date_to):
        print(
            json.dumps(
                {
                    "query": args.query,
                    "error": "--date-from and --date-to require --time custom",
                    "items": [],
                },
                indent=2,
            )
        )
        return 2

    try:
        data = request_json(args)
    except urllib.error.HTTPError as exc:
        try:
            detail = exc.read().decode("utf-8")
        except Exception:
            detail = str(exc)
        if exc.code == 401:
            message = "HTTP 401: Degoog API key protection is enabled; disable protection for localhost or configure a local instance without it"
        else:
            message = f"HTTP {exc.code}: {detail}"
        print(
            json.dumps({"query": args.query, "error": message, "items": []}, indent=2)
        )
        return 1
    except (
        urllib.error.URLError,
        TimeoutError,
        ConnectionError,
        RemoteDisconnected,
        json.JSONDecodeError,
    ) as exc:
        print(
            json.dumps(
                {
                    "query": args.query,
                    "error": local_engine_error(args.base_url, exc),
                    "items": [],
                },
                indent=2,
            )
        )
        return 1
    except Exception as exc:
        print(
            json.dumps({"query": args.query, "error": str(exc), "items": []}, indent=2)
        )
        return 1

    try:
        output = data if args.raw else normalize(data, max(1, args.max_results))
    except Exception as exc:
        print(
            json.dumps({"query": args.query, "error": str(exc), "items": []}, indent=2)
        )
        return 1

    print(json.dumps(output, indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
