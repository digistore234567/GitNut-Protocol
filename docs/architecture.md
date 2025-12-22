# Architecture

GitNut is a monorepo with multiple components.

## High-level view

- Web App (`apps/web`)
  - UI for importing projects, viewing versions, and verifying proofs.
  - Wallet-based interactions and read-only views.
- API (`apps/api`)
  - Auth, project management, version management.
  - Job orchestration for the Worker.
  - Storage + registry integration.
- Worker (`apps/worker`)
  - Executes the pipeline: Import → Normalize → Build → Store → Attest → Anchor.
  - Uses sandboxed builders.
- Indexer (`apps/indexer`)
  - Subscribes to Solana events and materializes data into Postgres for queries.
  - Optional but strongly recommended.
- Registry Program (`programs/gitnut-registry`)
  - Anchor program that stores minimal project/version records and verification status.
- SDK (`packages/sdk`)
  - TS client library for third-party integrations.
- Shared (`packages/shared`)
  - Shared schemas, hashing, canonicalization, and common utilities.

## Data flow

1. User submits a repo reference:
   - `owner/repo`
   - commit SHA / tag
   - metadata
2. API validates:
   - auth
   - policy checks (allowlist, license)
   - rate limits
3. API schedules a Worker pipeline run:
   - job queue (Redis-backed, e.g. BullMQ)
4. Worker executes steps:
   - clones repo at commit
   - creates archive (tar.gz)
   - computes canonical hash
   - generates manifest
   - produces build artifacts (optional)
   - uploads to storage (S3/R2/Arweave/local)
   - creates attestations and signs them
   - submits Solana transaction to registry program
5. Indexer listens to on-chain events:
   - updates database status
   - powers search and historical pages

## Storage strategy

GitNut stores large blobs off-chain:
- Source tarball
- Build artifacts
- SBOM files
- Attestation documents

And stores on-chain:
- content IDs (hashes)
- storage URIs (immutable pointers)
- attestation hashes
- signing public keys
- verification flags / timestamps
- maintainer lists and policy settings

## Identity & authorization

Two parallel identities can exist:
- Wallet identity (Solana address)
- GitHub identity (OAuth)

Recommended policy:
- Wallet signs final publish operations.
- GitHub OAuth is used for repository ownership checks and convenience.

## Security boundaries

- Worker sandbox isolates build execution:
  - strict filesystem
  - resource limits
  - optional network disable
- API never executes builds.
- Program trusts only cryptographic commitments:
  - signature verification
  - deterministic PDA derivations
  - strict instruction checks

## Observability

Every component emits:
- structured logs
- metrics
- traces (OpenTelemetry recommended)

Minimum dashboards:
- pipeline throughput
- build failures by language stack
- Solana tx failure rate
- storage errors and latency
- queue depth and job timeouts
