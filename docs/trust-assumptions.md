# Trust Assumptions

GitNut reduces trust requirements, but cannot eliminate them entirely.

## Minimal trust model

A verifier needs to trust:
- cryptographic primitives (hash + signature algorithms)
- Solana consensus for the timestamped record
- correct implementation of the registry program logic

Everything else is verified via:
- content hashes
- signed attestations
- deterministic PDA derivations

## What you do NOT need to trust

- the API server
- the Web UI
- the Indexer database
- the Storage provider

Because:
- API/UI/Indexer are not sources of truth; they are convenience layers.
- Storage can be verified by checking bytes against anchored hashes.

## Deployment trust

If you operate GitNut yourself, you must manage:

- OAuth secrets (GitHub)
- session secrets
- worker runtime privileges
- sandbox isolation (Docker / gVisor / Firecracker)
- attestation signer keys (offline / KMS)

## Attestation signer trust

Attestations shift trust to the signer key.
Options:
- single global signer (simple, centralized)
- per-organization signer keys (recommended for decentralization)
- allowlist of trusted signers on-chain

Trade-offs:
- more signers increases flexibility and decentralization
- but also increases key management complexity

## Indexer trust

Indexer output is not authoritative.
It can lie or be out of date.
Clients should:
- verify on-chain accounts directly when critical
- verify hashes/signatures for artifacts

## Recommended operational posture

- run production with:
  - restricted worker nodes
  - network denied in builds by default
  - signed attestations required for publish
  - mandatory license allowlists
  - audit logging enabled
