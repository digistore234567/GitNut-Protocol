# CLI

The GitNut CLI (`apps/cli`) is designed for:

- local developers
- CI pipelines
- power users who prefer terminal workflows

## Installation

From monorepo:
```bash
pnpm install
pnpm --filter @gitnut/cli build
node apps/cli/dist/index.js --help
```

Once published:
```bash
pnpm add -g @gitnut/cli
gitnut --help
```

## Commands (recommended set)

- `gitnut init`
  - creates a `gitnut.json` stub for a repo
- `gitnut import`
  - imports a repository snapshot
- `gitnut normalize`
  - generates a canonical manifest
- `gitnut build`
  - runs sandbox build
- `gitnut store`
  - uploads artifacts
- `gitnut attest`
  - creates signed attestations
- `gitnut anchor`
  - anchors to Solana
- `gitnut publish`
  - end-to-end pipeline
- `gitnut verify`
  - verify artifacts against on-chain hash records
- `gitnut doctor`
  - diagnose environment (solana, anchor, docker)

## Configuration

The CLI reads config from:
- `.env`
- `~/.config/gitnut/config.json` (optional)

Typical settings:
- `GITNUT_API_BASE_URL`
- `GITNUT_RPC_URL`
- `GITNUT_STORAGE_DRIVER`
- `GITNUT_ATTESTATION_KEY_PATH`

## Example: publish a repo

```bash
gitnut publish   --repo https://github.com/org/repo   --ref v1.2.3   --build-profile node   --version v1.2.3
```

## Exit codes

- 0: success
- 1: general failure
- 2: invalid config
- 3: policy denied
- 4: build failed
- 5: anchor failed

## Security

- Keep signer keys out of CI logs.
- Use hardware/KMS signing if possible.
- Prefer running builds with network disabled.
