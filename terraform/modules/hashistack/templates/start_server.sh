#!/bin/bash
SHAREDDIR=/ops/
CONFIGDIR=$SHAREDDIR/files
SCRIPTDIR=$SHAREDDIR/scripts

set -e

NOMADCONFIGDIR=/etc/nomad.d
CONSULCONFIGDIR=/etc/consul.d
HOME_DIR=ubuntu

# Wait for network
sleep 15

PRIVATE_IPV4=$(ip -4 route get 1.1.1.1 | grep -oP 'src \K\S+')
DOCKER_BRIDGE_IP__ADDRESS=$(ip -4 address show docker0 | awk '/inet / { print $2 }' | cut -d/ -f1)

# CONSUL CONFIGURATION

## Replace existing Consul binary if remote file exists
if [[ `wget -S --spider ${consul_binary}  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L ${consul_binary} > consul.zip
  sudo unzip -o consul.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/consul
  sudo chown root:root /usr/local/bin/consul
fi

## Copy files to correct location
sudo cp $CONFIGDIR/consul-server.hcl $CONSULCONFIGDIR/consul.hcl
sudo cp $CONFIGDIR/consul.service /etc/systemd/system/consul.service

## Replace variables
sed -i "s/PRIVATE_IPV4/$PRIVATE_IPV4/g" $CONSULCONFIGDIR/consul.hcl
sed -i "s/SERVER_COUNT/${server_count}/g" $CONSULCONFIGDIR/consul.hcl
sed -i "s/RETRY_JOIN/${retry_join}/g" $CONSULCONFIGDIR/consul.hcl
sed -i "s@ENCRYPT_KEY_CONSUL@${encrypt_key_consul}@g" $CONSULCONFIGDIR/consul.hcl

sudo systemctl enable consul.service
sudo systemctl start consul.service
sleep 10

# NOMAD CONFIGURATION

## Replace existing Nomad binary if remote file exists
if [[ `wget -S --spider ${nomad_binary}  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L ${nomad_binary} > nomad.zip
  sudo unzip -o nomad.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/nomad
  sudo chown root:root /usr/local/bin/nomad
fi

## Copy files to correct location
sudo cp $CONFIGDIR/nomad-server.hcl $NOMADCONFIGDIR/nomad.hcl
sudo cp $CONFIGDIR/nomad.service /etc/systemd/system/nomad.service

## Replace variables
sed -i "s/SERVER_COUNT/${server_count}/g" $NOMADCONFIGDIR/nomad.hcl
sed -i "s/RETRY_JOIN/${retry_join}/g" $NOMADCONFIGDIR/nomad.hcl
sed -i "s/PRIVATE_IPV4/$PRIVATE_IPV4/g" $NOMADCONFIGDIR/nomad.hcl
sed -i "s@ENCRYPT_KEY@${encrypt_key_nomad}@g" $NOMADCONFIGDIR/nomad.hcl


## Start Nomad service
sudo systemctl enable nomad.service
sudo systemctl start nomad.service

# Add hostname to /etc/hosts
echo "127.0.0.1 $(hostname)" | sudo tee --append /etc/hosts

echo "nameserver $PRIVATE_IPV4" | tee /etc/resolv.conf.new
cat /etc/resolv.conf | tee --append /etc/resolv.conf.new
mv /etc/resolv.conf.new /etc/resolv.conf

# Add search service.consul at bottom of /etc/resolv.conf
echo "search service.consul" | tee --append /etc/resolv.conf

# Add Docker bridge network IP to /etc/resolv.conf (at the top)
echo "nameserver $DOCKER_BRIDGE_PRIVATE_IPV4" | sudo tee /etc/resolv.conf.new
cat /etc/resolv.conf | sudo tee --append /etc/resolv.conf.new
sudo mv /etc/resolv.conf.new /etc/resolv.conf

# Start Docker
service docker restart

# Set env vars for tool CLIs
echo "export CONSUL_HTTP_ADDR=http://127.0.0.1:8500" | sudo tee --append /home/$HOME_DIR/.bashrc
echo "export NOMAD_ADDR=http://127.0.0.1:4646" | sudo tee --append /home/$HOME_DIR/.bashrc
