#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

export R='\u001b[31m'
export G='\u001b[32m'
export B='\u001b[34m'
export Y='\u001b[33m'
export M='\u001b[35m'
export C='\u001b[36m'
export Z='\u001b[0m'

for m in grind_yaml2wndb grind_wndb2sql grind_wndb2wndb grind_xml2wndb grind_yaml2ser grind_yaml2sql; do
  echo -e "${M}${m}${Z}"
  pushd oewn-${m} > /dev/null
  ./dependency_graph.sh
  popd > /dev/null
done
