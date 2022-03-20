#!/bin/bash

DOCKER=$(which docker-compose)

if [[ $DOCKER == '' ]]; then 
    echo 'Install docker ...'

    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose

    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    #should be version 1.23.1
    docker-compose version

fi;