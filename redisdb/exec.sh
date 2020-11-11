#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

set -a
source ./common.sh

docker exec -it $REDISDB_NAME-redisdb bash

echo -ne '\n'

exit 0