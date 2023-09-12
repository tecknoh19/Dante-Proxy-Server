#!/bin/bash

# This script was written for and executed on Ubuntu 20.04

#Init
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update Apt
apt-get update

# Install wget if not installed
apt-get install wget -y

#Install dante
apt-get install dante-server -y

# Remove default config file
cp /etc/danted.conf /etc/danted.old
rm /etc/danted.conf

# Download new public access conf file from github
cd /etc
wget https://raw.githubusercontent.com/tecknoh19/Dante-Proxy-Server/main/danted.conf

# update UFW to allow port defined in conf file (if installed)
ufw allow 6969

# Restart service and display status
service danted restart
systemctl status danted.service

