terraform {
  backend "remote" {
  organization = "grieco-tech"

  workspaces {
    name = "test-blog"
  }
  }
  required_providers {
  aws = {
    source = "hashicorp/aws"
    version = "3.33.0"
  }
  }
}

provider "aws" {
}

resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
}



