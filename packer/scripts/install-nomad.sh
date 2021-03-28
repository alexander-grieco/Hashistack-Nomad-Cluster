#!/bin/bash

set -e

# Disable interactive apt prompts
export DEBIAN_FRONTEND=noninteractive

# Nomad Version
export NOMAD_VERSION="1.0.4"

# Dependencies
sudo apt-get install -y software-properties-common
sudo apt-get update
sudo apt-get install -y unzip tree jq curl

# get binary
curl --silent --remote-name https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip

# install Nomad
unzip nomad_${NOMAD_VERSION}_linux_amd64.zip
sudo chown root:root nomad
sudo mv nomad /usr/local/bin/
nomad version
nomad -autocomplete-install                     # enable autocomplete
complete -C /usr/local/bin/nomad nomad
sudo mkdir --parents /opt/nomad                 # make data directory for Nomad

# create Nomad directories
sudo mkdir --parents /etc/nomad.d
sudo chmod 700 /etc/nomad.d
