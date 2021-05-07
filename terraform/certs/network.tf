data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "grieco-tech"
    workspaces = {
      name = "nomad-hashistack-network"
    }
  }
}
