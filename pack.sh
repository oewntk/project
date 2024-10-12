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

# D I S T

distdir=dist
distdir=$(readlink -m "${distdir}")

# L I B


function check_file() {
    local t=$(readlink -m "$1")
    if [ -e "${t}" ]; then
        echo -e "${B}${t}${Z}"
        pushd "${distdir}" >/dev/null
        ln -sf "${t}"
        popd  >/dev/null
    else
        echo -e "${R}${t}${Z}"
        return 1
    fi
}

# M A I N

echo -e "${Y}pack${Z}"

pushd oewn-grind_yaml2wndb >/dev/null
echo -e "${M}yaml2wndb${Z}"
./pack.sh "${TAG}" "${BUILD}"
check_file "dist/oewn_${TAG}.dict.tar.gz"
check_file "dist/oewn_${TAG}.zip"
check_file "dist/oewn_${TAG}_compat.dict.tar.gz"
check_file "dist/oewn_${TAG}_compat.zip"
check_file "dist/oewn_${TAG}_bare.dict.tar.gz"
check_file "dist/oewn_${TAG}_bare.zip"
popd >/dev/null

pushd oewn-grind_yaml2sql >/dev/null
case "${TAG}" in
31) DBDIR=sql31 ;;
*)  DBDIR=sql   ;;
esac
echo -e "${M}yaml2sql${Z}"
./pack.sh "${DBDIR}" "${BUILD}"
target1="sql/oewn-${TAG}-mysql-${BUILD}.zip"
target2="sql/oewn-${TAG}-sqlite-${BUILD}.zip"
echo -e "${G}${target1}${Z}"
echo -e "${G}${target2}${Z}"
check_file "${target1}"
check_file "${target2}"
popd >/dev/null

pushd oewn-grind_yaml2json >/dev/null
echo -e "${M}yaml2json${Z}"
./pack.sh "${TAG}"
echo -e "${G}dist/oewn-${TAG}-json.zip"
check_file "dist/oewn-${TAG}.json.zip"
popd >/dev/null

