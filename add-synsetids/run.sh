#!/bin/bash

set -e

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

source "../define_build.sh"

# generate nids
pushd ../oewn-tool > /dev/null
#./nids_all.sh YAM
#./nids_all.sh PLUSYAM
popd > /dev/null

DIST=../dist/data
for x in "" "-plus"; do

        DIRSQL="${DIST}"
        DB="oewn${x}-${TAG}-sqlite-${BUILD}.sqlite"
        DBX="oewn${x}-${TAG}-sqlite-${BUILD}-synsetids.sqlite"
        ZIP_DBX="${DBX}.zip"
        cp -L --remove-destination ${DIRSQL}/${DB} ${DIRSQL}/${DBX}
         
        NIDS="${DIST}/out${x}_nids/yaml/synsets.json"
        python3 add_synsetids.py ${DIRSQL}/${DBX} ${NIDS}
        
        pushd "${DIRSQL}" >/dev/null
        [ ! -e "${ZIP_DBX}" ] || rm "${ZIP_DBX}"
        zip "${ZIP_DBX}" "${DBX}"
        popd > /dev/null

        echo -e "${G}${DBX}${Z}"
        echo -e "${G}${ZIP_DBX}${Z}"
        
done
