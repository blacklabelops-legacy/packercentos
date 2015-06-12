# BlackLabelOps/PackerCentOS

Packer project for building a CentOS Vagrant Virtualbox.

Builds the blacklabelops/centos image on Atlas. This is a Vagrant box, never use it for production!

Features:

* Tested On: Packer 0.7.5, Vagrant 1.7.2, Virtualbox 4.3.28
* Includes: CentOS 7.1 minimal
* Available as public vagrant box on Atlas: blacklabelops/centos

This project contains code under Apache License 2.0 from the repository:

* [chef/bento](https://github.com/chef/bento)

# Build

Requires

* Packer v0.7.5 or later
* Vagrant 1.7.2 or later

## Build the Box

~~~~
$ packer build centos7.1-packer.json
~~~~    

## Test

### Testing the Box

Adds and spins up the box with Vagrant.

~~~~
$ ./testBox.sh
~~~~

### Cleaning failed Tests

Convenience script when the test fails. The script deletes all test artifacts.

~~~~
$ ./cleanTest.sh
~~~~

## References

* [Vagrant Homepage](https://www.vagrantup.com/)
* [Packer Homepage](https://www.packer.io/)
* [Virtualbox Homepage](https://www.virtualbox.org/)
* [Atlas Homepage](https://atlas.hashicorp.com/)
