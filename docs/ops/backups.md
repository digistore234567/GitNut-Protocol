# Backups

GitNut relies on:
- Postgres
- Object storage
- Optional: Redis persistence

## Postgres backups
- daily full backups
- point-in-time recovery (recommended)
- test restores monthly

## Object storage backups
If using durable providers, you may not need separate backups.
However:
- enable bucket versioning
- periodically export critical attestations and manifests

## Redis
Redis is a cache/queue store.
If you lose Redis:
- job state may be lost
- idempotency helps recovery
Consider enabling persistence for production.

## Restore procedure (high-level)
1. Restore Postgres.
2. Verify API starts and migrations are correct.
3. Reconnect worker and indexer.
4. Validate pipeline resumes.
5. Reconcile any in-flight jobs manually.
