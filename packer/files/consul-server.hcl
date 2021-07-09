datacenter = "dc1"
bind_addr = "0.0.0.0"
data_dir = "/opt/consul/data"
client_addr = "0.0.0.0"

advertise_addr = "PRIVATE_IPV4"
bootstrap_expect = SERVER_COUNT

leave_on_terminate = true
log_level = "DEBUG"
server = true

encrypt = "ENCRYPT_KEY_CONSUL"
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

retry_join = ["RETRY_JOIN"]
ui = true
