# Test Suite

Test layout:
- unit: pure functions and small modules
- integration: API + DB + worker integration
- e2e: browser flows (Playwright) and end-to-end pipelines
- performance: stress tests and load harness
- fixtures: shared test data

Run from repo root:
- `pnpm test:unit`
- `pnpm test:integration`
- `pnpm test:e2e`
