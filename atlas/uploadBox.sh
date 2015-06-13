#!/bin/bash

set -o errexit    # abort script at first error

# Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Reading config
source $CUR_DIR/atlas.cfg

function jsonval {
    temp=`echo $1 | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $2`
    echo ${temp##*|}
}

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

box_file=$1
version=$2

if [ -z "$1" ]; then
  echo "Script need a Box as Parameter!"
  exit 1
fi

if [ -z "$2" ]; then
  version=${ATLAS_VERSION}
fi

if [ ! -f $box_file ]; then
  echo "Box '$1' not found!"
  exit 1
fi

RESPONSE=$(curl -s https://atlas.hashicorp.com/api/v1/box/${ATLAS_BOX}/version/${version}/provider/${ATLAS_PROVIDER}/upload?access_token=${ATLAS_TOKEN})

checkErr ${RESPONSE}

echo ${RESPONSE}

TOKEN=$(jsonval ${RESPONSE}, "token")

curl -X PUT --upload-file ${box_file} https://binstore.hashicorp.com/${TOKEN}