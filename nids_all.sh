#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -e

pushd oewn-tool >/dev/null
./run_nids.sh "$@"
popd >/dev/null

