#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

docker-compose -f ${DEPLOY_DIR}/services/${SERVICE_NAME}/docker-compose.yml down

source ./download.sh

sudo chmod 777 -R ${DEPLOY_DIR}/volumes/jenkins-data
rm -rf ${DEPLOY_DIR}/volumes/jenkins-data/.restored

docker-compose -f ${DEPLOY_DIR}/services/${SERVICE_NAME}/docker-compose.yml up -d

# Run in jenkins:
docker exec -it -u root ${JENKINS_CONTAINER_NAME} sh -c "\
    sleep 10s \
    && chown jenkins:jenkins -R /opt/bitnami/jenkins/jenkins_home/workspace \
    && git config --global http.sslVerify false \
    && chmod 400 /opt/bitnami/jenkins/jenkins_home/.ssh/id_rsa \
    && rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime \
"

# docker exec -it -u root ${JENKINS_CONTAINER_NAME} sh -c "\
#     apt-get update \
#     && apt-get install -y wget \
#     && sleep 20s \
#     && wget http://localhost:8080/jnlpJars/jenkins-cli.jar \
#     && java -jar jenkins-cli.jar -s http://localhost:8080/ -auth root:secret install-plugin gitlab-plugin gitlab-api \
#     && git config --global http.sslVerify false \
#     && chmod 400 /opt/bitnami/jenkins/jenkins_home/.ssh/id_rsa \
# "

echo -ne '\n'