datacenter = "dc1"
data_dir = "/opt/nomad"

server {
  enabled = true
  bootstrap_expect = SERVER_COUNT

  encrypt = "ENCRYPT_KEY"
}

tls {
  http = true
  rpc  = true

  ca_file   = ${nomad-ca}
  cert_file = ${server-pem}
  key_file  = ${server-key-pem}

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
