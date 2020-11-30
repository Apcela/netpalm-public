#!/bin/bash -eux

# I don't remember AT ALL why this is even here or what use it could serve in this case
# Uninstall Ansible and remove PPA.
apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

# Apt cleanup.
apt -y autoremove
apt -y update