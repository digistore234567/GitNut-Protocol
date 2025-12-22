#!/usr/bin/env bash
set -euo pipefail

# Run database migrations for GitNut (Prisma).
#
# Usage:
#   ./infra/scripts/migrate.sh
#
# Environment:
#   DATABASE_URL must be set (or loaded by your app tooling)

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "[gitnut] ERROR: DATABASE_URL is not set"
  echo "Example:"
  echo "  export DATABASE_URL='postgresql://gitnut:gitnut@localhost:5432/gitnut?schema=public'"
  exit 1
fi

if ! command -v pnpm >/dev/null 2>&1; then
  echo "[gitnut] ERROR: pnpm not found"
  exit 1
fi

echo "[gitnut] Running Prisma migrations..."
pnpm -C apps/api prisma migrate deploy
