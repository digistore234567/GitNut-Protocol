# Attestations

Attestations are signed statements about a software artifact.

GitNut uses attestations so that anyone can verify:
- what source bytes were imported
- what build recipe was used
- what outputs were produced
- what SBOM was generated
- who signed the statement

## Attestation types

### Source attestation
Claims:
- repository identity
- commit SHA
- source archive hash
- manifest hash
- timestamp

### Build attestation
Claims:
- build profile
- build commands
- toolchain versions
- builder environment
- output artifact hashes
- SBOM hashes (if produced)

### Release attestation
Claims:
- version label
- references to source/build attestations
- storage URIs
- on-chain tx signature (optional)

### SBOM attestation
Claims:
- SBOM file hash list
- generator tool version
- dependency scope and options

## Structure (recommended)

Use a consistent JSON structure:

- `type` and `version`
- `subject` (hash + uri)
- `predicate` (details)
- `signing` (public key + signature)
- `timestamp`

## Signing

Signing should be performed by:
- a dedicated key
- ideally stored in KMS or offline
- rotated periodically

Verify by:
- canonicalize JSON (deterministic encoding)
- compute digest
- verify signature using public key

## Storage

Attestations are stored off-chain like other artifacts,
but their hashes are anchored on-chain.

This creates a chain:
- on-chain record -> attestation hash -> attestation document -> subject hash
