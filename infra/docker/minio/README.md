# MinIO (GitNut)

MinIO provides S3-compatible storage for:
- repository archives
- build artifacts
- attestations (signed metadata)
- SBOM documents

Buckets created by `minio-init`:
- `gitnut-artifacts`
- `gitnut-attestations`

For production:
- use a real S3 provider or R2
- configure server-side encryption
- disable anonymous access
