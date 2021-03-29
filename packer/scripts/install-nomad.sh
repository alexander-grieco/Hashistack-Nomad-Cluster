#!/bin/bash

set -e

# # Disable interactive apt prompts
export DEBIAN_FRONTEND=noninteractive

cd /ops

# Nomad Variables
NOMADVERSION="1.0.4"
NOMADDOWNLOAD=https://releases.hashicorp.com/nomad/${NOMADVERSION}/nomad_${NOMADVERSION}_linux_amd64.zip
NOMADCONFIGDIR=/etc/nomad.d
NOMADDIR=/opt/nomad

# Dependencies
sudo apt-get install -y software-properties-common
sudo apt-get update -y
sudo apt-get install -y unzip tree jq curl

# install Nomad
curl -L $NOMADDOWNLOAD > nomad.zip
sudo unzip nomad.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/nomad
sudo chown root:root /usr/local/bin/nomad
nomad version
nomad -autocomplete-install           # enable autocomplete
complete -C /usr/local/bin/nomad nomad

#configure Nomad directories
sudo mkdir -p $NOMADCONFIGDIR
sudo chmod 755 $NOMADCONFIGDIR
sudo mkdir -p $NOMADDIR
sudo chmod 755 $NOMADDIR

# install Docker
# prepare docker isntallation
sudo apt-get install -y \
   apt-transport-https \
   ca-certificates \
   gnupg \
   lsb-release

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io