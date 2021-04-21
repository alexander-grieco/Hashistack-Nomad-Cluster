data "template_file" "user_data_server" {
  template = file("${path.module}/templates/user-data-server.sh")

  vars = {
    server_count  = length(distinct(data.aws_subnet_ids.nomad.ids))
    region        = var.region
    retry_join    = var.retry_join
    consul_binary = var.consul_binary
    nomad_binary  = var.nomad_binary
    encrypt_key   = var.encrypt_key
  }
}

data "template_file" "user_data_client" {
  template = file("${path.module}/templates/user-data-client.sh")

  vars = {
    region        = var.region
    retry_join    = var.retry_join
    consul_binary = var.consul_binary
    nomad_binary  = var.nomad_binary
    node_class    = "hashistack-client"
  }
}
