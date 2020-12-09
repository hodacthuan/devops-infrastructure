#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source ./common.sh

docker-compose -f docker-compose.yml down
docker-compose -f docker-compose.yml up -d selenium

echo -ne '\n'

exit 0