#!/bin/bash

set -e
HOME_DIR=ubuntu

# Disable interactive apt prompts
export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

cd /ops

# Dependencies
sudo apt-get update
sudo apt-get install -y zip curl

# Consul Variables
CONSULDOWNLOAD=https://releases.hashicorp.com/consul/${CONSULVERSION}/consul_${CONSULVERSION}_linux_amd64.zip
CONSULCONFIGDIR=/etc/consul.d
CONSULDIR=/opt/consul

# Nomad Variables
NOMADDOWNLOAD=https://releases.hashicorp.com/nomad/${NOMADVERSION}/nomad_${NOMADVERSION}_linux_amd64.zip
NOMADCONFIGDIR=/etc/nomad.d
NOMADDIR=/opt/nomad

# Disable the firewall
sudo ufw disable || echo "ufw not installed"

# install Consul
curl -sL -o consul.zip $CONSULDOWNLOAD
sudo unzip consul.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/consul
sudo chown root:root /usr/local/bin/consul

# configure Consul directories
sudo mkdir -p $CONSULCONFIGDIR
sudo chown --recursive ubuntu:ubuntu $CONSULCONFIGDIR
sudo mkdir -p $CONSULDIR

# install Nomad
curl -L $NOMADDOWNLOAD > nomad.zip
sudo unzip nomad.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/nomad
sudo chown root:root /usr/local/bin/nomad
nomad version

# enable Nomad autocomplete
nomad -autocomplete-install
complete -C /usr/local/bin/nomad nomad

# configure Nomad directories
sudo mkdir -p $NOMADCONFIGDIR
sudo chown --recursive ubuntu:ubuntu $NOMADCONFIGDIR
sudo mkdir -p $NOMADDIR

# install Docker
distro=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
sudo apt-get install -y apt-transport-https ca-certificates gnupg2
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/${distro} $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ubuntu

# reenable interactive prompts
echo 'debconf debconf/frontend select Dialog' | sudo debconf-set-selections
