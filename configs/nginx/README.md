# Nginx reverse proxy configuration (GitNut)

This folder contains production-grade Nginx templates to run GitNut behind a reverse proxy.

Typical routing:
- `https://gitnut.example.com/` -> `apps/web` (Next.js)
- `https://api.gitnut.example.com/` -> `apps/api` (REST)
- `https://grafana.gitnut.example.com/` -> Grafana (optional)

Files:
- `nginx.conf`                Base Nginx config
- `conf.d/gitnut.conf`        Server blocks
- `snippets/security.conf`    Security headers and hardening
- `snippets/proxy.conf`       Standard proxy settings
- `snippets/ssl.conf`         TLS recommendations (bring your own certs)
- `scripts/render-env.sh`     Optional envsubst rendering helper
