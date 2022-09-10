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

distdir=dist
distdir=$(readlink -m "${distdir}")

echo -e "${Y}pack${Z}"

pushd oewn-grind_yaml2wndb >/dev/null
echo -e "${M}yaml2wndb${Z}"
./pack.sh "${TAG}" "${BUILD}"
popd >/dev/null
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}.dict.tar.gz${Z}"
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}.zip${Z}"
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}_compat.dict.tar.gz${Z}"
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}_compat.zip${Z}"
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}_bare.dict.tar.gz${Z}"
echo -e "${G}oewn-grind_yaml2wndb/dist/oewn_${TAG}_bare.zip${Z}"

pushd oewn-grind_yaml2sql >/dev/null
echo -e "${M}yaml2sql${Z}"
./pack.sh "${TAG}" "${BUILD}"
target1="sql/oewn-${TAG}-mysql-${BUILD}.zip"
target2="sql/oewn-${TAG}-sqlite-${BUILD}.zip"
for t in "${target1}" "${target2}"; do
  t2=$(readlink -m "${t}")
  ln -sf "${t2}" "${distdir}/"
done
popd >/dev/null
echo -e "${G}${target1}${Z}"
echo -e "${G}${target2}${Z}"
