datacenter = "dc1"
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"
log_level = "DEBUG"

client {
  enabled = true
  node_class = NODE_CLASS

  options {
    "driver.raw_exec.enable"    = "1"
    "docker.privileged.enabled" = "true"
  }
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