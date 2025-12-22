# GitNut Documentation

Welcome to GitNut.

GitNut is an open-source system that makes GitHub-hosted software **addressable, verifiable, and referenceable on Solana**.

> GitNut does **not** magically “convert Web2 apps into smart contracts.”
> Instead, it provides a **pipeline + registry**:
> - import source code
> - normalize metadata
> - optionally build and produce artifacts
> - generate attestations (hashes, SBOM, signatures)
> - store content-addressed artifacts
> - anchor verifiable pointers + proofs on Solana

## Quick links
- [Overview](./overview.md)
- [Architecture](./architecture.md)
- [Terminology](./terminology.md)
- [Process](./process.md)
- [Features](./features.md)
- [Threat Model](./threat-model.md)
- [Trust Assumptions](./trust-assumptions.md)

## Developer docs
- [API](./api.md)
- [CLI](./cli.md)
- [SDK](./sdk.md)

## On-chain
- [Registry Program](./registry-program.md)

## Operations
- [Localnet](./localnet.md)
- Deployment:
  - [Self-hosted](./deployment/self-hosted.md)
  - [Docker Compose](./deployment/docker-compose.md)
  - [Kubernetes](./deployment/kubernetes.md)
  - [Helm](./deployment/helm.md)
  - [Vercel](./deployment/vercel.md)
  - [Fly.io](./deployment/fly-io.md)
  - [Cloudflare](./deployment/cloudflare.md)
  - [Hardening](./deployment/hardening.md)
- Ops:
  - [Runbooks](./ops/runbooks.md)
  - [Incident Response](./ops/incident-response.md)
  - [Backups](./ops/backups.md)
  - [Key Rotation](./ops/key-rotation.md)
  - [Migrations](./ops/migrations.md)
  - [Monitoring](./ops/monitoring.md)
- [Troubleshooting](./troubleshooting.md)

## Versioning
This documentation set is written for the monorepo layout you selected.
Update this section if you restructure the repo.

- Docs build: static markdown (can be replaced with Docusaurus/MkDocs later).
- API: `apps/api`
- Worker: `apps/worker`
- Web: `apps/web`
- Program: `programs/gitnut-registry`
- SDK: `packages/sdk`

Last updated: 2025-12-22
