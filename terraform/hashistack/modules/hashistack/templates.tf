data "terraform_remote_state" "certs" {
  backend = "remote"

  config = {
    organization = "grieco-tech"
    workspaces = {
      name = "nomad-hashistack-certs"
    }
  }
}

data "template_file" "user_data_server" {
  template = file("${path.module}/templates/start_server.sh")

  vars = {
    region                    = var.region
    nomad_binary              = var.nomad_binary
    consul_binary             = var.consul_binary
    consul_acls_enabled       = var.consul_acls_enabled
    consul_master_token       = random_uuid.consul_master_token.result
    encrypt_key_consul        = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    consul_ca_cert            = data.terraform_remote_state.certs.outputs.consul_cacert
    consul_server_cert        = data.terraform_remote_state.certs.outputs.consul_server_cert
    consul_server_private_key = data.terraform_remote_state.certs.outputs.consul_server_key
    acls_default_policy       = var.acls_default_policy
    server_count              = var.server_count
    retry_join                = var.retry_join
    nomad_acls_enabled        = var.nomad_acls_enabled
    nomad_ca_cert             = data.terraform_remote_state.certs.outputs.nomad_cacert
    nomad_server_cert         = data.terraform_remote_state.certs.outputs.nomad_server_cert
    nomad_server_private_key  = data.terraform_remote_state.certs.outputs.nomad_server_key
    nomad_cli_cert            = data.terraform_remote_state.certs.outputs.nomad_cli_cert
    nomad_cli_private_key     = data.terraform_remote_state.certs.outputs.nomad_cli_key
    encrypt_key_nomad         = replace(random_id.nomad-gossip-key.b64_std, "/", "\\/")
  }
}

data "template_file" "user_data_client" {
  template = file("${path.module}/templates/start_client.sh")

  vars = {
    region                    = var.region
    nomad_binary              = var.nomad_binary
    consul_binary             = var.consul_binary
    consul_acls_enabled       = var.consul_acls_enabled
    consul_ca_cert            = data.terraform_remote_state.certs.outputs.consul_cacert
    consul_client_cert        = data.terraform_remote_state.certs.outputs.consul_client_cert
    consul_client_private_key = data.terraform_remote_state.certs.outputs.consul_client_key
    consul_master_token       = random_uuid.consul_master_token.result
    acls_default_policy       = var.acls_default_policy
    encrypt_key_consul        = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    node_class                = var.node_class
    nomad_acls_enabled        = var.nomad_acls_enabled
    nomad_ca_cert             = data.terraform_remote_state.certs.outputs.nomad_cacert
    nomad_client_cert         = data.terraform_remote_state.certs.outputs.nomad_client_cert
    nomad_client_private_key  = data.terraform_remote_state.certs.outputs.nomad_client_key
    retry_join                = var.retry_join
  }
}
