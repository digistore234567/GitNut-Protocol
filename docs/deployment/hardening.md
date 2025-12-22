# Hardening

This is a security hardening checklist for production deployments.

## Network
- Place DB/Redis in private subnets.
- Restrict outbound network from the Worker.
- Use allowlists for Git hosts (e.g., github.com only).
- Set request size limits on reverse proxies.

## Secrets
- Never commit secrets to git.
- Use a secret manager.
- Rotate secrets periodically.
- Use separate credentials per environment.

## Worker sandbox
- Run builds in isolated containers.
- Disable network by default.
- Use seccomp profiles.
- Use read-only root filesystem.
- Apply CPU/memory/time limits.

## Storage
- Enable versioning or immutability features.
- Verify content by hash upon retrieval.
- Protect write permissions tightly.

## Solana RPC
- Use a reliable RPC provider.
- Implement retry and backoff.
- Monitor transaction failure rates.

## Logs and audit trails
- Keep structured logs.
- Store audit logs for publish events.
- Redact secrets and tokens.

## Dependency security
- Enable dependency review workflows.
- Run `pnpm audit` regularly.
- Use SBOM generation to improve transparency.

## Incident response
- Maintain runbooks.
- Define severity levels.
- Practice a rollback procedure.
