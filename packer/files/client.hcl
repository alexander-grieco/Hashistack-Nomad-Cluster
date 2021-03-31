datacenter = "dc1"
data_dir = "/opt/nomad"

client {
  enabled = true
}

# Require TLS
tls {
  http = true
  rpc  = true

  ca_file   = ${nomad-ca}
  cert_file = ${client-pem}
  key_file  = ${client-key-pem}

  verify_server_hostname = true
  verify_https_client    = true
}