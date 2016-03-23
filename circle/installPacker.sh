#!/bin/bash

set -o errexit    # abort script at first error

if [ ! -e ${HOME}/bin/packer ]
then
  wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip
  unzip -od ${HOME}/bin /tmp/packer.zip
fi

packer version
