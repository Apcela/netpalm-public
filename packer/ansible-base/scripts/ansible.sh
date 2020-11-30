#!/bin/bash -eux

# Install Ansible repository
apt -y update 
apt-get -y upgrade
apt -y update   # unbelievable, but this seems to be required
apt -y install software-properties-common
# apt-add-repository --yes --update ppa:ansible/ansible 
# apt -y update

# Install Ansible
apt -y install ansible 