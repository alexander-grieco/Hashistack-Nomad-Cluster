terraform {
  required_version = "1.1.2"

  backend "remote" {
    organization = "grieco-orchestrate"

    workspaces {
      name = "nomad-hashistack-network"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
}

