#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source ./common.sh

sudo rm -rf redis-data/$REDISDB_NAME

docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml down
docker-compose -f docker-compose.yml up -d

echo -ne '\n'

exit 0