#!/bin/bash

source define_colors.sh

modules=$(find . -maxdepth 1 -type d -name 'oewn*' -printf '%P\n')

for m in ${modules}; do 
	echo -e "${Y}${m}${Z}"
	pushd "${m}" > /dev/null
	git $*
	echo
	popd > /dev/null
done
