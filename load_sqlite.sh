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

echo -e "${Y}load ${TAG}${Z}"

pushd oewn-grind_yaml2sql/sql >/dev/null
echo -e "${M}yaml2sql/sql${Z}"

rm -fR temp-sqlite/*
unzip oewn-${TAG}-sqlite-${BUILD}.zip -d temp-sqlite
  
pushd temp-sqlite >/dev/null
  chmod +x restore-sqlite.sh
  echo -e "${Y}sqlite ${TAG}${Z}"
  ./restore-sqlite.sh -d oewn-${TAG}-${BUILD}
  zip ../oewn-${TAG}-sqlitedb-${BUILD}.zip oewn-${TAG}-${BUILD}.sqlite
popd >/dev/null

popd >/dev/null
