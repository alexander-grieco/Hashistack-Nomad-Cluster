datacenter = "dc1"
data_dir = "/opt/nomad"

server {
  enabled = true
  bootstrap_expect = 3

  encrypt = "ENCRYPT_KEY"
}
