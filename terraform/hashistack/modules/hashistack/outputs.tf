output "server_tag_name" {
  value = values(aws_instance.nomad_server)[*].tags.Name
}

output "server_public_ips" {
  value = values(aws_instance.nomad_server)[*].public_ip
}

output "server_private_ips" {
  value = values(aws_instance.nomad_server)[*].private_ip
}

output "server_addresses" {
  value = join("\n", formatlist(" * instance %v - Public: %v, Private: %v", values(aws_instance.nomad_server)[*].tags.Name, values(aws_instance.nomad_server)[*].public_ip, values(aws_instance.nomad_server)[*].private_ip))
}

output "client_addr" {
  value = var.consul_ssl == true ? "https://test.alexgrieco.io" : "http://test.alexgrieco.io"
}

output "nomad_addr" {
  value = var.nomad_ssl == true ? "https://admin.alexgrieco.io:4646" : "http://admin.alexgrieco.io:4646"
}

output "consul_addr" {
  value = var.consul_ssl == true ? "https://admin.alexgrieco.io:8501" : "http://admin.alexgrieco.io:8500"
}

output "hosts_file" {
  value = join("\n", concat(
    formatlist(" %-16s  %v.hs", values(aws_instance.nomad_server)[*].public_ip, values(aws_instance.nomad_server)[*].tags.Name)
  ))
}

output "client_asg_arn" {
  value = aws_autoscaling_group.nomad_client.arn
}

output "client_asg_name" {
  value = aws_autoscaling_group.nomad_client.name
}

output "ssh_file" {
  value = join("\n", concat(
    formatlist("Host %v.hs\n  User ubuntu\n  HostName %v\n", values(aws_instance.nomad_server)[*].tags.Name, values(aws_instance.nomad_server)[*].public_dns)
  ))
}

output "consul_master_token" {
  sensitive   = true
  description = "The Consul master token."
  value       = random_uuid.consul_master_token.result
}