#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

# source env
[[ -f /etc/.env ]] && source /etc/.env

# set environments
# echo $DB_NAME
# echo $DB_USER
# echo $DB_PASSWORD
# echo $BACKUP_S3_ACCESS_KEY_ID
# echo $BACKUP_S3_SECRET_ACCESS_KEY
# echo $BACKUP_S3_REGION
# echo $MONGO_INITDB_ROOT_USERNAME
# echo $MONGO_INITDB_ROOT_PASSWORD

AWS_PROFILE=aws_profile

S3_LATEST_DIR=/scripts/s3-latest-database/${DB_NAME}
LATEST_DIR=/scripts/latest-database/${DB_NAME}

MONGO_SCRIPT_FILE=/scripts/script.js

BACKUP_DATE_DIR=$(date +'%Y-%m-%d')

# get input and check input valid
INPUT1=${1}
ACCEPTED_VALS=(upload download import downloadAndImport info exportAndUpload export)
[[ ! " ${ACCEPTED_VALS[@]} " =~ "${INPUT1}" ]] && echo "ONLY ACCEPT: ${ACCEPTED_VALS[@]}" && exit 0

function configAWS(){
    # install and config aws
    aws configure --profile ${AWS_PROFILE} set aws_access_key_id ${BACKUP_S3_ACCESS_KEY_ID}
    aws configure --profile ${AWS_PROFILE} set aws_secret_access_key ${BACKUP_S3_SECRET_ACCESS_KEY}
    aws configure --profile ${AWS_PROFILE} set region ${BACKUP_S3_REGION}
}
function runMongoScript(){
    rm -rf ${MONGO_SCRIPT_FILE}
    cp ${1} ${MONGO_SCRIPT_FILE}
    sed -ri -e "s!DB_NAME!${DB_NAME}!g" ${MONGO_SCRIPT_FILE}
    sed -ri -e "s!DB_USER!${DB_USER}!g" ${MONGO_SCRIPT_FILE}
    sed -ri -e "s!DB_PASSWORD!${DB_PASSWORD}!g" ${MONGO_SCRIPT_FILE}

    mongo --host localhost -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} < ${MONGO_SCRIPT_FILE}
}

function downloadDB(){
    echo "Do you want to download ${DB_NAME} from S3?(y/n)"
    read ANS
    if [ "$ANS" == "y" ] || [ "$ANS" == "Y" ]; then
        configAWS
        # download latest database from s3
        rm -rf ${S3_LATEST_DIR}
        mkdir -p ${S3_LATEST_DIR}
        echo "Downloading..."
        aws s3 --profile ${AWS_PROFILE} cp --recursive s3://${BACKUP_S3_BUCKET}/${MONGODB_NAME}-database-backup/latest-database ${S3_LATEST_DIR}/
    fi
    chmod 777 -R ${S3_LATEST_DIR}
}

function importDB(){
    runMongoScript mongo-create-user.js
    
    # get list file in dir
    COLLECTIONS_ARRAY=()
    for FILE in ${S3_LATEST_DIR}/*
    do 
        ELEMENT=`echo $FILE | awk -F/ '{print $NF}' | awk -F. '{print $1}'`
        COLLECTIONS_ARRAY+=( "${ELEMENT}" )
    done

    # import all database
    for COLLECTION in "${COLLECTIONS_ARRAY[@]}"
    do  
        echo ${COLLECTION}
        mongoimport -d ${DB_NAME} -c ${COLLECTION} --file ${S3_LATEST_DIR}/${COLLECTION}.json -h localhost -u ${DB_USER} -p ${DB_PASSWORD} --authenticationDatabase ${DB_NAME}
    done
}

function exportDB(){
    # export collections
    echo "Export database..."
    rm -rf ${LATEST_DIR}
    mkdir -p ${LATEST_DIR}

    configAWS
    
    SHOW_COLLECTIONS=`runMongoScript mongo-show-database-info.js`
    COLLECTIONS_LIST_STRING=`echo ${SHOW_COLLECTIONS} | awk  -F${DB_NAME} '{print $2}' | awk  -F'bye' '{print $1}'`

    COLLECTIONS_ARRAY=()
    IFS=' ' read -r -a COLLECTIONS_ARRAY <<< "$COLLECTIONS_LIST_STRING"

    for COLLECTION in "${COLLECTIONS_ARRAY[@]}"
    do
        echo "${COLLECTION}"
        mongoexport -d ${DB_NAME} -c ${COLLECTION} -o ${LATEST_DIR}/${COLLECTION}.json -h localhost -u ${DB_USER} -p ${DB_PASSWORD} --authenticationDatabase ${DB_NAME}
    done
    chmod 777 -R ${LATEST_DIR}
}


function uploadDB(){
    # get list file in dir
    COLLECTIONS_ARRAY=()
    for FILE in ${LATEST_DIR}/*
    do 
        ELEMENT=`echo $FILE | awk -F/ '{print $NF}' | awk -F. '{print $1}'`
        COLLECTIONS_ARRAY+=( "${ELEMENT}" )
    done
    echo "${COLLECTIONS_ARRAY[@]}"

    # upload collections
    echo "Upload database... "
    for COLLECTION in "${COLLECTIONS_ARRAY[@]}"
    do
        echo "Uploading collection:..."
        aws s3 --profile ${AWS_PROFILE} cp ${LATEST_DIR}/${COLLECTION}.json s3://${BACKUP_S3_BUCKET}/${MONGODB_NAME}-database-backup/latest-database/
        aws s3 --profile ${AWS_PROFILE} cp ${LATEST_DIR}/${COLLECTION}.json s3://${BACKUP_S3_BUCKET}/${MONGODB_NAME}-database-backup/${BACKUP_DATE_DIR}/
    done
}

case "${INPUT1}" in
    download)
        downloadDB
        exit 0
    ;;
    import)
        importDB
        exit 0
    ;;
    downloadAndImport)
        downloadDB
        importDB
        exit 0
    ;;
    upload)
        uploadDB
        exit 0
    ;;
    export)
        exportDB
        exit 0
    ;;
    exportAndUpload)
        exportDB
        uploadDB
        exit 0
    ;;
    info)
        echo "mongodb://${MONGODB_NAME}-user:${MONGODB_NAME}-password@server:${MONGODB_PORT}/${MONGODB_NAME}-database"
        exit 0
    ;;
esac

