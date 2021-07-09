terraform {
  backend "remote" {
    organization = "grieco-orchestrate"

    workspaces {
      name = "hashistack"
    }
  }
  
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}

provider "tfe" {
  # Configuration options
}

resource "tfe_organization" "grieco-hashistack" {
  name  = "grieco-hashistack"
  email = "agrieco@pm.me"
}

resource "tfe_organization_token" "gh-token" {
  organization = "grieco-hashistack"
}

resource "tfe_workspace" "hashistack" {
  name         = "hashistack"
  organization = tfe_organization.grieco-hashistack.id
}