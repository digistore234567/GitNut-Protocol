# Self-hosted Deployment

This guide describes how to self-host GitNut using systemd or bare metal.

## Recommended topology

- `api` service
- `worker` service
- `indexer` service (recommended)
- `web` service (or static hosting)
- Postgres
- Redis
- Object storage (S3-compatible or R2)

## Step 1: Provision dependencies

### Postgres
- enable backups
- enable TLS where possible
- set strict network access controls

### Redis
- enable auth if exposed
- restrict network access to internal VLAN

### Object storage
- create dedicated bucket for GitNut
- enable versioning where possible
- apply least-privilege IAM policies

## Step 2: Configure environment

Create `.env` files per service:
- API: OAuth and session config
- Worker: sandbox config, storage config
- Indexer: RPC + DB config
- Web: public URLs

Use secret managers:
- systemd environment files
- Vault
- AWS SSM

## Step 3: Build artifacts

Build once on a build machine:
```bash
pnpm install
pnpm build
```

## Step 4: Run with systemd

Create units:
- `gitnut-api.service`
- `gitnut-worker.service`
- `gitnut-indexer.service`

Each unit should:
- run as non-root user
- have limited filesystem permissions
- log to journald
- restart on failure

## Step 5: Reverse proxy

Use Nginx/Caddy for:
- TLS
- request size limits
- rate limiting
- forwarding to API and Web

## Step 6: Observability

- export metrics to Prometheus
- enable OpenTelemetry collector
- configure log retention

## Step 7: Key management

- do not store signer keys on the worker if you can avoid it
- prefer KMS signing
- rotate keys periodically

## Upgrade strategy

- maintain database migrations
- deploy with rolling restart
- keep indexer compatible with previous program versions

## Rollback strategy

- keep previous container images/builds
- database migrations should be reversible when possible
