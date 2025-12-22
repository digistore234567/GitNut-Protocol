# Migrations

GitNut uses schema migrations (Prisma) and may also evolve on-chain accounts.

## Database migrations
- create migrations as part of development
- apply migrations automatically in staging
- apply migrations with controlled job in production

Recommended:
- run migrations as a one-off job
- gate deployments on successful migrations

## On-chain migrations
On-chain programs are harder to migrate.
Strategies:
- versioned accounts
- upgrade authority governance
- indexer supports multiple versions

## Rollback
- database: maintain down-migrations where possible or use PITR
- on-chain: rollback requires program upgrade to previous version and compatibility code
