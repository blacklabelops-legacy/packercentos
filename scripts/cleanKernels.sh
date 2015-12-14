#!/bin/bash

#This script cleans up when multiple kernels are installed.

rpm -q kernel

yum -y install yum-utils

package-cleanup --oldkernels --count=1 -y

yum -y remove yum-utils
