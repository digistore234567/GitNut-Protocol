# GitNut CLI

A developer-focused CLI for interacting with GitNut.

## Install (monorepo)

```bash
pnpm -C ../../ install
pnpm -C ../../ build
node ../../apps/cli/dist/index.js --help
```

## Examples

```bash
gitnut doctor
gitnut import --repo https://github.com/vercel/next.js --name nextjs
gitnut publish --repo https://github.com/someone/project --name project --ref main
gitnut verify --project-id <uuid> --version <commit12>
```
