#!/bin/bash

# Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Reading config
source $CUR_DIR/atlas.cfg

#Checks for an Atlas API Error
function checkErr {
	if  [[ $1 == '{"errors":'* ]] ;
	then
		echo $response
    	err
	fi
}

# Helper functions
err() {
  printf '%b\n' ""
  printf '%b\n' "\033[1;31m[ATLAS ERROR] $@\033[0m"
  printf '%b\n' ""
  exit 1
} >&2

#------------------
# SCRIPT ENTRYPOINT
#------------------

version=$1

if [ -z "$1" ]; then
  version=${ATLAS_VERSION}
fi

response=$(curl -s https://atlas.hashicorp.com/api/v1/box/${ATLAS_BOX}/version/${version}/providers -X POST -d provider[name]=${ATLAS_PROVIDER} -d access_token=${ATLAS_TOKEN})

checkErr $response

echo $response