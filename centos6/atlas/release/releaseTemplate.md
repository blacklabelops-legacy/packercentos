# BlackLabelOps/CentOS/!ATLAS_VERSION!

## Vagrant Box from CentOS 7.x

This is a Vagrant Box, never use it in Production!

## Installed

* Centos 7.1 Base Box release!
* Minimal CentOS with Firewall enabled

## Init

### Latest Version

~~~~
$ vagrant init blacklabelops/centosfirewall
$ vagrant up
~~~~

### Fix Version

~~~~
$ vagrant init blacklabelops/centosfirewall https://atlas.hashicorp.com/blacklabelops/boxes/centosfirewall/versions/!ATLAS_VERSION!
$ vagrant up
~~~~

## Build

## Latest Version

Github [BlackLabelOps/PackerCentOS](https://github.com/blacklabelops/packercentos/centos7firewall)

## This Version

Github [BlackLabelOps/PackerCentOS](https://github.com/blacklabelops/packercentos/tree/!ATLAS_VERSION!)
