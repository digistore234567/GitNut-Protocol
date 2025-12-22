#!/usr/bin/env bash
set -euo pipefail

# GitNut Localnet - Solana validator bootstrap
#
# Requirements:
#   - solana-cli installed and in PATH
#   - solana-test-validator available (ships with Solana CLI)
#   - optional: anchor (for building/deploying programs)
#
# Usage:
#   ./configs/localnet/solana-validator.sh
#
# Environment:
#   GITNUT_LOCALNET_DIR     default: ./.localnet
#   GITNUT_LEDGER_DIR       default: $GITNUT_LOCALNET_DIR/ledger
#   GITNUT_LOG_DIR          default: $GITNUT_LOCALNET_DIR/logs
#   GITNUT_RPC_PORT         default: 8899
#   GITNUT_WS_PORT          default: 8900
#   GITNUT_FAUCET_PORT      default: 9900
#   GITNUT_RESET            default: 0  (1 to wipe ledger and start fresh)
#   GITNUT_DETACH           default: 0  (1 to run in background)
#
# Notes:
#   - This starts a local validator suitable for Anchor tests and local development.
#   - Use deploy-programs.sh to build/deploy the GitNut registry program.
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

GITNUT_LOCALNET_DIR="${GITNUT_LOCALNET_DIR:-$REPO_ROOT/.localnet}"
GITNUT_LEDGER_DIR="${GITNUT_LEDGER_DIR:-$GITNUT_LOCALNET_DIR/ledger}"
GITNUT_LOG_DIR="${GITNUT_LOG_DIR:-$GITNUT_LOCALNET_DIR/logs}"

GITNUT_RPC_PORT="${GITNUT_RPC_PORT:-8899}"
GITNUT_WS_PORT="${GITNUT_WS_PORT:-8900}"
GITNUT_FAUCET_PORT="${GITNUT_FAUCET_PORT:-9900}"

GITNUT_RESET="${GITNUT_RESET:-0}"
GITNUT_DETACH="${GITNUT_DETACH:-0}"

mkdir -p "$GITNUT_LOCALNET_DIR" "$GITNUT_LEDGER_DIR" "$GITNUT_LOG_DIR"

if [[ "$GITNUT_RESET" == "1" ]]; then
  echo "[gitnut] Reset requested; wiping localnet data at: $GITNUT_LOCALNET_DIR"
  rm -rf "$GITNUT_LEDGER_DIR" "$GITNUT_LOG_DIR"
  mkdir -p "$GITNUT_LEDGER_DIR" "$GITNUT_LOG_DIR"
fi

if ! command -v solana-test-validator >/dev/null 2>&1; then
  echo "[gitnut] ERROR: solana-test-validator not found. Install Solana CLI first."
  exit 1
fi

# Kill any old validator we launched (based on pid file)
PID_FILE="$GITNUT_LOCALNET_DIR/validator.pid"
if [[ -f "$PID_FILE" ]]; then
  OLD_PID="$(cat "$PID_FILE" || true)"
  if [[ -n "${OLD_PID:-}" ]] && kill -0 "$OLD_PID" >/dev/null 2>&1; then
    echo "[gitnut] Stopping existing validator (pid=$OLD_PID)"
    kill "$OLD_PID" || true
    sleep 1
  fi
  rm -f "$PID_FILE"
fi

LOG_FILE="$GITNUT_LOG_DIR/solana-test-validator.log"

echo "[gitnut] Starting solana-test-validator"
echo "         ledger: $GITNUT_LEDGER_DIR"
echo "            rpc: http://127.0.0.1:$GITNUT_RPC_PORT"
echo "             ws: ws://127.0.0.1:$GITNUT_WS_PORT"
echo "         faucet: 127.0.0.1:$GITNUT_FAUCET_PORT"
echo "            log: $LOG_FILE"

# Configure the local Solana CLI to point to localnet
solana config set --url "http://127.0.0.1:$GITNUT_RPC_PORT" >/dev/null

# Create a deterministic keypair for the validator identity if none exists
IDENTITY="$GITNUT_LOCALNET_DIR/validator-identity.json"
if [[ ! -f "$IDENTITY" ]]; then
  solana-keygen new --no-bip39-passphrase --silent --outfile "$IDENTITY" >/dev/null
fi

# Start validator
set +e
if [[ "$GITNUT_DETACH" == "1" ]]; then
  nohup solana-test-validator         --ledger "$GITNUT_LEDGER_DIR"         --rpc-port "$GITNUT_RPC_PORT"         --ws-port "$GITNUT_WS_PORT"         --faucet-port "$GITNUT_FAUCET_PORT"         --limit-ledger-size         --reset         --quiet         --log         --bpf-program 11111111111111111111111111111111 /dev/null         --identity "$IDENTITY"         >"$LOG_FILE" 2>&1 &
  NEW_PID="$!"
  echo "$NEW_PID" > "$PID_FILE"
  echo "[gitnut] Validator running in background (pid=$NEW_PID)"
  echo "[gitnut] Tail logs: tail -f $LOG_FILE"
  exit 0
else
  solana-test-validator         --ledger "$GITNUT_LEDGER_DIR"         --rpc-port "$GITNUT_RPC_PORT"         --ws-port "$GITNUT_WS_PORT"         --faucet-port "$GITNUT_FAUCET_PORT"         --limit-ledger-size         --reset         --log         --identity "$IDENTITY"         2>&1 | tee "$LOG_FILE"
fi
