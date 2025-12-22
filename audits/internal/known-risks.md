# Known Risks (Living Document)

- Build sandbox escapes (mitigate with container runtime constraints and no privileged flags)
- GitHub supply chain attacks (verify commit signatures where possible; restrict to specific refs)
- Dependency confusion (pin registries; use lockfiles; enable dependency review)
- On-chain data bloat (store only hashes/metadata; keep large blobs off-chain)
- Attestation key compromise (rotation + revocation lists + audit trails)
