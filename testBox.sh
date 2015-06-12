#!/bin/bash

set -o errexit    # abort script at first error

vagrant box add vagrant-centos-7-1503-01-minimal.box --name testboxcentos
mkdir testbox
cd testbox
vagrant init testboxcentos
vagrant up
vagrant destroy -f
vagrant box remove -f testboxcentos
cd ..
rm -rf testbox