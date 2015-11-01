#!/bin/bash

if [ -d testbox ]
then
    echo "Deleting vagrant test directory."
    # Destroy possible running instance
    cd testbox
    vagrant destroy -f
    cd ..
    # Delete directory
    rm -rf testbox
fi

# Remove possible existent box
existent_box=$(vagrant box list | grep testbox)
if [ ! -z "$existent_box" ]; then
  echo "Removing test box."
  vagrant box remove -f testboxcentos
fi
