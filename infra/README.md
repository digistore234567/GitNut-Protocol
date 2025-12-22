# GitNut Infrastructure

This folder provides production-oriented infrastructure templates for running GitNut.

Contents:
- `docker/`       local infra stack (Postgres/Redis/MinIO/Prometheus/Grafana/OTel)
- `kubernetes/`   K8s manifests (base + kustomize overlays)
- `helm/`         Helm chart to deploy GitNut + deps
- `terraform/`    Terraform templates (AWS/GCP/Cloudflare)
- `scripts/`      helper scripts: dev-up/down, migrations, seed, smoke tests, backups

Quick local infra:
```bash
chmod +x infra/scripts/*.sh
./infra/scripts/dev-up.sh
```

Then run your app services (api/web/worker/indexer) using your preferred method.
