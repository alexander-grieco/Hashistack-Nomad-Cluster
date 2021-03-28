# Generate Gossip key
key=$(nomad operator keygen)
sed -i `s/ENCRYPT_KEY/$key` /etc/nomad.d/server.hcl




sudo systemctl enable nomad
sudo systemctl start nomad
sudo systemctl status nomad