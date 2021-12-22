terraform {
  required_version = "1.1.2"

  backend "remote" {
    organization = "grieco-orchestrate"

    workspaces {
      name = "nomad-hashistack-certs"
    }
  }
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.5.0"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}

