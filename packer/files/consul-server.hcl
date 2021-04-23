data_dir = "/opt/consul/data"
bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
advertise_addr = "IP_ADDRESS"
bootstrap_expect = SERVER_COUNT

log_level = "INFO"
encrypt = "ENCRYPT_KEY_CONSUL"
retry_join = ["RETRY_JOIN"]
server = true
ui = true
service {
  name = "consul"
}

# tls config
verify_incoming = true,
verify_outgoing = true,
verify_server_hostname = true,
ca_file = "/etc/consul.d/consul-agent-ca.pem",
cert_file = "/etc/consul.d/CERTFILE",
key_file = "/etc/consul.d/CERTKEYFILE",
auto_encrypt {
  allow_tls = true
}

ports {
  http = 8500
  https = 8501
}