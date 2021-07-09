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
  value = "http://${aws_elb.nomad_client.dns_name}"
}

output "nomad_addr" {
  value = "http://${aws_elb.nomad_server.dns_name}:4646"
}

output "consul_addr" {
  value = "http://${aws_elb.nomad_server.dns_name}:8500"
}

output "hosts_file" {
  value = join("\n", concat(
    formatlist(" %-16s  %v.hs", values(aws_instance.nomad_server)[*].public_ip, values(aws_instance.nomad_server)[*].tags.Name)
  ))
}

output "ssh_file" {
  value = join("\n", concat(
    formatlist("Host %v.hs\n  User ubuntu\n  HostName %v\n", values(aws_instance.nomad_server)[*].tags.Name, values(aws_instance.nomad_server)[*].public_dns)
  ))
}
