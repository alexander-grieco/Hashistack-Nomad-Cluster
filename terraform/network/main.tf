terraform {
  required_version = "0.14.8"

  backend "remote" {
    organization = "grieco-tech"

    workspaces {
      name = "nomad-hashistack-network"
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
