# Process

This document describes the canonical GitNut pipeline.

## Inputs

A pipeline run starts from:
- `repo_url` (GitHub HTTPS or SSH)
- `commit` (SHA) OR `tag` OR `branch` (resolved to SHA)
- optional `version` string (semver-like)
- optional `build_profile` (node/rust/python/static)
- optional `policy_profile` (org-defined)

## Step 1: Import

Goals:
- acquire a deterministic snapshot
- record provenance data

Actions:
- resolve ref to commit SHA
- clone with safety checks
- verify remote origin (host allowlist)
- create a clean working directory
- produce an archive `source.tar.gz`

Outputs:
- `source_path`
- `source_archive_path`
- `git_sha`
- `tree_hash` (optional)
- `source_hash` (SHA-256 of archive)

## Step 2: Normalize

Goals:
- extract consistent metadata independent of repo layout

Actions:
- detect stack (Node, Rust, Python, static)
- parse known manifests:
  - package.json
  - Cargo.toml
  - pyproject.toml / requirements.txt
- determine license:
  - detect SPDX license identifier if possible
- write `gitnut.json` containing:
  - repo identity
  - commit hash
  - license findings
  - build recipe (optional)
  - default artifacts

Outputs:
- `manifest_path`
- `normalized_metadata`
- `policy_decisions` (e.g. license allowed)

## Step 3: Build (optional)

Goals:
- produce deterministic artifacts
- generate SBOMs and checksums

Actions:
- run in sandbox:
  - resource limits
  - no secrets
  - limited network (prefer disabled)
- build with pinned toolchains:
  - node version
  - rust toolchain
  - python version
- produce outputs:
  - dist bundles / binaries
  - checksums
  - SBOM

Outputs:
- `artifact_dir`
- `artifact_hashes`
- `sbom_files`

## Step 4: Store

Goals:
- make outputs retrievable and immutable

Actions:
- upload source archive
- upload manifest
- upload build artifacts
- upload attestations
- record returned URIs

Outputs:
- `source_uri`
- `artifact_uris`
- `attestation_uris`

## Step 5: Attest

Goals:
- create verifiable claims

Documents:
- Source attestation:
  - commit SHA
  - source hash
  - manifest hash
- Build attestation:
  - build recipe
  - environment/toolchain
  - artifact hashes
- Release attestation:
  - version label
  - pointers to source/build attestations
- SBOM attestation:
  - SBOM file hashes

Signing:
- use an attestation signer key (offline or KMS)
- embed public key and signature in attestation file

## Step 6: Anchor (Solana)

Goals:
- anchor immutable pointers and hashes

Program actions:
- register project (if missing)
- publish version with:
  - manifest hash
  - source hash + URI
  - build hash + URI (optional)
  - attestation hashes + URIs
  - maintainer authority

Outputs:
- tx signature
- PDA addresses
- event logs for indexer

## Re-runs and idempotency

GitNut treats pipelines as idempotent:
- A job is identified by `project_id + git_sha + build_profile`
- Re-running should not create duplicates
- If storage already contains the content hash, uploads are skipped

## Failure handling

Common failures:
- GitHub rate limits
- build sandbox timeouts
- storage transient errors
- Solana RPC issues

Mitigation:
- exponential backoff
- retry with idempotency keys
- dead-letter queue for manual inspection
