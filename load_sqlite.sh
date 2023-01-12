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

# F I L E S

sqlite=oewn-${TAG}-sqlite-${BUILD}.sqlite
sqlitezip=${sqlite}.zip

# M A I N

echo -e "${Y}load ${TAG}${Z}"

pushd oewn-grind_yaml2sql/sql >/dev/null
echo -e "${M}yaml2sql/sql${Z}"

rm -fR temp-sqlite/*
unzip oewn-${TAG}-sqlite-${BUILD}.zip -d temp-sqlite

  pushd temp-sqlite >/dev/null
  sed -i -r 's/sqlite3 (.*)$/sqlite3 -bail \1 2>>LOG || echo -e "${R}FAILED ${sqlfile}${Z}"/g' restore-sqlite.sh 
  chmod +x restore-sqlite.sh

  ./restore-sqlite.sh -d ${sqlite}

  zip ${sqlitezip} ${sqlite}

  mv "${sqlite}" ../
  mv "${sqlitezip}" ../

  popd >/dev/null

  T=${G}
  [ -e "${sqlite}" ] || T=${R}
  echo -e "${T}${sqlite}${Z}"
  
  T=${G}
  [ -e "${sqlitezip}" ] || T=${R}
  echo -e "${T}${sqlitezip}${Z}"

popd >/dev/null
