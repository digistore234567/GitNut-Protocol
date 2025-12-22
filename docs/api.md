# API

The API service (`apps/api`) exposes REST endpoints for GitNut.

This document is a reference for routes and payload shapes.

## Base URL
- Local dev: `http://localhost:3001`
- Production: configured via `PUBLIC_BASE_URL`

## Authentication

Two auth modes are common:

1. GitHub OAuth session
2. Wallet sign-in session (message signature)

Recommended:
- Use wallet signature for publishing actions.
- Use GitHub OAuth to link GitHub identity.

## Common headers
- `Content-Type: application/json`
- `X-Request-Id` (optional)

## Endpoints

### Health
`GET /health`

Response:
```json
{ "ok": true, "service": "gitnut-api", "time": "..." }
```

### Auth
`GET /auth/github/start`
- redirects to GitHub OAuth

`GET /auth/github/callback`
- completes OAuth

`POST /auth/wallet/nonce`
- returns nonce to sign

`POST /auth/wallet/verify`
- verifies signature and starts session

### Projects

`GET /projects`
- list projects

`POST /projects`
- create project record
Payload:
```json
{
  "repoUrl": "https://github.com/org/repo",
  "displayName": "repo",
  "description": "..."
}
```

`GET /projects/:id`
- fetch project details

`POST /projects/:id/import`
- enqueue import pipeline
Payload:
```json
{
  "ref": "main",
  "commit": null,
  "tag": null,
  "buildProfile": "node",
  "versionLabel": "v1.0.0"
}
```

### Releases

`GET /projects/:id/releases`
- list releases

`GET /releases/:releaseId`
- release details

### Attestations

`GET /releases/:releaseId/attestations`
- list attestation objects and URIs

### Jobs

`GET /jobs/:jobId`
- job status and logs pointer

## Error format

GitNut API uses a standard error object:

```json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests",
    "requestId": "..."
  }
}
```

## Security notes

- Validate repo URLs strictly to avoid SSRF.
- Never accept raw git URLs without allowlist.
- Do not allow arbitrary command execution.
- Rate limit import endpoints.
