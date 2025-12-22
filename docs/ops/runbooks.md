# Runbooks

This document contains operational runbooks for GitNut.

## Services
- api
- worker
- indexer
- web

## Common checks

### API health
- `GET /health`
- check DB connectivity
- check Redis connectivity

### Worker health
- queue depth
- job latency
- sandbox failures
- storage errors

### Indexer health
- slot lag
- rpc errors
- backfill progress
- DB write latency

## Standard runbooks

### Runbook: API is down
1. Check deployment status (systemd/k8s).
2. Inspect logs for startup errors.
3. Validate env vars are present.
4. Validate DB is reachable.
5. Roll back to last known good build if needed.

### Runbook: Worker queue is backing up
1. Check Redis health and memory usage.
2. Check worker logs for repeated failures.
3. Increase worker replicas temporarily.
4. Identify failing job type (import/build/store/anchor).
5. Pause new imports if required.

### Runbook: Solana anchor failures
1. Check RPC provider status.
2. Inspect recent tx errors.
3. Verify program ID and cluster config.
4. Retry with backoff.
5. If persistent, fail jobs to DLQ for manual re-run.

### Runbook: Storage failures
1. Check S3/R2 availability and credentials.
2. Confirm bucket policies allow writes.
3. Verify object size limits.
4. Retry uploads; verify hashes.

## SLO suggestions
- API uptime: 99.9%
- pipeline success rate: > 95%
- median publish latency: < 10 minutes
