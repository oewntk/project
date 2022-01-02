#!/bin/bash

source define_colors.sh

modules=$(find . -maxdepth 1 -type d -name 'oewn-*' -printf '%P\n')

for d in ${modules}; do 
	m=${d#oewn-}
	echo -e "${Y}${m}${Z}"
	pushd "${d}" > /dev/null
	l="git $*"
	eval $l
	popd > /dev/null
done
