# Terminology

This glossary standardizes terms used across GitNut.

## Core objects

### Project
A logical software package, typically mapped to a GitHub repository.
Example: `vercel/next.js`

### Version
A publishable snapshot of a project.
Often associated with:
- commit SHA
- tag name
- semantic version string

### Release
A published version record in GitNut (off-chain + on-chain).
A release ties:
- source archive
- build artifacts (optional)
- attestations
- on-chain anchor record

### Manifest (`gitnut.json` / `gitnut.toml`)
A normalized metadata file derived from the repository and user input.
Includes:
- repo identity
- commit hash
- detected stack
- build recipe (optional)
- license data
- checksums

### Attestation
A signed JSON document that asserts something verifiable.
GitNut uses attestations to prove:
- source content hash
- build inputs/outputs
- SBOM contents
- policy decisions

### SBOM
Software Bill of Materials: a machine-readable dependency inventory.
GitNut can generate SBOMs during builds, depending on stack support.

### Anchor
In GitNut docs, “anchor” means:
- writing a commitment to Solana
- not the Anchor framework (though we also use Anchor).

### Registry Program
The on-chain program that stores project/version metadata and verification flags.

## Pipeline stages

### Import
Fetch repository contents at a specific ref and produce a local snapshot.

### Normalize
Detect stack, extract manifests, derive canonical metadata, produce `gitnut.json`.

### Build
Optional. Produce deterministic artifacts from source.

### Store
Upload source and artifacts to content-addressed storage.
Content-addressed means:
- URI references immutable content
- hash identifies the exact bytes

### Attest
Generate and sign attestation documents.

### Verify
Optionally verify attestations against policy and known keys.

### Publish
Mark a version as published in the registry, with required proofs.

## Security terms

### Policy
Rules that determine whether a project/version can be indexed/published.
Examples:
- license allowlist
- forbidden files patterns
- max artifact sizes

### Trust boundary
A line where we assume a component can be compromised.
We reduce trust by verifying hashes/signatures across boundaries.

### Idempotency
A property where running the same pipeline twice yields the same output IDs.
GitNut uses idempotency keys for job retries and safety.

## Identifiers

### Content hash
SHA-256 hash of canonical bytes.

### CID / URI
Depending on storage driver, a content identifier could be:
- `ipfs://...`
- `ar://...`
- `s3://bucket/key` (with separate integrity hash)
- `https://...` (immutable path)
GitNut stores both URI and hash for safety.
