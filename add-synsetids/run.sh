#!/bin/bash

set -e

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

DIRSRC="../oewn-grind_yaml2sql/sql"
DB="oewn-2024-sqlite-2.3.2.sqlite"
DBX="oewn-2024-sqlite-2.3.2-synsetids.sqlite"
ZIP_DBX="${DBX}.zip"

cp ${DIRSRC}/${DB} ${DIRSRC}/${DBX}
python3 add_synsetids.py ${DIRSRC}/${DBX} synsets.map

pushd "${DIRSRC}" >/dev/null
[ ! -e "${ZIP_DBX}" ] || rm "${ZIP_DBX}"
zip "${ZIP_DBX}" "${DBX}"
popd > /dev/null

echo -e "${G}${DBX}${Z}"
echo -e "${G}${ZIP_DBX}${Z}"
