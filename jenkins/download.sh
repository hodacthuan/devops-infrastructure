#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

echo "Do you want to download jenkins from S3?(y/n)"
read ANS

if [ "$ANS" != "y" ] && [ "$ANS" != "Y" ]; then
    echo "I won't download."
else
    # env
    source ${DEPLOY_DIR}/config/.common.env

    # install and config aws
    source ${DEPLOY_DIR}/scripts/install-config-aws-cli.sh

    # install and config aws
    aws configure --profile ${ADMIN_PROFILE} set aws_access_key_id ${BACKUP_S3_ACCESS_KEY_ID}
    aws configure --profile ${ADMIN_PROFILE} set aws_secret_access_key ${BACKUP_S3_SECRET_ACCESS_KEY}
    aws configure --profile ${ADMIN_PROFILE} set region ${BACKUP_AWS_REGION}

    sudo rm -rf ${DEPLOY_DIR}/volumes/jenkins-data
    # sync sync data from jenkins-data folder to S3 bucket
    aws s3 --profile ${ADMIN_PROFILE} sync s3://${S3_BACKUP_BUCKET}/jenkins-data/latest-data ${DEPLOY_DIR}/volumes/jenkins-data
fi