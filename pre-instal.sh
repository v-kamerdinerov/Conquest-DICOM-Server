#!/bin/bash
# Pre-isntall software
sudo apt update 
sudo apt upgrade -y
sudo apt install make g++ apache2 unzip p7zip-full lua5.1 ua5.1-dev lua-socket -y
sudo a2enmod cgi
systemctl restart apache2
