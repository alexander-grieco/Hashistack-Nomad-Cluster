terraform {
  required_version = "1.0.2"

  backend "remote" {
    organization = "grieco-tech"

    workspaces {
      name = "nomad-hashistack"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.49.0"
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

module "network" {
  source = "./modules/network"

  subnet_azs       = var.subnet_azs
  stack_name       = var.stack_name
  vpc_cidr         = var.vpc_cidr
  subnet_cidrs     = var.subnet_cidrs
}

module "hashistack" {
  source = "./modules/hashistack"

  region       = var.region
  owner_email  = var.owner_name
  key_pair     = var.key_pair
  owner_name   = var.owner_name
  allowlist_ip = ["0.0.0.0/0"]

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.subnet_ids
}

