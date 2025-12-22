# Vercel Deployment (Web)

This guide covers deploying the GitNut web app with Vercel.

## Assumptions
- API is deployed separately and accessible via HTTPS.
- You use environment variables for public endpoints.

## Steps

1. Import repo into Vercel.
2. Set project root to `apps/web`.
3. Configure build settings:
   - install: `pnpm install`
   - build: `pnpm --filter @gitnut/web build`
   - output: Next.js default

## Environment variables

- `NEXT_PUBLIC_API_BASE_URL`
- `NEXT_PUBLIC_RPC_URL`
- `NEXT_PUBLIC_CHAIN`

## Notes

- If you use Next.js route handlers, ensure they do not require server-only secrets.
- Prefer calling the API service directly for privileged actions.
