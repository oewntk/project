#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

source define_build.sh

# O E W N

pushd oewn-tool >/dev/null
./load_all.sh
popd >/dev/null

# W N 3 1

read -p "Are you sure you want to load ${TAG31} to Sqlite? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
echo -e "${Y}sqlite31${Z}"
./load31_sqlite.sh
fi

read -p "Are you sure you want to load ${TAG31} to MySql? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
echo -e "${Y}mysql31${Z}"
./load31_mysql.sh
fi
