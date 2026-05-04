#!/usr/bin/env bash
set -euo pipefail
URL="${1:?usage: tests/smoke.sh <tweet-url>}"
OUT="${TMPDIR:-/tmp}/tweetshot-smoke"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ANALYZE_FLAG=("--analyze-prompt")
if [[ "${TWEETSHOT_ANALYZE:-0}" == "1" ]]; then
  ANALYZE_FLAG=("--analyze")
fi

JSON="$("$SCRIPT_DIR/../tweetshot" "$URL" --frames 3 --out "$OUT" "${ANALYZE_FLAG[@]}")"
jq -e '.source_url and (.media_count >= 0) and .output_dir and .analysis_prompt' <<< "$JSON" >/dev/null
if [[ "${TWEETSHOT_ANALYZE:-0}" == "1" ]]; then
  jq -e '.analysis' <<< "$JSON" >/dev/null
fi
printf '%s\n' "$JSON"
