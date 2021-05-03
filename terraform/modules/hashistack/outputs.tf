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

output "server_elb_dns" {
  value = aws_elb.nomad_server.dns_name
}

output "server_elb_dns_zone_id" {
  value = aws_elb.nomad_server.zone_id
}

output "client_elb_dns" {
  value = aws_elb.nomad_client.dns_name
}

output "client_elb_dns_zone_id" {
  value = aws_elb.nomad_client.zone_id
}

output "nomad_addr" {
  value = "https://${aws_elb.nomad_server.dns_name}:4646"
}

output "consul_addr" {
  value = "https://${aws_elb.nomad_server.dns_name}:8501"
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

output "nomad_cacert" {
  value = tls_self_signed_cert.nomad-ca.cert_pem
}

output "nomad_cli_cert" {
  value = tls_locally_signed_cert.nomad-cli.cert_pem
}

output "nomad_cli_key" {
  value = tls_private_key.nomad-cli.private_key_pem
}