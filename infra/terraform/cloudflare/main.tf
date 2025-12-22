terraform {
  required_version = ">= 1.6.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

# Minimal DNS records for web + api.
# In production consider:
# - WAF managed rules
# - rate limiting
# - cache rules for static assets
# - workers for edge auth

resource "cloudflare_record" "web" {
  zone_id = var.zone_id
  name    = var.web_host
  type    = "CNAME"
  value   = var.web_target
  proxied = true
}

resource "cloudflare_record" "api" {
  zone_id = var.zone_id
  name    = var.api_host
  type    = "CNAME"
  value   = var.api_target
  proxied = true
}
