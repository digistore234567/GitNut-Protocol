# Kubernetes Deployment

This guide describes a Kubernetes deployment pattern for GitNut.

## Suggested components

- `Deployment` for API
- `Deployment` for Worker (or `ScaledJob` via KEDA)
- `Deployment` for Indexer
- `Deployment` for Web (or external hosting)
- Managed Postgres (recommended)
- Managed Redis (recommended)
- Object storage (S3/R2)

## Secrets and config

Use:
- Kubernetes Secrets for sensitive values
- ConfigMaps for non-sensitive config

Consider:
- ExternalSecrets Operator for cloud secret managers.

## Ingress

- TLS termination
- rate limiting
- request size limits
- WAF (optional)

## Scaling

- API: scale by RPS and latency
- Worker: scale by queue depth
- Indexer: scale by RPC throughput

## Sandbox and security

Worker nodes should run with:
- restricted PodSecurity
- read-only root filesystem if possible
- seccomp profiles
- no privileged containers

For high security, consider:
- gVisor
- Kata containers

## Observability

- Prometheus + Grafana
- OpenTelemetry collector
- Loki for logs (optional)

## Upgrade considerations

- run DB migrations as a Job
- deploy API then Worker
- ensure program upgrades are coordinated
