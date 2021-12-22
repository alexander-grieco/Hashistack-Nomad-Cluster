terraform {
  required_version = "1.1.2"

  backend "remote" {
    organization = "grieco-orchestrate"

    workspaces {
      name = "nomad-hashistack"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {}

module "hashistack" {
  source = "./modules/hashistack"

  region              = var.region
  owner_email         = var.owner_name
  key_pair            = var.key_pair
  owner_name          = var.owner_name
  allowlist_ip        = ["0.0.0.0/0"]
  nomad_ssl           = var.nomad_ssl
  consul_ssl          = var.consul_ssl
  nomad_acls_enabled  = var.nomad_acls_enabled
  consul_acls_enabled = var.consul_acls_enabled
}
