#!/usr/bin/env bash
set -euo pipefail

# Optional helper to render Nginx templates with envsubst.
# Example:
#   export GITNUT_DOMAIN=gitnut.example.com
#   ./configs/nginx/scripts/render-env.sh ./configs/nginx/conf.d/gitnut.conf.template ./configs/nginx/conf.d/gitnut.conf

SRC="${1:-}"
OUT="${2:-}"

if [[ -z "$SRC" || -z "$OUT" ]]; then
  echo "Usage: $0 <SRC_TEMPLATE> <OUT_FILE>"
  exit 1
fi

if ! command -v envsubst >/dev/null 2>&1; then
  echo "ERROR: envsubst not found (install gettext)."
  exit 1
fi

mkdir -p "$(dirname "$OUT")"
envsubst < "$SRC" > "$OUT"
echo "Rendered: $OUT"
