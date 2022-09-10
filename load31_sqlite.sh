#!/bin/bash

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

rm -fR temp-sqlite/*
unzip oewn-${TAG31}-sqlite-${BUILD}.zip -d temp-sqlite
  pushd temp-sqlite >/dev/null
  chmod +x restore-sqlite.sh
  echo -e "${Y}sqlite ${TAG31}${Z}"
  ./restore-sqlite.sh -d oewn31
  popd >/dev/null

popd >/dev/null
