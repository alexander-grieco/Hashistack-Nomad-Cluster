data_dir = "/opt/consul/data"
advertise_addr = "IP_ADDRESS"
bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

log_level = "INFO"
encrypt = "ENCRYPT_KEY_CONSUL"
retry_join = ["RETRY_JOIN"]
ui = true

verify_incoming = false,
verify_outgoing = true,
verify_server_hostname = true,
ca_file = "/etc/consul.d/consul-agent-ca.pem",
auto_encrypt = {
  tls = true
}

ports {
  http = 8500
  https = 8501
}