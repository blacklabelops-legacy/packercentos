#!/bin/bash

set -o errexit    # abort script at first error

# Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Reading config
source $CUR_DIR/atlas.cfg

#Checks for an Atlas API Error
function checkErr {
	if  [[ $1 == '{"errors":'* ]] ;
	then
		echo $1
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

description_file=$1
version=$2

if [ -z "$1" ]; then
	echo 'Description file parameter missing!'
  exit 1
fi

if [ ! -f $description_file ]; then
  echo "Markdown file '$description_file' not found!"
  exit 1
fi

if [ -z "$2" ]; then
  version=${ATLAS_VERSION}
fi

description=$(cat $1)

description=${description//!ATLAS_VERSION!/$version}

response=$(curl https://atlas.hashicorp.com/api/v1/box/${ATLAS_BOX}/version/${version} \
        -X PUT \
				--data-urlencode "version[description]=${description}" \
        -d access_token=${ATLAS_TOKEN})

checkErr $response

echo $response
