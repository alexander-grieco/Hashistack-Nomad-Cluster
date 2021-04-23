datacenter = "dc1"
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"
log_level = "DEBUG"

server {
  enabled = true
  bootstrap_expect = SERVER_COUNT

  encrypt = "ENCRYPT_KEY"

  server_join {
    retry_join = ["RETRY_JOIN"]
  }
}

tls {
  http = true
  rpc  = true

  ca_file   = "/etc/nomad.d/nomad-ca.pem"
  cert_file = "/etc/nomad.d/server.pem"
  key_file  = "/etc/nomad.d/server-key.pem"

  verify_server_hostname = true
  verify_https_client    = true
}

autopilot {
  cleanup_dead_servers      = true
  last_contact_threshold    = "200ms"
  max_trailing_logs         = 250
  server_stabilization_time = "10s"
  enable_redundancy_zones   = false
  disable_upgrade_migration = false
  enable_custom_upgrades    = false
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
}
