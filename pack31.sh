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

# D I S T

distdir=dist
distdir=$(readlink -m "${distdir}")

# M A I N

echo -e "${Y}pack${Z}"

pushd oewn-grind_wndb2sql >/dev/null
echo -e "${M}wndb2sql${Z}"
./pack.sh wn "${TAG31}" "${BUILD}"
target1="sql31/wn-${TAG31}-mysql-${BUILD}.zip"
target2="sql31/wn-${TAG31}-sqlite-${BUILD}.zip"
echo -e "${G}${target1}${Z}"
echo -e "${G}${target2}${Z}"
check_file "${target1}"
check_file "${target2}"
popd >/dev/null

pushd oewn-grind_wndb2json >/dev/null
echo -e "${M}wndb2json${Z}"
./pack.sh "${TAG31}"
echo -e "${G}dist/wn${TAG31}.json.zip${Z}"
check_file "dist/wn${TAG31}.json.zip"
popd >/dev/null

