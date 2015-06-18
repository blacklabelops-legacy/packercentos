#!/bin/bash

if [ -d testbox ]
then
    echo "Deleting vagrant project."
    # Destroy possible running instance
    cd testbox
    vagrant destroy -f
    cd ..
    # Delete directory
    rm -rf testbox
fi

# Remove possible existent box
vagrant box remove -f testboxcentos
