terraform {
  required_version = "0.14.8"

  backend "remote" {
    organization = "grieco-tech"

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
  }
}