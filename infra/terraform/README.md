# Terraform (GitNut)

This directory contains Terraform modules and examples to provision GitNut infrastructure.

Goals:
- minimal, repeatable deployments
- separate environments (staging/prod)
- support common providers:
  - AWS (EKS + RDS + ElastiCache + S3)
  - GCP (GKE + CloudSQL + Memorystore + GCS)
  - Cloudflare (DNS + WAF + CDN)

Notes:
- These are templates to bootstrap a real deployment.
- You must review security settings (IAM, networking, encryption) before production use.
