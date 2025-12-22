# Helm Deployment

This document outlines how a Helm chart should be structured for GitNut.

## Chart structure

- `Chart.yaml`
- `values.yaml`
- templates:
  - api deployment/service
  - worker deployment
  - indexer deployment
  - configmaps and secrets
  - ingress
  - serviceaccounts and RBAC

## Values design

Recommended values:
- image repository/tag for each service
- replicas for each service
- resources (cpu/memory)
- env and secret references
- ingress hostnames and tls settings
- storage settings
- solana rpc settings

## Example values

```yaml
api:
  replicas: 2
  image:
    repository: ghcr.io/org/repo/api
    tag: latest
worker:
  replicas: 2
  sandbox:
    enabled: true
storage:
  driver: s3
  s3:
    bucket: gitnut
    region: us-east-1
```

## Best practices

- support `podAnnotations` and `nodeSelector`
- support `tolerations` and `affinity`
- allow external DB/Redis
- define liveness/readiness probes
