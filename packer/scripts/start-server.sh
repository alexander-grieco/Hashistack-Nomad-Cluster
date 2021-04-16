#!/bin/bash

set -e

CONFIGDIR=/ops/files
NOMADCONFIGDIR=/etc/nomad.d

# Wait for network
sleep 15

SERVER_COUNT=$1

# Nomad
## Replace existing Nomad binary if remote file exists
if [[ `wget -S --spider $NOMAD_BINARY  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
  curl -L $NOMAD_BINARY > nomad.zip
  sudo unzip -o nomad.zip -d /usr/local/bin
  sudo chmod 0755 /usr/local/bin/nomad
  sudo chown root:root /usr/local/bin/nomad
fi

## Copy files to correct location
sed -i "s/SERVER_COUNT/$SERVER_COUNT/g" $CONFIGDIR/server.hcl
sudo cp $CONFIGDIR/server.hcl $NOMADCONFIGDIR
sudo cp $CONFIGDIR/nomad.service /etc/systemd/system/nomad.service

## Generate Gossip key
ENCRYPT_KEY=$(nomad operator keygen)
sed -i `s/ENCRYPT_KEY/$ENCRYPT_KEY` $NOMADCONFIGDIR/server.hcl

## Start Nomad service
sudo systemctl enable nomad.service
sudo systemctl start nomad.service