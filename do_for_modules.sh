#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

for m in $(./define_modules.sh); do
  echo -e "${Y}${m}${Z}"
  pushd $m > /dev/null
  if ! eval "$1"; then
    echo -e "${R}failed${Z}"
    fi
  popd > /dev/null
done