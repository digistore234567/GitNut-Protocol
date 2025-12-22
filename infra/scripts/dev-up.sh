#!/usr/bin/env bash
set -euo pipefail

# Bring up GitNut infra locally (Postgres/Redis/MinIO/Prometheus/Grafana/OTel)
#
# Usage:
#   ./infra/scripts/dev-up.sh
#
# Tip:
#   Add app services by running the repo root compose after this script.
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
COMPOSE="$REPO_ROOT/infra/docker/docker-compose.yml"

if ! command -v docker >/dev/null 2>&1; then
  echo "[gitnut] ERROR: docker not found"
  exit 1
fi

if ! command -v docker compose >/dev/null 2>&1; then
  echo "[gitnut] ERROR: docker compose plugin not found"
  exit 1
fi

echo "[gitnut] Starting infra stack..."
docker compose -f "$COMPOSE" up -d

echo "[gitnut] Waiting for core services to become healthy..."
docker compose -f "$COMPOSE" ps

echo ""
echo "[gitnut] Endpoints:"
echo "  Postgres : localhost:5432"
echo "  Redis    : localhost:6379"
echo "  MinIO    : http://localhost:9000 (console http://localhost:9001)"
echo "  Prometheus: http://localhost:9090"
echo "  Grafana  : http://localhost:3001 (admin/admin-change-me)"
echo "  OTel OTLP: http://localhost:4318 (HTTP), grpc :4317"
