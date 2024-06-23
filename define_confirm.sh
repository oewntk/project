#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

# C O L O R S

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

function confirm() {
    echo -e "Using the ${C}${1}${Z} branch."
    read -p "Are you sure you want to use the ${1} branch ? " -n 1 -r
    echo -e "${Z}"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    fi
    return 1
}

