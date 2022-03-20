#!/bin/bash

DOCKER=$(which docker)

if [[ $DOCKER == '' ]]; then 
    echo 'Install docker ...'

    sudo apt-get dist-upgrade
    uname

    sudo apt-get remove docker docker-engine docker.io containerd runc -y

    sudo apt-get update

    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    # Docker Engine 

    sudo apt-get update

    sudo apt install -y docker-ce

    sudo apt install -y docker-ce docker-ce-cli containerd.io

    apt-cache madison docker-ce

    # very important to make sure docker work properly
    sudo chmod 666 /var/run/docker.sock

    sudo systemctl enable docker

    # sudo systemctl status docker
    
fi;