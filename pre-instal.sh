#!/bin/bash
# Pre-isntall software
sudo apt update 
sudo apt upgrade
sudo apt install make g++ apache2 unzip p7zip-full lua5.1 ua5.1-dev lua-socket 
sudo a2enmod cgi
systemctl restart apache2
