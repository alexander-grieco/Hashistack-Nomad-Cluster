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
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
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

module "network" {
  source = "./modules/network"

  vpc_cidr          = var.vpc_cidr
  name_tag_prefix   = var.stack_name
  subnet_cidrs       = var.subnet_cidrs
  subnet_azs         = var.availability_zones
}

module "hashistack" {
  source = "./modules/hashistack"

  depends_on =[
    module.network
  ]

  region             = var.region
  owner_email        = var.owner_name
  key_name           = var.key_name
  owner_name         = var.owner_name
  ami                = var.ami
  availability_zones = var.availability_zones
  stack_name         = var.stack_name
  allowlist_ip       = ["0.0.0.0/0"]
  encrypt_key        = var.encrypt_key
  vpc_id             = module.network.vpc_id
  encrypt_key_consul = var.encrypt_key_consul
  subnet_ids         = module.network.subnet_ids
}
