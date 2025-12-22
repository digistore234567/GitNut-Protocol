# Systemd (Self-hosted) Deployment Templates

This folder provides production-grade systemd units for running GitNut services on a Linux host.

Services:
- `gitnut-api.service`
- `gitnut-worker.service`
- `gitnut-indexer.service`

## Assumptions
- You deploy artifacts into `/opt/gitnut`
- You create users: `gitnut` and group `gitnut`
- You provide environment files in `/etc/gitnut/*.env`
- Logs are handled by `journald` (use `journalctl -u <unit>`)

## Setup
1. Copy unit files to `/etc/systemd/system/`
2. Create env files:
   - `/etc/gitnut/api.env`
   - `/etc/gitnut/worker.env`
   - `/etc/gitnut/indexer.env`
3. Reload + enable:
   - `sudo systemctl daemon-reload`
   - `sudo systemctl enable --now gitnut-api gitnut-worker gitnut-indexer`

## Hardening
- Units include basic hardening flags (NoNewPrivileges, PrivateTmp, etc.)
- For stricter confinement, consider systemd sandboxing + seccomp at the container layer.
