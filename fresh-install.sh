#!/bin/sh

# Script for when on a fresh install
# Tested on Ubuntu 20.04

apt-get remove -y 'libreoffice*'
apt update -y
apt upgrade -y

apt install wget curl vim -y

# Virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian eoan contrib" | tee /etc/apt/sources.list.d/virtualbox.list
apt update -y
apt install -y linux-headers-$(uname -r) dkms
apt-get -y install virtualbox-6.1
#wget https://download.virtualbox.org/virtualbox/6.1.0/virtualbox-6.1_6.1.0-142142~Ubuntu~eoan_amd64.deb
#dpkg -i virtualbox-6.1_6.1.18-142142~Ubuntu~eoan_amd64.deb
#rm virtualbox-6.1_6.1.18-142142~Ubuntu~eoan_amd64.deb

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Git
apt install git -y
git config --global user.name "Servin"
git config --global user.email "servin.nissen@gmail.com"

# Visual studio code
# wget https://go.microsoft.com/fwlink/?LinkID=760868
# apt install *.deb
# rm *.deb
apt update -y
apt install -y software-properties-common apt-transport-https
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt update -y
apt install -y code

# vnm
export XDG_CONFIG_HOME=$(pwd)
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 12
nvm install 14

# Vagrant
curl -O https://releases.hashicorp.com/vagrant/2.2.14/vagrant_2.2.14_x86_64.deb
apt install ./vagrant_2.2.14_x86_64.deb
rm ./vagrant_2.2.14_x86_64.deb

# Docker
apt update -y
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io
groupadd docker
gpasswd -a $USER docker
newgrp docker

# Docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

apt autoremove -y

