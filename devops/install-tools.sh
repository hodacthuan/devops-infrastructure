#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

echo 'INSTALL TOOLS NEEDED'
git config --global core.filemode false

# Install docker
./install-docker.sh
./install-docker-compose.sh

# install awscli
aws --version >/dev/null 2>&1
[[ $? != 0 ]] && sudo apt-get install awscli -y

# install redis-cli
redis-cli --version >/dev/null 2>&1
[[ $? != 0 ]] && sudo apt-get install redis-tools -y

exit 0