#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

source define_build.sh

# O E W N

pushd oewn-tool >/dev/null
./load_mysql.sh
popd >/dev/null

# W N 3 1

read -p "Are you sure you want to load ${TAG31} to MySql? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${Y}mysql31${Z}"
    ./load31_mysql.sh
fi
