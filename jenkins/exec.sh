if [[ ${4} == 'root' ]]; then
    docker exec -it -u root ${JENKINS_CONTAINER_NAME} /bin/bash
else 
    docker exec -it ${JENKINS_CONTAINER_NAME} /bin/bash
fi
exit 0