#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

export DEPLOY_ENV=${1}
if [[ $DEPLOY_ENV == '' ]]; then 
    echo "Please add DEPLOY_ENV to command line."
    exit 0
fi

if [[ ! -f $DEPLOY_ENV.env ]]; then 
    echo "Please add DEPLOY_ENV.env file"
    exit 0
fi

source $DEPLOY_ENV.env
