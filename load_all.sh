#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

source define_build.sh

# S Q L I T E

pushd oewn-tool >/dev/null
./load_sqlite.sh
popd >/dev/null

./load31_sqlite.sh

# M Y S Q L

read -p "Are you sure you want to load ${TAG} to MySql? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
echo -e "${Y}mysql${Z}"
pushd oewn-tool >/dev/null
./load_mysql.sh
popd >/dev/null
fi


read -p "Are you sure you want to load ${TAG31} to MySql? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
echo -e "${Y}mysql${Z}"
./load31_mysql.sh
fi

