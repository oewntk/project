#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

pushd oewn-tool >/dev/null
./run_grind.sh "$@"
./run_grind_plus.sh "$@"
popd >/dev/null

