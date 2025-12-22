# Grafana provisioning (GitNut)

This folder contains a ready-to-run Grafana provisioning setup that works well with:
- Prometheus (metrics)
- Loki (logs) - optional
- Tempo/Jaeger (traces) - optional

Structure:
- provisioning/datasources: Prometheus, Loki (optional)
- provisioning/dashboards: default dashboards provider
- dashboards: JSON dashboards used by the provider

Notes:
- If running via Docker, mount this folder to /etc/grafana inside the container.
- Adjust datasource URLs in `provisioning/datasources/*.yaml`.
