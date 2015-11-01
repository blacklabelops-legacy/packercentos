#!/bin/bash

set -o errexit    # abort script at first error

#Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

vagrant box add vagrant-centos-6-minimal.box --name testboxcentos
mkdir testbox
cd testbox
vagrant init testboxcentos
vagrant up
vagrant ssh -c 'echo Hello Testbox!'
cd ..

# Reading config
source $CUR_DIR/cleanTest.sh
