#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source ./common.sh

sudo rm -rf mongo-data/$MONGODB_NAME

docker-compose -f docker-compose.yml down
docker-compose -f docker-compose.yml up -d

# MONGODB: create database inside docker, download DB then import DB to mongodb
docker exec -w /scripts -it ${MONGODB_NAME}-mongodb sh -c "bash db-scripts.sh downloadAndImport"

# MONGODB: Add crontab job to export and upload database
if [ "$DEPLOY_ENV" == "prod" ]; 
then
    docker exec -w /scripts -it ${MONGODB_NAME}-mongodb sh -c "printenv >> /etc/.env && bash add-crontab.sh"
fi

echo -ne '\n'

exit 0