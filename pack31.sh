#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

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

distdir=dist
distdir=$(readlink -m "${distdir}")

echo -e "${Y}pack${Z}"

pushd oewn-grind_wndb2sql >/dev/null
echo -e "${M}wndb2sql${Z}"
./pack.sh wn "${TAG31}" "${BUILD}"
target1="sql31/wn-${TAG31}-mysql-${BUILD}.zip"
target2="sql31/wn-${TAG31}-sqlite-${BUILD}.zip"
for t in "${target1}" "${target2}"; do
  t2=$(readlink -m "${t}")
  ln -sf "${t2}" "${distdir}/"
done
echo -e "${G}${target1}${Z}"
echo -e "${G}${target2}${Z}"
popd >/dev/null
