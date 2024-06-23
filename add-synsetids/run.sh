#!/bin/bash

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

DIRSRC="../oewn-grind_yaml2sql/sql"
DB="oewn-2024-sqlite-2.1.1.sqlite"
DBFULL="oewn-2024-sqlite-2.1.1-full.sqlite"

cp ${DIRSRC}/${DB} ${DBFULL}
python3 add_synsetids.py ${DBFULL} synsets.map

echo -e "${G}${DBFULL}${Z}"
