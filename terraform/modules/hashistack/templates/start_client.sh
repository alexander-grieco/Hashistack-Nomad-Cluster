#!/bin/bash
set -e

SHAREDDIR=/ops
CONFIGDIR=$SHAREDDIR/files
SCRIPTDIR=$SHAREDDIR/scripts

CONSULCONFIGDIR=/etc/consul.d
NOMADCONFIGDIR=/etc/nomad.d
HOME_DIR=ubuntu

PRIVATE_IPV4=$(ip -4 route get 1.1.1.1 | grep -oP 'src \K\S+')
DOCKER_BRIDGE_IP_ADDRESS=$(ip -4 address show docker0 | awk '/inet / { print $2 }' | cut -d/ -f1)

## Replace existing Consul binary if remote file exists
if [[ `wget -S --spider $CONSUL_BINARY  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L $CONSUL_BINARY > consul.zip
  sudo unzip -o consul.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/consul
  sudo chown root:root /usr/local/bin/consul
fi

# CONSUL CONFIGURATION

# Move files to appropriate locations
sudo cp $CONFIGDIR/consul-client.hcl $CONSULCONFIGDIR/consul.hcl
sudo cp $CONFIGDIR/consul.service /etc/systemd/system/consul.service

# Replace variables
sed -i "s/PRIVATE_IPV4/$PRIVATE_IPV4/g" $CONSULCONFIGDIR/consul.hcl
sed -i "s/RETRY_JOIN/${retry_join}/g" $CONSULCONFIGDIR/consul.hcl

# add key for gossip encryption
sed -i "s@ENCRYPT_KEY_CONSUL@${encrypt_key_consul}@g" $CONSULCONFIGDIR/consul.hcl

sudo systemctl enable consul.service
sudo systemctl start consul.service
sleep 10

# NOMAD CONFIGURATION

## Replace existing Nomad binary if remote file exists
if [[ `wget -S --spider $NOMAD_BINARY  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L $NOMAD_BINARY > nomad.zip
  sudo unzip -o nomad.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/nomad
  sudo chown root:root /usr/local/bin/nomad
fi

# Client config
sudo cp $CONFIGDIR/nomad-client.hcl $NOMADCONFIGDIR/nomad.hcl
sudo cp $CONFIGDIR/nomad.service /etc/systemd/system/nomad.service
sed -i "s/NODE_CLASS/\"${node_class}\"/g" $NOMADCONFIGDIR/nomad.hcl

sudo systemctl enable nomad
sudo systemctl start nomad
sudo systemctl status nomad

sleep 10

# Add hostname to /etc/hosts
echo "127.0.0.1 $(hostname)" | sudo tee --append /etc/hosts


echo "nameserver $PRIVATE_IPV4" | tee /etc/resolv.conf.new
cat /etc/resolv.conf | tee --append /etc/resolv.conf.new
mv /etc/resolv.conf.new /etc/resolv.conf

# Add search service.consul at bottom of /etc/resolv.conf
echo "search service.consul" | tee --append /etc/resolv.conf

# Add Docker bridge network IP to /etc/resolv.conf (at the top)
echo "nameserver $DOCKER_BRIDGE_IP_ADDRESS" | sudo tee /etc/resolv.conf.new
cat /etc/resolv.conf | sudo tee --append /etc/resolv.conf.new
sudo mv /etc/resolv.conf.new /etc/resolv.conf

# Set env vars for tool CLIs
echo "export NOMAD_ADDR=http://127.0.0.1:4646" | sudo tee --append /home/$HOME_DIR/.bashrc
echo "export CONSUL_HTTP_ADDR=http://127.0.0.1:8500" | tee --append /home/$HOME_DIR/.bashrc

# Start Docker
service docker restart