data_dir = "/opt/consul/data"
bind_addr = "0.0.0.0"
datacenter = "dc1"
primary_datacenter = "dc1"

advertise_addr = "PRIVATE_IPV4"
bootstrap_expect = SERVER_COUNT

addresses {
  CONSUL_HTTP = "0.0.0.0"
}

ports {
  http  = 8500
  https = 8501
  dns   = 8600
}

log_level = "DEBUG"
leave_on_terminate = true

retry_join = ["RETRY_JOIN"]
server = true
ui = true

connect {
  enabled = true
}

autopilot {
  cleanup_dead_servers = true
  last_contact_threshold = "200ms"
  max_trailing_logs = 250
  server_stabilization_time = "10s"
}

acl {
  enabled                  = ACLs_ENABLED
  default_policy           = "ACLs_DEFAULT_POLICY"
  enable_token_persistence = true
  tokens {
    master = "CONSUL_TOKEN"
  }
}

encrypt = "ENCRYPT_KEY_CONSUL"
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

# tls config
verify_incoming = CONSUL_SSL
verify_outgoing = CONSUL_SSL
verify_server_hostname = CONSUL_SSL

ca_file = "/etc/consul.d/consul-ca.pem"
cert_file = "/etc/consul.d/server.pem"
key_file = "/etc/consul.d/server-key.pem"

auto_encrypt {
  allow_tls = CONSUL_SSL
}
