#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

source define_build.sh

# C O L O R S

export R='\u001b[31m'
export G='\u001b[32m'
export B='\u001b[34m'
export Y='\u001b[33m'
export M='\u001b[35m'
export C='\u001b[36m'
export Z='\u001b[0m'

# M A I N

echo -e "${Y}load ${TAG31}${Z}"

pushd oewn-grind_wndb2sql/sql31 >/dev/null
echo -e "${M}wndb2sql/sql31${Z}"

rm -fR temp-mysql/*
unzip wn-${TAG31}-mysql-${BUILD}.zip -d temp-mysql

pushd temp-mysql >/dev/null
  chmod +x restore-mysql.sh
  echo -e "${Y}mysql ${TAG31}${Z}"
  ./restore-mysql.sh -d wn31
popd >/dev/null

popd >/dev/null
