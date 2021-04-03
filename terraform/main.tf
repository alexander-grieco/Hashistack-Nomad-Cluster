terraform {
  backend "remote" {
    organization = "grieco-tech"

    workspaces {
      name = "test-blog"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
    }
    nomad = {
      source = "hashicorp/nomad"
      version = "1.4.13"
    }
  }
}

provider "aws" {
}





