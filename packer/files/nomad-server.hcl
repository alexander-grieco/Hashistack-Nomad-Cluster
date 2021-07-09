datacenter = "dc1"
bind_addr = "0.0.0.0"
data_dir = "/opt/nomad/data"
log_level = "DEBUG"

leave_on_terminate = true

server {
  enabled = true
  bootstrap_expect = SERVER_COUNT

  encrypt = "ENCRYPT_KEY"

  server_join {
    retry_join = ["RETRY_JOIN"]
  }
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
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
