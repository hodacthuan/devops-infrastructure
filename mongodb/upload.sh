#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

# MONGODB: exportAndUpload
docker exec -w /scripts -it ${SERVICE_NAME}-mongodb sh -c "bash db-scripts.sh exportAndUpload"

echo -ne '\n'

exit 0