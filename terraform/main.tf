terraform {
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
  }
}

provider "aws" {
}

module "hashistack" {
  source = "./modules/hashistack"

  region             = var.region
  owner_email        = var.owner_name
  key_name           = var.key_name
  owner_name         = var.owner_name
  ami                = var.ami
  availability_zones = var.availability_zones
  stack_name         = var.stack_name
  allowlist_ip       = ["0.0.0.0/0"]
  encrypt_key        = var.encrypt_key
  vpc_id             = var.vpc_id
  encrypt_key_consul = var.encrypt_key_consul
}
