# Cloudflare Deployment

Cloudflare can be used for:
- DNS
- CDN
- WAF
- Rate limiting
- Storage (R2)

## Recommended usage

- Use Cloudflare for `web` + `api` front door:
  - proxy traffic
  - apply bot protection and rate limiting
- Use R2 as storage:
  - S3-compatible API
  - public or signed access

## R2 configuration

You need:
- account ID
- access key and secret
- bucket name
- endpoint URL

Ensure:
- strong bucket policies
- optional: signed URLs via API

## Security

- enable WAF rules
- block known bad ASNs if needed
- limit request body sizes
- protect auth endpoints from abuse
