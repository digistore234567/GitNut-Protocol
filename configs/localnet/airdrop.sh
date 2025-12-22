#!/usr/bin/env bash
set -euo pipefail

# GitNut Localnet Airdrop helper
#
# Usage:
#   ./configs/localnet/airdrop.sh <PUBKEY> [AMOUNT_SOL]
#
# Examples:
#   ./configs/localnet/airdrop.sh 7Y...abc 100
#   ./configs/localnet/airdrop.sh $(solana address) 50
#
# Environment:
#   GITNUT_RPC_URL  default: http://127.0.0.1:8899
#

PUBKEY="${1:-}"
AMOUNT="${2:-100}"
if [[ -z "$PUBKEY" ]]; then
  echo "Usage: $0 <PUBKEY> [AMOUNT_SOL]"
  exit 1
fi

GITNUT_RPC_URL="${GITNUT_RPC_URL:-http://127.0.0.1:8899}"

if ! command -v solana >/dev/null 2>&1; then
  echo "[gitnut] ERROR: solana CLI not found."
  exit 1
fi

solana config set --url "$GITNUT_RPC_URL" >/dev/null

echo "[gitnut] Requesting airdrop: $AMOUNT SOL -> $PUBKEY"
solana airdrop "$AMOUNT" "$PUBKEY"

echo "[gitnut] Balance:"
solana balance "$PUBKEY"
