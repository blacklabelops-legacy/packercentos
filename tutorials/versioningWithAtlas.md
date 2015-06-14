# Version and Release Vagrant Boxes With Atlas

Atlas is great for parking boxes on the internet and spreading or deployment them in environments. The Atlas API gives access to all functionality in its REST API and it allows to implement a custom release cycle. Vagrant defines the term boxes and boxes can be anything from Virtualbox to Amazon EC2 images. 

## What I Want

* I build a base box based on CentOS on Virtualbox with Packer in the Github Repository [blacklabelops/packercentos](https://github.com/blacklabelops/packercentos).
* I use this base box in my Docker development environment under [blacklabelops/dockerdev](https://github.com/blacklabelops/dockerdev)
* The base box is under heavy development as I find more and more neat examples online to optimize it. In some cases I want some packages pre installed or change the box preconfigured size.
* I use my development box for working. My development boxes should always initialize with the latest stable base box.
* I want to be able to switch to pre-stable boxes in order to test new features.

### On the other hand:

* I want stable releases. The development box latest stable release, should contain a stable base box. If an error occurs I can simply switch back to a release version or even earlier versions.
* I want nightly builds. Each box must be built daily in order to encounter problems early.
* I want to switch version in order to analyze problems later.

### I distinguish between releases and snapshots:

* _release_ should be stable and must not be touched. I always assume that this version is used somewhere and must be available. 
* _snapshot_ is a build artifact of the next release version. A snapshot should never be published and considered by Vagrant. Snapshots are Beta Versions and should only be available to those of interest.

## Atlas Versions

_Versions_: Boxes can have an arbitrary amount of versions. A version number must be compatible with the [RubyGems Semantic Versioning](http://guides.rubygems.org/patterns/#semantic-versioning).

 Versions can have states:

* Unpublished: A box in an unpublished version release will not be pulled or considered by Vagrant. I use this state for daily builds or CI (Continuous Integration) builds.
* Published: A published version will be considered by Vagrant and the latest published version will be pulled by Vagrant when initializing a box.
* Revoked: A revoked version is dead and cannot be republished or even deleted. I had to learn this the hard way.

## Releasing the Base Box with Atlas

Username is: blacklabelops

Public box is: centos

Current snapshot: 1.0.2.pre

Default provider is: virtualbox

This is configured inside the atlas configuration file: [atlas/atlas.cfg](https://github.com/blacklabelops/packercentos/blob/master/atlas/atlas.cfg)

In order to make this work you need an Atlas API Token. This can be generated on your [tokens page](https://atlas.hashicorp.com/settings/tokens) 

### Pre Configuration

Declare the access token as an environment variable.

~~~~
$ export ATLAS_TOKEN=ENTER_TOKEN_HERE
~~~~ 

### Prepare the Release

Create the new release version on Atlas.

~~~~
$ ./atlas/createVersion.sh 1.0.2
~~~~ 

Create a new Virtualbox provider for the release version.

~~~~
$ ./atlas/createProvider.sh 1.0.2
~~~~ 

Build the release artifact (box) for Virtualbox.

~~~~
$ packer build centos7.1-packer.json
~~~~ 

### Release the Artifact

Upload the release artifact.

~~~~
$ ./atlas/uploadBox.sh vagrant-centos-7-1503-01-minimal.box 1.0.2
~~~~ 

Release the version.

~~~~
$ ./atlas/releaseVersion.sh 1.0.2
~~~~ 

### Check the Release

Let's look if the release is successful.

Create a Vagrant project.

~~~~
$ vagrant init blacklabelops/centos
~~~~ 

Spin up the project. In my case there is already an old version.

~~~~
$ vagrant up
...
==> default: A newer version of the box 'blacklabelops/centos' is available! You currently
==> default: have version '1.0.1pre'. The latest is version '1.0.2'. Run
==> default: `vagrant box update` to update.
...
~~~~ 

In my case there has been an old image, otherwise list the boxes in order to check the version.

~~~~
$ vagrant box list
~~~~ 

### Post Release

Adjusting the configuration for my daily build on master branch. The version file is used because that way I don't have to reconfigure the build job.

Adjust the configuration file [atlas/atlas.cfg](https://github.com/blacklabelops/packercentos/blob/master/atlas/atlas.cfg).

~~~~
#------------------
# ATLAS PARAMETERS
#------------------
...
readonly ATLAS_VERSION="1.0.3.pre"
...
~~~~ 

Define the next snapshot version .

~~~~
$ ./atlas/createVersion.sh
~~~~ 

Create provider.

~~~~
$ ./atlas/createProvider.sh
~~~~ 

### Daily Build Upload

Atlas does not allow to simply overwrite boxes. In order to realize a daily upload you have to delete the provider and create a new one.

Delete and recreate the provider.

~~~~
$ ./atlas/deleteProvider.sh
$ ./atlas/createProvider.sh
~~~~ 

Upload the daily build artifact.

~~~~
$ ./atlas/uploadBox.sh vagrant-centos-7-1503-01-minimal.box
~~~~ 

## Versioned Boxes and Github

* A box release should always be represented by a Github repository release. See: [blacklabelops/packercentos](https://github.com/blacklabelops/packercentos/releases/tag/v1.0.0)
* A snapshot box version represents the build or nightly build of the latest master branch.



