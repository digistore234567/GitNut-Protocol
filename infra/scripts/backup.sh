#!/usr/bin/env bash
set -euo pipefail

# GitNut backup script:
# - dumps Postgres
# - optionally syncs MinIO/S3 buckets (requires awscli or mc)
#
# Usage:
#   ./infra/scripts/backup.sh <OUTPUT_DIR>
#
# Environment:
#   DATABASE_URL       required (for pg_dump)
#   S3_ENDPOINT        optional
#   S3_ACCESS_KEY      optional
#   S3_SECRET_KEY      optional
#   S3_BUCKET_ARTIFACTS optional
#   S3_BUCKET_ATTESTATIONS optional

OUT="${1:-}"
if [[ -z "$OUT" ]]; then
  echo "Usage: $0 <OUTPUT_DIR>"
  exit 1
fi

mkdir -p "$OUT"

if ! command -v pg_dump >/dev/null 2>&1; then
  echo "[gitnut] ERROR: pg_dump not found. Install postgresql client tools."
  exit 1
fi

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "[gitnut] ERROR: DATABASE_URL is not set"
  exit 1
fi

TS="$(date -u +%Y%m%dT%H%M%SZ)"
DB_OUT="$OUT/gitnut-db-$TS.sql.gz"

echo "[gitnut] Dumping database to $DB_OUT"
pg_dump "$DATABASE_URL" | gzip > "$DB_OUT"

echo "[gitnut] Database dump completed."

# Optional MinIO/S3 sync
if [[ -n "${S3_ENDPOINT:-}" && -n "${S3_ACCESS_KEY:-}" && -n "${S3_SECRET_KEY:-}" ]]; then
  if command -v aws >/dev/null 2>&1; then
    echo "[gitnut] Syncing S3 buckets using awscli..."
    export AWS_ACCESS_KEY_ID="$S3_ACCESS_KEY"
    export AWS_SECRET_ACCESS_KEY="$S3_SECRET_KEY"
    export AWS_EC2_METADATA_DISABLED=true
    AWS_ARGS=(--endpoint-url "$S3_ENDPOINT" --no-verify-ssl)

    if [[ -n "${S3_BUCKET_ARTIFACTS:-}" ]]; then
      aws "${AWS_ARGS[@]}" s3 sync "s3://$S3_BUCKET_ARTIFACTS" "$OUT/$S3_BUCKET_ARTIFACTS" || true
    fi
    if [[ -n "${S3_BUCKET_ATTESTATIONS:-}" ]]; then
      aws "${AWS_ARGS[@]}" s3 sync "s3://$S3_BUCKET_ATTESTATIONS" "$OUT/$S3_BUCKET_ATTESTATIONS" || true
    fi

    echo "[gitnut] S3 sync completed."
  else
    echo "[gitnut] awscli not found; skipping S3 sync."
  fi
else
  echo "[gitnut] S3 endpoint/credentials not set; skipping object storage sync."
fi

echo "[gitnut] Backup complete: $OUT"
