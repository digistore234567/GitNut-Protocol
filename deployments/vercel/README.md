# Vercel Deployment Template (Web)
This folder provides a production-ready Vercel configuration template for the GitNut web app (`apps/web`).

## What this does
- Sets up build + output settings for a Turborepo / pnpm workspace
- Provides example environment variables
- Includes a minimal `vercel.json` you can copy to repo root if you prefer root-based Vercel deployments

## Recommended approach
Deploy `apps/web` as a Vercel Project with:
- Root Directory: `apps/web`
- Install Command: `pnpm install --frozen-lockfile`
- Build Command: `pnpm build`
- Output Directory: `.next`

## Environment variables
Copy `deployments/vercel/.env.example` to your Vercel project env:
- `NEXT_PUBLIC_API_BASE_URL`
- `NEXT_PUBLIC_SOLANA_CLUSTER`
- `NEXT_PUBLIC_REGISTRY_PROGRAM_ID`
- `NEXT_PUBLIC_GITNUT_HOMEPAGE_URL`

## Notes
If you deploy the API separately (Fly/K8s/Systemd), ensure `NEXT_PUBLIC_API_BASE_URL` points to it.
