terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Minimal placeholders:
# - VPC + subnets
# - EKS cluster
# - S3 buckets
# - RDS Postgres
# - ElastiCache Redis
#
# For a production-ready setup, break these into modules and add:
# - KMS encryption
# - private networking
# - IRSA for pods
# - managed node groups / autoscaling

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.name}-artifacts"
  force_destroy = false
}

resource "aws_s3_bucket" "attestations" {
  bucket = "${var.name}-attestations"
  force_destroy = false
}

output "s3_artifacts_bucket" {
  value = aws_s3_bucket.artifacts.bucket
}

output "s3_attestations_bucket" {
  value = aws_s3_bucket.attestations.bucket
}
