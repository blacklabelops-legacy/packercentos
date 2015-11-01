#!/bin/bash

# Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Reading config
source $CUR_DIR/atlas.cfg

#------------------
# SCRIPT ENTRYPOINT
#------------------

version=$1

if [ -z "$1" ]; then
  version=${ATLAS_VERSION}
fi

curl https://atlas.hashicorp.com/api/v1/box/${ATLAS_BOX}/version/${version}/provider/${ATLAS_PROVIDER} -X DELETE -d access_token=${ATLAS_TOKEN}