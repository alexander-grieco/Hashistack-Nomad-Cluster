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
    "driver.docker.enable"      = "1"
    "driver.whitelist"          = "docker"
    "user.blacklist"            = "root,ubuntu"
  }
}

acl {
  enabled = ACLs_ENABLED
}


# Require TLS
tls {
  http = NOMAD_SSL
  rpc  = NOMAD_SSL

  ca_file   = "/etc/nomad.d/nomad-ca.pem"
  cert_file = "/etc/nomad.d/client.pem"
  key_file  = "/etc/nomad.d/client-key.pem"

  verify_server_hostname = NOMAD_SSL
  verify_https_client    = NOMAD_SSL
}

consul {
  ssl        = CONSUL_SSL
  verify_ssl = CONSUL_SSL
  address    = "CONSUL_ADDR"
  ca_file    = "/etc/consul.d/consul-ca.pem"
  cert_file  = "/etc/consul.d/client.pem"
  key_file   = "/etc/consul.d/client-key.pem"
  token      = "CONSUL_TOKEN"
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

// docker {
//   tls {
//     cert = "/etc/nomad.d/client.pem"
//     key  = "/etc/nomad.d/client-key.pem"
//     ca   = "/etc/nomad.d/nomad-ca.pem"
//   }
// }