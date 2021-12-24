// CONSUL CA
resource "tls_private_key" "consul-ca" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "consul-ca" {
  is_ca_certificate     = true
  validity_period_hours = 87600

  key_algorithm   = tls_private_key.consul-ca.algorithm
  private_key_pem = tls_private_key.consul-ca.private_key_pem

  subject {
    common_name  = "consul-ca.local"
    organization = var.tls_organization
  }

  allowed_uses = [
    "cert_signing",
    "digital_signature",
    "key_encipherment",
  ]
}


// CONSUL CLI
resource "tls_private_key" "consul-cli" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "consul-cli" {
  key_algorithm   = tls_private_key.consul-cli.algorithm
  private_key_pem = tls_private_key.consul-cli.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    "localhost",
    "cli.dc1.consul",
    "admin.alexgrieco.io",
    // "${cloudflare_record.admin.hostname}",
  ]

  subject {
    common_name  = "client.global.consul"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "consul-cli" {
  cert_request_pem = tls_cert_request.consul-cli.cert_request_pem

  ca_key_algorithm   = tls_private_key.consul-ca.algorithm
  ca_private_key_pem = tls_private_key.consul-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.consul-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
  ]
}

// CONSUL SERVER
resource "tls_private_key" "consul-server" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "consul-server" {
  key_algorithm   = tls_private_key.consul-server.algorithm
  private_key_pem = tls_private_key.consul-server.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    "localhost",
    "server.dc1.consul",
    "admin.alexgrieco.io",
    // "${cloudflare_record.admin.hostname}",
  ]

  subject {
    common_name  = "server.dc1.consul"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "consul-server" {
  cert_request_pem = tls_cert_request.consul-server.cert_request_pem

  ca_key_algorithm   = tls_private_key.consul-ca.algorithm
  ca_private_key_pem = tls_private_key.consul-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.consul-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "server_auth",
    "client_auth",
  ]
}

// CONSUL CLIENT
resource "tls_private_key" "consul-client" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "consul-client" {
  key_algorithm   = tls_private_key.consul-client.algorithm
  private_key_pem = tls_private_key.consul-client.private_key_pem

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = [
    "localhost",
    "client.dc1.consul",
    "test.alexgrieco.io",
    // "${cloudflare_record.client.hostname}",
  ]

  subject {
    common_name  = "client.dc1.consul"
    organization = var.tls_organization
  }
}

resource "tls_locally_signed_cert" "consul-client" {
  cert_request_pem = tls_cert_request.consul-client.cert_request_pem

  ca_key_algorithm   = tls_private_key.consul-ca.algorithm
  ca_private_key_pem = tls_private_key.consul-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.consul-ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "server_auth",
    "client_auth",
  ]
}
