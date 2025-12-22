# Threat Model

This document defines what GitNut defends against and what it does not.

## Assets to protect

- Integrity of anchored records (hashes, URIs, version metadata).
- Integrity of attestations and signer keys.
- Integrity of build outputs (prevent substitution).
- Availability of pipeline services.
- Confidentiality of secrets (OAuth secrets, signer keys).

## Adversaries

### A1: Malicious repository maintainer
Can publish code that tries to:
- exfiltrate secrets during build
- abuse network access to call external endpoints
- produce non-deterministic builds that hide malicious changes

### A2: Compromised CI or Worker node
Attacker controls the machine executing builds.

### A3: Storage-layer attacker
Can attempt:
- replace stored artifacts
- serve incorrect bytes at a URI

### A4: API attacker
Attempts:
- unauthorized publish
- denial of service
- data injection
- SSRF via repository URLs

### A5: On-chain attacker
Attempts:
- spoof project/version ownership
- replay publish transactions
- submit invalid attestations

## Security goals

- Anyone can verify that a version points to the **exact content** claimed.
- If storage lies, verification fails due to hash mismatch.
- If worker is compromised, it can still be detected if it anchors wrong hashes,
  but it may publish garbage; governance policies mitigate impact.

## Key mitigations

### Sandbox + network policy
- default: deny outbound network for builds
- allowlist only for necessary registries (optional)
- read-only mounts where possible
- strict CPU/memory/time caps

### Canonicalization and hashing
- canonical JSON encoding before hashing
- stable archive format choices and sorting

### Signed attestations
- attestations include:
  - subject (hash)
  - builder identity
  - build recipe
- signatures verified by clients and program (where feasible)

### Storage integrity
- store hash alongside URI
- verify bytes against hash upon retrieval

### Program constraints
- PDAs derived from:
  - project identifier
  - version identifier
- program enforces:
  - authority checks
  - immutability for published versions
  - limited update operations

### API hardening
- strict URL parsing
- SSRF protections
- rate limiting
- audit logs

## Non-goals / out of scope

- Preventing maintainers from publishing malicious code in their own repos.
- Guaranteeing builds are correct for every stack.
- Preventing compromised signer keys from signing malicious attestations:
  key management is a deployment responsibility.

## Residual risks

- Supply chain attacks via dependencies when network is allowed.
- Non-deterministic builds that produce different artifacts over time.
- Indexer trust: indexer is a convenience layer; verification must rely on hashes/signatures.
