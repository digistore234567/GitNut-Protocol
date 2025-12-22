# Docker Compose Deployment

This guide uses Docker Compose for a single-host deployment.

## Requirements
- Docker + Docker Compose v2

## Services
- Postgres
- Redis
- MinIO (S3-compatible storage)
- API
- Worker
- Indexer (optional)
- Web (optional)

## Example compose layout

Your repo includes `infra/docker/docker-compose.yml`.
Recommended steps:

```bash
cd infra/docker
cp .env.example .env
docker compose up -d
```

## Environment variables

Minimum:
- `DATABASE_URL`
- `REDIS_URL`
- `GITNUT_STORAGE_DRIVER`
- `GITNUT_STORAGE_S3_ENDPOINT`
- `GITNUT_STORAGE_S3_BUCKET`

## Networking

- Keep DB and Redis on private network.
- Only expose:
  - web: 3000
  - api: 3001

## Persistent volumes

- Postgres data
- MinIO data
- optional: worker scratch

## Updating

```bash
docker compose pull
docker compose up -d
```

## Troubleshooting

- check logs:
  ```bash
  docker compose logs -f api
  docker compose logs -f worker
  ```
- verify DB:
  ```bash
  docker compose exec postgres psql -U gitnut -d gitnut
  ```
