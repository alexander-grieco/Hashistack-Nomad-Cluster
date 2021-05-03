datacenter = "dc1"
bind_addr = "0.0.0.0"
data_dir = "/opt/nomad/data"
primary_datacenter = "dc1"

advertise_addr = "PRIVATE_IPV4"
advertise_addr_wan = "PRIVATE_IPV4"

addresses {
  https = "0.0.0.0"
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

verify_incoming = false
verify_outgoing = true
verify_server_hostname = true
ca_file = "/etc/consul.d/consul-ca.pem"

auto_encrypt = {
  tls = true
}


// telemetry {
//   prometheus_retention_time  = "24h"
//   disable_hostname           = true
// }
