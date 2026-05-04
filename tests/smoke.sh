#!/usr/bin/env bash
set -euo pipefail
URL="${1:?usage: tests/smoke.sh <tweet-url>}"
OUT="${TMPDIR:-/tmp}/tweetshot-smoke"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
JSON="$("$SCRIPT_DIR/../tweetshot" "$URL" --frames 3 --out "$OUT" --analyze-prompt)"
jq -e '.source_url and (.media_count >= 0) and .output_dir and .analysis_prompt' <<< "$JSON" >/dev/null
printf '%s\n' "$JSON"
