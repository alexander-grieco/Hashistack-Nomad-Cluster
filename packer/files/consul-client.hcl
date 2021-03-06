datacenter = "dc1"
bind_addr = "0.0.0.0"
data_dir = "/opt/nomad/data"
primary_datacenter = "dc1"

advertise_addr = "PRIVATE_IPV4"
advertise_addr_wan = "PRIVATE_IPV4"

addresses {
  CONSUL_HTTP = "0.0.0.0"
}

ports {
  dns   = 8600
  http  = 8500
  https = 8501
}


leave_on_terminate = true
log_level = "DEBUG"
server = false

connect {
  enabled = true
}

acl {
  enabled        = ACLs_ENABLED
  default_policy = "ACLs_DEFAULT_POLICY"
}

encrypt = "ENCRYPT_KEY_CONSUL"
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

retry_join = ["RETRY_JOIN"]
ui = true

verify_incoming = CONSUL_SSL
verify_outgoing = CONSUL_SSL
verify_server_hostname = CONSUL_SSL
ca_file = "/etc/consul.d/consul-ca.pem"
cert_file = "/etc/consul.d/client.pem"
key_file = "/etc/consul.d/client-key.pem"
