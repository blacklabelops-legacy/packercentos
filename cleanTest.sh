#!/bin/bash

# Destroy possible running instance
cd testbox
vagrant destroy -f
cd ..

# Remove possible existent box
vagrant box remove -f testboxcentos

# Delete directory
rm -rf testbox