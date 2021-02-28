#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

# env
source ${DEPLOY_DIR}/config/.common.env

# install and config aws
source ${DEPLOY_DIR}/scripts/install-config-aws-cli.sh
BACKUP_DATE_DIR=$(date +'%Y-%m-%d')

docker exec -u root ${JENKINS_CONTAINER_NAME} sh -c "chmod 777 -R /bitnami/jenkins"

sudo rm -rf ${DEPLOY_DIR}/volumes/jenkins-data/jenkins_home/workspace/*
# sync sync data from jenkins-data folder to S3 bucket
aws s3 --profile ${BACKUP_PROFILE} rm s3://${S3_BACKUP_BUCKET}/jenkins-data/latest-data/
aws s3 --profile ${BACKUP_PROFILE} sync ${DEPLOY_DIR}/volumes/jenkins-data s3://${S3_BACKUP_BUCKET}/jenkins-data/latest-data/

aws s3 --profile ${BACKUP_PROFILE} rm s3://${S3_BACKUP_BUCKET}/jenkins-data/${BACKUP_DATE_DIR}/
aws s3 --profile ${BACKUP_PROFILE} cp --recursive s3://${S3_BACKUP_BUCKET}/jenkins-data/latest-data/ s3://${S3_BACKUP_BUCKET}/jenkins-data/${BACKUP_DATE_DIR}/

exit 0