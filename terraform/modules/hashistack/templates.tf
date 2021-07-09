data "template_file" "user_data_server" {
  template = file("${path.module}/templates/start_server.sh")

  vars = {
    region             = var.region
    nomad_binary       = var.nomad_binary
    consul_binary      = var.consul_binary
    encrypt_key_consul = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    server_count       = var.server_count
    retry_join         = var.retry_join
    encrypt_key_nomad  = replace(random_id.nomad-gossip-key.b64_std, "/", "\\/")
  }
}

data "template_file" "user_data_client" {
  template = file("${path.module}/templates/start_client.sh")

  vars = {
    region             = var.region
    nomad_binary       = var.nomad_binary
    consul_binary      = var.consul_binary
    encrypt_key_consul = replace(random_id.consul-gossip-key.b64_std, "/", "\\/")
    node_class         = var.node_class
    retry_join         = var.retry_join
  }
}
