output "consul_cacert" {
  value     = tls_self_signed_cert.consul-ca.cert_pem
  sensitive = true
}

output "consul_server_cert" {
  value     = tls_locally_signed_cert.consul-server.cert_pem
  sensitive = true
}

output "consul_server_key" {
  value     = tls_private_key.consul-server.private_key_pem
  sensitive = true
}

output "nomad_cacert" {
  value     = tls_self_signed_cert.nomad-ca.cert_pem
  sensitive = true
}

output "nomad_server_cert" {
  value     = tls_locally_signed_cert.nomad-server.cert_pem
  sensitive = true
}

output "nomad_server_key" {
  value     = tls_private_key.nomad-server.private_key_pem
  sensitive = true
}

output "nomad_cli_cert" {
  value     = tls_locally_signed_cert.nomad-cli.cert_pem
  sensitive = true
}

output "nomad_cli_key" {
  value     = tls_private_key.nomad-cli.private_key_pem
  sensitive = true
}

output "consul_client_cert" {
  value     = tls_locally_signed_cert.consul-client.cert_pem
  sensitive = true
}

output "consul_client_key" {
  value     = tls_private_key.consul-client.private_key_pem
  sensitive = true
}

output "nomad_client_cert" {
  value     = tls_locally_signed_cert.nomad-client.cert_pem
  sensitive = true
}

output "nomad_client_key" {
  value     = tls_private_key.nomad-client.private_key_pem
  sensitive = true
}

output "server_dns_prefix" {
  value = var.server_dns_prefix
}

output "client_dns_prefix" {
  value = var.client_dns_prefix
}