data "template_file" "user_data_server" {
  template = file("${path.module}/templates/user-data-server.sh")

  vars = {
    server_count  = try(var.server_count, length(distinct(data.aws_subnet_ids.nomad.ids)))
    region        = var.region
    nomad_binary  = var.nomad_binary
  }
}

data "template_file" "user_data_client" {
  template = file("${path.module}/templates/user-data-client.sh")

  vars = {
    region        = var.region
    nomad_binary  = var.nomad_binary
    node_class    = "hashistack-client"
  }
}