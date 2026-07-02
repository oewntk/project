#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

set -Eeo pipefail
on_err() {
  local exit_code=$?
  local line_no=${BASH_LINENO[0]}
  echo "Error on line $line_no (exit code: $exit_code)."
}
trap on_err ERR

from=$1
[ "$#" -eq 0 ] || shift
if [ -z "${from}" ]; then
  from=initial
fi

case "$from" in
        initial)
                ;&
                
        grind) ./grind_all.sh "$@"
                ;&
                
        nids)  ./nids_all.sh
                ;&

        pack) ./pack_all.sh "$@"
                ;&

        load_sqlite) ./load_sqlite.sh "$@"
                ;&

        load_mysql) ./load_mysql.sh "$@"
                ;&

        end) 
                ;;
esac

