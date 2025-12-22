# SDK

The GitNut SDK (`packages/sdk`) provides a TypeScript interface to:

- call the GitNut API
- read the GitNut registry program
- verify artifacts against on-chain commitments

## Design goals

- typed, stable interfaces
- ergonomic helpers for PDAs and instruction construction
- verification primitives (hashing, canonicalization)

## Typical usage

### Create API client
```ts
import { createGitNutClient } from "@gitnut/sdk";

const client = createGitNutClient({
  apiBaseUrl: "https://api.example.com",
  rpcUrl: "https://api.mainnet-beta.solana.com",
});
```

### Fetch project releases
```ts
const projects = await client.projects.list();
const releases = await client.releases.listByProject(projects[0].id);
```

### Verify a release
```ts
const result = await client.verify.release(releases[0].id);
console.log(result.ok, result.details);
```

## Modules

- `client`: API calls
- `pda`: PDA derivations
- `instructions`: on-chain instruction builders
- `parsers`: parse IDL and account data
- `utils`: hashing and canonical JSON
- `types`: shared types

## Verification flow

A verifier uses:
- on-chain record: hashes + URIs
- downloaded bytes from storage URIs
- recomputed hashes
- signature verification of attestations

The SDK provides helpers but does not hide the steps.
