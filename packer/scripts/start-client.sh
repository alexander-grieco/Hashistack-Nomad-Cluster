#!/bin/bash
set -e

CONFIGDIR=/ops/files
NOMADCONFIGDIR=/etc/nomad.d
HOME_DIR=ubuntu

NODE_CLASS=$1

# Nomad
## Replace existing Nomad binary if remote file exists
if [[ `wget -S --spider $NOMAD_BINARY  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L $NOMAD_BINARY > nomad.zip
  sudo unzip -o nomad.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/nomad
  sudo chown root:root /usr/local/bin/nomad
fi

# Client config
sed -i "s/NODE_CLASS/\"$NODE_CLASS\"/g" $CONFIGDIR/client.hcl
sudo cp $CONFIGDIR/client.hcl $NOMADCONFIGDIR
sudo cp $CONFIGDIR/nomad.service /etc/systemd/system/nomad.service

sudo systemctl enable nomad
sudo systemctl start nomad
sudo systemctl status nomad
