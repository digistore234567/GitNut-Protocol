# Fly.io Deployment (API/Worker/Indexer)

Fly.io is a good fit for small-to-medium deployments.

## Strategy

- Deploy API as a Fly app
- Deploy Worker as a separate Fly app
- Deploy Indexer as a separate Fly app
- Use managed Postgres and Redis providers

## API app

- configure `DATABASE_URL`, `REDIS_URL`, `SESSION_SECRET`
- expose port 3001

## Worker app

- configure `DATABASE_URL`, `REDIS_URL`, storage settings
- no public ports required

## Indexer app

- configure `RPC_URL`, `DATABASE_URL`
- no public ports required

## Observability

- ship logs to Fly logs
- export metrics if needed via OTEL

## Hardening

- run as non-root
- restrict egress if possible for the worker
