# Policy

Policy is how GitNut enforces rules about what can be imported, built, and published.

## Policy layers

1. Repository policy
   - allowed hosts (e.g., github.com)
   - blocked private IP ranges (SSRF protection)
2. Content policy
   - forbidden file patterns (secrets, credentials)
   - maximum archive size
   - path allow/deny lists
3. License policy
   - SPDX allowlist/denylist
   - unknown license handling
4. Build policy
   - allowed build profiles
   - network allowed or denied
   - max build time and resources
5. Publish policy
   - signer allowlist
   - maintainer authority rules
   - required attestation set

## Example policies

### Public registry (strict)
- allow only github.com
- deny network during build
- require SBOM
- allowlist licenses: MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause
- require signed source + build attestations

### Private org registry (flexible)
- allow GitHub Enterprise domain
- allow network to internal artifact mirrors
- allow more licenses
- allow internal signers

## Implementation approach

- policy is evaluated in the Worker
- API can pre-check for fast feedback
- on-chain program enforces:
  - authority
  - immutability rules
  - basic structural checks

## Auditing

Every policy decision should be logged:
- decision outcome
- policy version
- reason codes
- affected object IDs
