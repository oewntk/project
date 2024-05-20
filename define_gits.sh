#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

export modules=$(find . -maxdepth 1 -type d -name 'oewn-*' -printf '%P\n')
echo $modules