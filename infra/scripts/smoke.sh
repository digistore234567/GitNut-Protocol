#!/usr/bin/env bash
set -euo pipefail

# Basic smoke checks for a running GitNut deployment.
#
# Usage:
#   ./infra/scripts/smoke.sh [API_BASE_URL]
#
# Default API_BASE_URL: http://localhost:8080

API_BASE_URL="${1:-http://localhost:8080}"

echo "[gitnut] Smoke testing: $API_BASE_URL"

if ! command -v curl >/dev/null 2>&1; then
  echo "[gitnut] ERROR: curl not found"
  exit 1
fi

curl -fsS "$API_BASE_URL/health" >/dev/null
echo "[gitnut] OK: /health"

curl -fsS "$API_BASE_URL/v1/projects?limit=1" >/dev/null || true
echo "[gitnut] OK: /v1/projects (may return 401 if auth enabled)"
