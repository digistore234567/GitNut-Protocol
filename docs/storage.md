# Storage

GitNut stores large data off-chain and anchors integrity on-chain.

## Drivers

GitNut supports multiple storage backends via an interface layer:

- Local filesystem (development)
- S3-compatible object storage (AWS S3, MinIO, etc.)
- Cloudflare R2 (S3 API-compatible)
- Arweave (permanent storage, optional)

You can add more drivers by implementing the storage interface:
- putObject
- getObject
- headObject
- resolveUri

## Content addressing

GitNut treats content identity as:
- `hash = sha256(bytes)`
- `uri = storage location`

The on-chain record stores both:
- `hash` (integrity)
- `uri` (retrievability)

Clients verify by:
1. downloading bytes from `uri`
2. computing hash
3. comparing to anchored hash

## Object layout conventions

Recommended keys:

- `sources/<project>/<sha>/source.tar.gz`
- `manifests/<project>/<sha>/gitnut.json`
- `artifacts/<project>/<sha>/<profile>/<artifact>`
- `attestations/<project>/<sha>/<type>.json`
- `sbom/<project>/<sha>/<sbom-file>.json`

## Immutability

S3-style storage is not inherently immutable.
To improve safety:
- use versioned buckets
- write-once policies if supported
- object lock if available

Even without immutability, hash verification detects tampering.

## Access control

Public registries typically need public reads.
Sensitive registries may:
- store encrypted artifacts
- require signed URLs
- use authenticated gateway proxies

If you restrict reads, ensure verifiers can still obtain bytes to validate hashes.

## Performance considerations

- Use multipart uploads for large artifacts.
- Use CDN for public downloads.
- Prefer regional proximity between worker and bucket.
- Use caching in the API layer for repeated downloads (hash-verified).
