variable "name" {
  type        = string
  description = "Deployment name prefix"
  default     = "gitnut"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
