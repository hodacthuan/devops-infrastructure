#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source ./common.sh

# MONGODB: exportAndUpload
docker exec -w /scripts -it ${MONGODB_NAME}-mongodb sh -c "bash db-scripts.sh exportAndUpload"

echo -ne '\n'

exit 0