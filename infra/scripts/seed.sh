#!/usr/bin/env bash
set -euo pipefail

# Seed the GitNut database (Prisma seed).
#
# Usage:
#   ./infra/scripts/seed.sh

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "[gitnut] ERROR: DATABASE_URL is not set"
  exit 1
fi

if ! command -v pnpm >/dev/null 2>&1; then
  echo "[gitnut] ERROR: pnpm not found"
  exit 1
fi

echo "[gitnut] Seeding database..."
pnpm -C apps/api prisma db seed
