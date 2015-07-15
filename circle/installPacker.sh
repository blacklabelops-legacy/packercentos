#!/bin/bash

set -o errexit    # abort script at first error

if [ ! -e ${HOME}/bin/packer ]
then
  wget -O /tmp/packer.zip https://dl.bintray.com/mitchellh/packer/packer_0.8.1_linux_amd64.zip
  unzip -od ${HOME}/bin /tmp/packer.zip
fi

packer version
