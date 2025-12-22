#!/usr/bin/env bash
set -euo pipefail

# GitNut - Deploy Solana programs to localnet
#
# This script builds and deploys Anchor programs required by GitNut.
# It assumes:
#   - local validator is running (see solana-validator.sh)
#   - Anchor is installed (anchor CLI)
#
# Usage:
#   ./configs/localnet/deploy-programs.sh
#
# Environment:
#   GITNUT_RPC_URL           default: http://127.0.0.1:8899
#   GITNUT_PROGRAMS_DIR      default: ./programs
#   GITNUT_ANCHOR_PROGRAM    default: gitnut-registry
#   GITNUT_KEYPAIR           default: ~/.config/solana/id.json
#   GITNUT_SKIP_BUILD        default: 0  (1 to skip build)
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

GITNUT_RPC_URL="${GITNUT_RPC_URL:-http://127.0.0.1:8899}"
GITNUT_PROGRAMS_DIR="${GITNUT_PROGRAMS_DIR:-$REPO_ROOT/programs}"
GITNUT_ANCHOR_PROGRAM="${GITNUT_ANCHOR_PROGRAM:-gitnut-registry}"
GITNUT_KEYPAIR="${GITNUT_KEYPAIR:-$HOME/.config/solana/id.json}"
GITNUT_SKIP_BUILD="${GITNUT_SKIP_BUILD:-0}"

if ! command -v solana >/dev/null 2>&1; then
  echo "[gitnut] ERROR: solana CLI not found."
  exit 1
fi

if ! command -v anchor >/dev/null 2>&1; then
  echo "[gitnut] ERROR: anchor CLI not found. Install Anchor."
  exit 1
fi

if [[ ! -f "$GITNUT_KEYPAIR" ]]; then
  echo "[gitnut] ERROR: keypair not found at $GITNUT_KEYPAIR"
  echo "         Run: solana-keygen new -o $GITNUT_KEYPAIR"
  exit 1
fi

solana config set --url "$GITNUT_RPC_URL" --keypair "$GITNUT_KEYPAIR" >/dev/null

echo "[gitnut] RPC: $GITNUT_RPC_URL"
echo "[gitnut] Keypair: $GITNUT_KEYPAIR"
echo "[gitnut] Programs dir: $GITNUT_PROGRAMS_DIR"
echo "[gitnut] Anchor program: $GITNUT_ANCHOR_PROGRAM"

# Basic health check
solana cluster-version >/dev/null

# Ensure payer has SOL
PAYER="$(solana address)"
BAL="$(solana balance "$PAYER" | awk '{print $1}' || echo "0")"
echo "[gitnut] Payer: $PAYER (balance=$BAL SOL)"
echo "[gitnut] If balance is low, run: ./configs/localnet/airdrop.sh $PAYER 100"

PROGRAM_PATH="$GITNUT_PROGRAMS_DIR/$GITNUT_ANCHOR_PROGRAM"
if [[ ! -d "$PROGRAM_PATH" ]]; then
  echo "[gitnut] ERROR: program directory not found: $PROGRAM_PATH"
  exit 1
fi

pushd "$PROGRAM_PATH" >/dev/null

if [[ "$GITNUT_SKIP_BUILD" != "1" ]]; then
  echo "[gitnut] Building program with Anchor..."
  anchor build
else
  echo "[gitnut] Skipping build (GITNUT_SKIP_BUILD=1)"
fi

echo "[gitnut] Deploying program..."
anchor deploy

echo "[gitnut] Program list:"
solana program show --programs

popd >/dev/null

echo "[gitnut] Done."
