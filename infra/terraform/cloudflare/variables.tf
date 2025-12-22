variable "api_token" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "web_host" {
  type        = string
  description = "DNS name for the web app"
  default     = "gitnut"
}

variable "api_host" {
  type        = string
  description = "DNS name for the API"
  default     = "api"
}

variable "web_target" {
  type        = string
  description = "CNAME target for web (load balancer hostname)"
}

variable "api_target" {
  type        = string
  description = "CNAME target for api (load balancer hostname)"
}
