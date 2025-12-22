# Localnet

This guide shows how to run GitNut locally with a Solana local validator.

## Prerequisites
- Node.js 20+
- pnpm
- Docker (recommended)
- Solana CLI
- Anchor (for program builds/tests)

## Start local infrastructure

If you use the repo's docker compose (recommended):
```bash
cd infra/docker
docker compose up -d postgres redis minio
```

## Start Solana test validator
```bash
solana-test-validator --reset
```

In another shell:
```bash
solana config set --url localhost
solana airdrop 10
solana balance
```

## Build and deploy program
```bash
anchor build
anchor deploy --provider.cluster localnet
```

## Start API
```bash
pnpm --filter @gitnut/api prisma:migrate:deploy
pnpm --filter @gitnut/api dev
```

## Start Worker
```bash
pnpm --filter @gitnut/worker dev
```

## Start Web
```bash
pnpm --filter @gitnut/web dev
```

## Validate end-to-end
- Open web app
- Import a public repo
- Observe job progress
- Confirm on-chain anchor exists

## Tips
- Keep localnet ledger ephemeral for repeatable tests.
- Use deterministic seed keys in development only.
- Do not reuse dev secrets in production.
