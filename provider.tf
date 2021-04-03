variable "do_token" {
  sensitive = true
}
variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
variable "pvt_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519"
}
variable "cloudflare_email" {
  sensitive = true
}
variable "cloudflare_api_key" {
  sensitive = true
}
variable "cloudflare_zone_id" {
  sensitive = true
}
variable "github_token" {
  sensitive = true
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    github = {
      source = "integrations/github"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

# Configure the GitHub Provider
provider "github" {
  token = var.github_token
}
