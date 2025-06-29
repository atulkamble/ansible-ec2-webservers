#!/bin/bash
sudo dnf update -y
sudo dnf install -y python3 python3-pip
sudo pip3 install ansible
sudo mkdir -p /etc/ansible
ansible --version
