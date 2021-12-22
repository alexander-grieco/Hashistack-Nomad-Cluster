data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "grieco-orchestrate"
    workspaces = {
      name = "nomad-hashistack-network"
    }
  }
}