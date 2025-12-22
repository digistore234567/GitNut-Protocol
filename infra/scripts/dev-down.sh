#!/usr/bin/env bash
set -euo pipefail

# Stop GitNut infra locally
#
# Usage:
#   ./infra/scripts/dev-down.sh [--volumes]
#
# If --volumes is provided, it deletes persisted volumes.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
COMPOSE="$REPO_ROOT/infra/docker/docker-compose.yml"

REMOVE_VOLUMES="0"
if [[ "${1:-}" == "--volumes" ]]; then
  REMOVE_VOLUMES="1"
fi

if [[ "$REMOVE_VOLUMES" == "1" ]]; then
  echo "[gitnut] Stopping infra stack and removing volumes..."
  docker compose -f "$COMPOSE" down -v
else
  echo "[gitnut] Stopping infra stack..."
  docker compose -f "$COMPOSE" down
fi
