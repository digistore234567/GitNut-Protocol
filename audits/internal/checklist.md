# Security Checklist

## Build / Supply chain
- [ ] Lockfiles committed (pnpm-lock.yaml, Cargo.lock)
- [ ] Reproducible build documented
- [ ] SBOM generation enabled for build artifacts
- [ ] Artifact hashes computed and recorded

## Web/API
- [ ] Auth flows reviewed (GitHub OAuth + wallet sign-in)
- [ ] Rate limiting enabled
- [ ] Input validation (Zod / JSON schema)
- [ ] Secrets management (no plaintext keys in repo)
- [ ] Observability (metrics + tracing)

## Worker
- [ ] Sandbox isolation for builds
- [ ] Network egress restricted during builds
- [ ] Resource limits (CPU / memory / timeouts)
- [ ] Idempotency and retries bounded

## On-chain program
- [ ] PDA seeds stable and documented
- [ ] Access control tested
- [ ] Account sizes bounded
- [ ] Instruction input validated
- [ ] Events emitted for critical state transitions

## Incident response
- [ ] Key rotation procedure
- [ ] Emergency freeze policy (if applicable)
- [ ] Runbooks for outages
