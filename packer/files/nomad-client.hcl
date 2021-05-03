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

acl {
  enabled = ACLs_ENABLED
}


# Require TLS
tls {
  http = true
  rpc  = true

  ca_file   = "/etc/nomad.d/nomad-ca.pem"
  cert_file = "/etc/nomad.d/client.pem"
  key_file  = "/etc/nomad.d/client-key.pem"

  verify_server_hostname = true
  verify_https_client    = true
}

consul {
  ssl        = true
  verify_ssl = true
  address    = "127.0.0.1:8501"
  ca_file    = "/etc/consul.d/consul-ca.pem"
  cert_file  = "/etc/consul.d/client.pem"
  key_file   = "/etc/consul.d/client-key.pem"
  token      = "CONSUL_TOKEN"
}

telemetry {
  collection_interval        = "5s"
  disable_hostname           = true
  prometheus_metrics         = true
  publish_allocation_metrics = true
  publish_node_metrics       = true
}