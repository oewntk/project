#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

export R='\u001b[31m'
export G='\u001b[32m'
export B='\u001b[34m'
export Y='\u001b[33m'
export M='\u001b[35m'
export C='\u001b[36m'
export Z='\u001b[0m'

modules=$(find . -maxdepth 1 -type d -name 'oewn-*' -printf '%P\n')

for d in ${modules}; do 
	m=${d#oewn-}
	echo -e "${Y}${m}${Z}"
	pushd "${d}" > /dev/null
	l="git $*"
	eval $l
	popd > /dev/null
done

# ${m} is instantiated as module name
# ${m} must be protected by single quotes on the command line
#./git_all.sh remote set-url origin 'https://oewntk@github.com/oewntk/${m}.git'