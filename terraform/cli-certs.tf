resource "local_file" "cacert" {
  sensitive_content = module.hashistack.nomad_cacert
  filename          = "${path.module}/certs/nomad-ca.pem"
}

resource "local_file" "cli_cert" {
  sensitive_content = module.hashistack.nomad_cli_cert
  filename          = "${path.module}/certs/cli.pem"
}

resource "local_file" "cli_key" {
  sensitive_content = module.hashistack.nomad_cli_key
  filename          = "${path.module}/certs/cli-key.pem"
}