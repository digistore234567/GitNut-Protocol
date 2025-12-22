# Overview

GitNut is an open-source pipeline + registry for **verifiable software on Solana**.

It aims to solve a practical problem:

- GitHub is where code lives.
- On-chain systems need **verifiable references**, not vague claims.
- Users want to prove **what code** they imported, built, stored, and published.

GitNut introduces a consistent workflow:

1. **Import**: Fetch a repository snapshot (commit SHA, tag, or branch head).
2. **Normalize**: Derive a canonical manifest (`gitnut.json` or `gitnut.toml`).
3. **Build (optional)**: Produce deterministic artifacts (e.g., frontend bundle, CLI binary, WASM).
4. **Store**: Put source archives and build artifacts into content-addressed storage.
5. **Attest**: Create signed attestations: source hash, build recipe, build outputs, SBOM.
6. **Anchor**: Write a minimal on-chain record pointing to immutable content + attestations.

## What GitNut is (and is not)

### GitNut is
- A content-addressed archiving + attestation pipeline.
- A Solana registry program for anchoring proofs (PDA-addressed records).
- A set of services (API/Worker/Indexer/Web/CLI/SDK) to make it usable by anyone.

### GitNut is not
- A magic transpiler that converts arbitrary Web2 server code into on-chain programs.
- A replacement for auditing or secure coding practices.
- A guarantee of correctness: it guarantees **verifiability**, not bug-free software.

## Typical use cases

- **Software provenance**: prove that a released binary came from a specific commit.
- **Open-source registry**: publish project versions with signed metadata on-chain.
- **Artifact notarization**: store immutable release artifacts and anchor their hashes.
- **Compliance and governance**: enforce license policies and content policies.

## Design principles

- **Minimal on-chain footprint**: store pointers and commitments, not large blobs.
- **Idempotent pipeline**: repeated runs produce identical IDs and records.
- **Defense in depth**: sandbox builds, strict network policy, and allowlists.
- **Composable interfaces**: CLI, API, and SDK share common schemas and types.
