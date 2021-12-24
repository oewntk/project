#!/bin/bash

modules=$(find . -maxdepth 1 -type d -name 'oewn*' -printf '%P\n')

for m in ${modules}; do 
	echo "${m}"
	pushd "${m}" > /dev/null
	git status
	echo
	popd > /dev/null
done
