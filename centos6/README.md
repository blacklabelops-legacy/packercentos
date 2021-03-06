# BlackLabelOps/PackerCentOS

[![Circle CI](https://circleci.com/gh/blacklabelops/packercentos.svg?style=svg)](https://circleci.com/gh/blacklabelops/packercentos)

Packer project for building a CentOS Vagrant Virtualbox.

You always wanted to spin up VM's from latest available ISO images automatically? You want full control of what's installed on your VM? You like CentOS? Then this is the perfect place for you!

Builds the [blacklabelops/centos6](https://atlas.hashicorp.com/blacklabelops/boxes/centos6) Image on Atlas. This is a Vagrant box, never use it for production!

Features:

* Tested On: Packer, Vagrant, Virtualbox
* Includes: CentOS 6 minimal, latest kernel, firewall enabled!
* Available as public Vagrant box on Atlas: [blacklabelops/centos6](https://atlas.hashicorp.com/blacklabelops/boxes/centos6)
* Atlas Virtualbox provider is build daily.
* Circle-CI: CI verification of the packer file.

This project is very grateful for code under Apache License 2.0 from the repository:

* [chef/bento](https://github.com/chef/bento)

## Project

This repository is the start of my personal continuous deployment and release pipeline for virtual machine images. It gives me full control of image creation, its base configuration and installed packages. The build can changed by simply pushing configuration changes to its github repository.

In order to get experience with the build process I am doing daily builds and snapshot uploads on Atlas. The daily build reveals problems early and I can optimize the build process timely.

My target is a straight build and deployment pipeline from ISOs to Docker images. Stay tuned for more!

## Build

Requires

* Packer
* Vagrant

Build the Box

~~~~
$ packer build centos6-packer.json
~~~~

## Test

### Testing the Box

Adds and spins up the box with Vagrant.

~~~~
$ ./test/testBox.sh
~~~~

### Cleaning failed Tests

Convenience script when the test fails. The script deletes all test artifacts.

~~~~
$ ./test/cleanTest.sh
~~~~

## Atlas

This project includes scripts for uploading and managing the box on [Atlas](https://atlas.hashicorp.com/). The scripts are described in this [Tutorial](/tutorials/versioningWithAtlas.md).

## Notes

### Installing Updates

The build does not include the command 'yum update' because the package versions would not be stable. We only update the kernel in order to keep Virtualbox Guest Additions working.

### Reboot for Latest CentOS Kernel

Packer file contains a kernel update and reboot sequence for CentOS. The latest CentOS ISO does not always contain the latest kernel and after updating the kernel the vm needs a reboot.

Otherwise after running 'yum update' the Virtualbox Guest Additions will stop working and vagrant will timeout when mounting external directories.

Always include the following scripts in sequence in order to make 'yum update' work:

1. scripts/updateKernel.sh
2. scripts/reboot.sh

## References

* [Vagrant Homepage](https://www.vagrantup.com/)
* [Packer Homepage](https://www.packer.io/)
* [Virtualbox Homepage](https://www.virtualbox.org/)
* [Atlas Homepage](https://atlas.hashicorp.com/)

~~~~
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
~~~~
