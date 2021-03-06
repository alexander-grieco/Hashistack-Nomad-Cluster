output "ip_addresses" {
  value = <<CONFIGURATION
Server IPs:
${module.hashistack.server_addresses}
To connect, add your private key and SSH into any client or server with
`ssh ubuntu@PUBLIC_IP`. You can test the integrity of the cluster by running:
  $ consul members
  $ nomad server members
  $ nomad node status
The Nomad UI can be accessed at ${module.hashistack.nomad_addr}/ui
The Consul UI can be accessed at ${module.hashistack.consul_addr}/ui

CLI environment variables:
export NOMAD_CLIENT_DNS=http://${module.hashistack.client_addr}
export NOMAD_ADDR=${module.hashistack.nomad_addr}
export CONSUL_HTTP_ADDR=${module.hashistack.consul_addr}

Run these commands if you have ACLs enabled
export NOMAD_TOKEN=$(nomad acl bootstrap | grep "Secret ID" | xargs | cut -d' ' -f4)
export CONSUL_HTTP_TOKEN=$(sed -e 's/^"//' -e 's/"$//' <<<$(terraform output consul_master_token))
CONFIGURATION
}

output "consul_master_token" {
  sensitive = true
  value     = module.hashistack.consul_master_token
}