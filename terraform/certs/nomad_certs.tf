// NOMAD CA
resource "tls_private_key" "nomad-ca" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "nomad-ca" {
  is_ca_certificate     = true
  validity_period_hours = 87600

  key_algorithm   = tls_private_key.nomad-ca.algorithm
  private_key_pem = tls_private_key.nomad-ca.private_key_pem

  subject {
    common_name  = "nomad-ca.local"
    organization = var.tls_organization
  }

  allowed_uses = [
    "cert_signing",
    "digital_signature",
    "key_encipherment",
  ]
}

// NOMAD CLI
resource "tls_private_key" "nomad-cli" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "nomad-cli" {
  key_algorithm   = tls_private_key.nomad-cli.algorithm
  private_key_pem = tls_private_key.nomad-cli.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    var.server_dns_name,
  ]

  subject {
    common_name  = "client.global.nomad"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "nomad-cli" {
  cert_request_pem = tls_cert_request.nomad-cli.cert_request_pem

  ca_key_algorithm   = tls_private_key.nomad-ca.algorithm
  ca_private_key_pem = tls_private_key.nomad-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.nomad-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "client_auth",
  ]
}

// NOMAD CLIENT

resource "tls_private_key" "nomad-client" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "nomad-client" {
  key_algorithm   = tls_private_key.nomad-client.algorithm
  private_key_pem = tls_private_key.nomad-client.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    "localhost",
    "client.global.nomad",
  ]

  subject {
    common_name  = "client.global.nomad"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "nomad-client" {
  cert_request_pem = tls_cert_request.nomad-client.cert_request_pem

  ca_key_algorithm   = tls_private_key.nomad-ca.algorithm
  ca_private_key_pem = tls_private_key.nomad-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.nomad-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "client_auth",
  ]
}

// NOMAD SERVER
resource "tls_private_key" "nomad-server" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "nomad-server" {
  key_algorithm   = tls_private_key.nomad-server.algorithm
  private_key_pem = tls_private_key.nomad-server.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    "localhost",
    "server.global.nomad",
    var.server_dns_name,
  ]

  subject {
    common_name  = "server.global.nomad"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "nomad-server" {
  cert_request_pem = tls_cert_request.nomad-server.cert_request_pem

  ca_key_algorithm   = tls_private_key.nomad-ca.algorithm
  ca_private_key_pem = tls_private_key.nomad-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.nomad-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "server_auth",
    "client_auth",
  ]
}