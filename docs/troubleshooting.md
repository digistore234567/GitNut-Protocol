# Troubleshooting

This guide lists common issues and fixes.

## Web cannot connect to API
- verify `NEXT_PUBLIC_API_BASE_URL`
- check API is running and reachable
- confirm CORS settings

## API cannot connect to Postgres
- verify `DATABASE_URL`
- ensure Postgres is running
- check credentials and network rules

## Worker jobs stuck in queue
- confirm Redis is running
- check worker logs
- verify queue configuration

## Build fails in sandbox
- check resource limits (CPU/memory/time)
- check network settings (some builds require downloads)
- pin toolchain versions
- inspect build logs and artifact directory

## Storage upload fails
- verify bucket name and credentials
- verify endpoint URL
- check object size limits

## Solana transaction failures
- verify RPC URL
- ensure wallet has SOL for fees
- confirm program ID matches deployed program
- retry with exponential backoff

## Indexer lagging
- verify RPC provider performance
- increase indexer resources
- enable batching and checkpoints

## When to escalate
- repeated publish failures
- signs of unauthorized access
- signer key compromise suspicion
