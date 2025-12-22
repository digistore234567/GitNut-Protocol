variable "name" {
  type        = string
  description = "Deployment name prefix"
  default     = "gitnut"
}

variable "project" {
  type        = string
  description = "GCP project id"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}
