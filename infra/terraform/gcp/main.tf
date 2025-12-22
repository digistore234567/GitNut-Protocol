terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

# Minimal placeholders:
# - storage buckets
# Production should add:
# - GKE
# - CloudSQL Postgres
# - Memorystore Redis
# - Secret Manager

resource "google_storage_bucket" "artifacts" {
  name          = "${var.name}-artifacts"
  location      = var.region
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "attestations" {
  name          = "${var.name}-attestations"
  location      = var.region
  force_destroy = false
  uniform_bucket_level_access = true
}

output "gcs_artifacts_bucket" {
  value = google_storage_bucket.artifacts.name
}
