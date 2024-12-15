#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

./grind_all.sh $*
./pack_all.sh
./load_all.sh
