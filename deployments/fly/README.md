# Fly.io Deployment Templates (API / Worker / Indexer)

This folder provides a baseline Fly.io setup for deploying:
- `apps/api` (HTTP API)
- `apps/worker` (background pipeline runner)
- `apps/indexer` (chain event indexer)

## Prereqs
- Install `flyctl`
- Create Fly apps:
  - `gitnut-api`
  - `gitnut-worker`
  - `gitnut-indexer`
- Provision Postgres/Redis (Fly or external)

## Usage (high-level)
1. Copy `fly.api.toml` to `apps/api/fly.toml` (or keep here and pass `-c`).
2. Run `fly deploy` from each service directory (or with `-c` path).
3. Set secrets:
   - `DATABASE_URL`
   - `REDIS_URL`
   - `GITHUB_APP_ID`, `GITHUB_APP_PRIVATE_KEY`, `GITHUB_APP_CLIENT_ID`, `GITHUB_APP_CLIENT_SECRET`
   - `JWT_SECRET`, `SESSION_SECRET`
   - Storage keys (`S3_*` / `R2_*`) if applicable.

## Notes
These templates assume you build Docker images using each app's Dockerfile (or the monorepo root pipeline).
