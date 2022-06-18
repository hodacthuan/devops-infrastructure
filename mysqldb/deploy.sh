#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source .env

function up() {
    sudo rm -rf mysql-data

    docker-compose -f docker-compose.yml build
    docker-compose -f docker-compose.yml down
    docker-compose -f docker-compose.yml up -d

    # sleep 5s
    # docker exec -w /scripts -it mm-mongodb sh -c "bash db-scripts.sh createUser"

    echo -ne '\n'
}

function down() {
    docker-compose -f docker-compose.yml down
}


COMMAND=$1

case $COMMAND in

    up)
        up
        ;;

    down)
        down
        ;;

    list)
        docker-compose -f docker-compose.yml ps
        ;;

    exec)
        docker exec -w /scripts -it mm-mongodb bash
        ;;

    backup)
        docker exec -w /scripts -it mm-mongodb sh -c "bash db-scripts.sh exportAndUpload"
        ;;

    restore)
        docker exec -w /scripts -it mm-mongodb sh -c "bash db-scripts.sh downloadAndImport"
        ;;

    add-crontab)
        docker exec -w /scripts -it mm-mongodb sh -c "printenv >> /etc/.env && bash add-crontab.sh"
        ;;
esac
