#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

export modules1=$(find . -maxdepth 1 -type d -name 'oewn-*' -printf '%P\n')
export modules=". ${modules1}"
echo $modules