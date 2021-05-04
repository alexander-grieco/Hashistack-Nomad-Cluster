data "template_file" "user_data_server" {
  template = file("${path.module}/templates/start_server.sh")

  vars = {
    region                    = var.region
    nomad_binary              = var.nomad_binary
    consul_binary             = var.consul_binary
    consul_acls_enabled       = var.consul_acls_enabled
    consul_master_token       = random_uuid.consul_master_token.result
    encrypt_key_consul        = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    consul_ca_cert            = tls_self_signed_cert.consul-ca.cert_pem
    consul_server_cert        = tls_locally_signed_cert.consul-server.cert_pem
    consul_server_private_key = tls_private_key.consul-server.private_key_pem
    acls_default_policy       = var.acls_default_policy
    server_count              = var.server_count
    retry_join                = var.retry_join
    nomad_acls_enabled        = var.nomad_acls_enabled
    nomad_ca_cert             = tls_self_signed_cert.nomad-ca.cert_pem
    nomad_server_cert         = tls_locally_signed_cert.nomad-server.cert_pem
    nomad_server_private_key  = tls_private_key.nomad-server.private_key_pem
    nomad_cli_cert            = tls_locally_signed_cert.nomad-cli.cert_pem
    nomad_cli_private_key     = tls_private_key.nomad-cli.private_key_pem
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
    consul_master_token       = random_uuid.consul_master_token.result
    acls_default_policy       = var.acls_default_policy
    encrypt_key_consul        = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    consul_ca_cert            = tls_self_signed_cert.consul-ca.cert_pem
    node_class                = var.node_class
    nomad_acls_enabled        = var.nomad_acls_enabled
    nomad_ca_cert             = tls_self_signed_cert.nomad-ca.cert_pem
    nomad_client_cert         = tls_locally_signed_cert.nomad-client.cert_pem
    nomad_client_private_key  = tls_private_key.nomad-client.private_key_pem
    retry_join                = var.retry_join
    encrypt_key               = var.encrypt_key
    consul_client_cert        = tls_locally_signed_cert.consul-client.cert_pem
    consul_client_private_key = tls_private_key.consul-client.private_key_pem
  }
}
