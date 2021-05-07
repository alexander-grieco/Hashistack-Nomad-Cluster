terraform {
  required_version = "0.14.8"

  backend "remote" {
    organization = "grieco-tech"

    workspaces {
      name = "nomad-hashistack"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
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

provider "aws" {
}

module "hashistack" {
  source = "./modules/hashistack"

  region       = var.region
  owner_email  = var.owner_name
  key_pair     = var.key_pair
  owner_name   = var.owner_name
  ami          = var.ami
  stack_name   = var.stack_name
  allowlist_ip = ["0.0.0.0/0"]
}
