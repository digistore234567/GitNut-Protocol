# Features

This section lists GitNut’s core features and why they matter.

## 1) One-click import (source snapshot)
- Resolve a GitHub ref to a commit SHA.
- Produce a deterministic source archive.
- Record provenance metadata.

Why it matters:
- “What code exactly?” becomes a cryptographic statement.

## 2) Normalized manifest
GitNut generates a stable manifest:
- `gitnut.json` or `gitnut.toml`
- consistent fields across language stacks
- policy evaluation results

Why it matters:
- tooling can rely on a stable shape instead of repo-specific conventions.

## 3) Sandbox build pipeline (optional)
Builds run in a constrained environment:
- no secrets
- strict resource limits
- optional network isolation

Why it matters:
- reduces supply-chain risks and prevents accidental leakage.

## 4) Content-addressed storage
Store:
- source tarball
- artifacts
- attestations
- SBOMs

Why it matters:
- immutable content + hash-based identity.

## 5) Signed attestations
GitNut signs attestations so third parties can verify:
- source hash
- build recipe
- artifact hashes
- SBOM hashes

Why it matters:
- enables trust-minimized verification by anyone.

## 6) Solana anchoring
On-chain records store:
- project/version keys
- hashes and immutable pointers
- maintainer authorities
- policy fields and flags

Why it matters:
- public, timestamped commitments with program-enforced rules.

## 7) Indexer and search (recommended)
Indexer makes the system usable at scale:
- query projects/versions quickly
- show verification state
- power the UI search

Why it matters:
- on-chain data is not optimized for rich queries by itself.

## 8) CLI and SDK
- CLI: integrate into CI/CD pipelines.
- SDK: integrate into other apps and registries.

Why it matters:
- distribution. GitNut becomes infrastructure, not just an app.
