# Reproducible Builds

Reproducible builds ensure that two independent builders produce identical artifacts from the same source and recipe.

GitNut supports reproducibility as a goal, but it depends heavily on stack maturity and dependency pinning.

## What reproducibility means

Given:
- source commit SHA
- build recipe and environment
- dependencies and toolchain versions

Output:
- artifact bytes are identical
- hashes match

## Common pitfalls

- unpinned dependency versions
- time-dependent build stamps
- non-deterministic file ordering in archives
- platform-specific compilation differences
- network access that fetches changing resources

## Recommended practices

### Pin toolchains
- Node: lock Node version (e.g., 20.x)
- Rust: pin toolchain via `rust-toolchain.toml`
- Python: pin Python and dependencies with hashes

### Lock dependencies
- Node: `pnpm-lock.yaml` or `package-lock.json`
- Rust: `Cargo.lock`
- Python: `requirements.txt` with hashes or `poetry.lock`

### Disable network by default
Build in a sandbox without network whenever possible.

### Normalize artifacts
- stable archive format
- stable timestamps (set to epoch)
- stable file ordering

## GitNut build attestation fields

A build attestation should include:
- `source_sha`
- `builder_image_digest`
- `toolchain_versions`
- `build_commands`
- `environment` (OS, arch)
- `artifact_hashes`

## Verification strategy

1. Download source archive by hash
2. Rebuild locally using the same recipe
3. Compare artifact hashes to anchored hashes

GitNut does not force all builds to be reproducible, but it makes verification possible.
