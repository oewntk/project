#!/bin/bash

#
# Copyright (c) 2024. Bernard Bou.
#

export R='\u001b[31m'
export G='\u001b[32m'
export B='\u001b[34m'
export Y='\u001b[33m'
export M='\u001b[35m'
export C='\u001b[36m'
export Z='\u001b[0m'

# directives
wn31=true
fromxml=
reapply=

# log
logdir=..

# main
echo -e "${Y}schema${Z}"
pushd oewn-tosql >/dev/null
echo -e "${M}schema (tosql)${Z}"
./generate-schema.sh
./generate-sources.sh sql/data
echo -e "${M}schema (yaml2sql)${Z}"
./generate-schema.sh ../oewn-grind_yaml2sql/sql
./generate-sources.sh ../oewn-grind_yaml2sql/sql/data
echo -e "${M}schema (wndb2sql)${Z}"
./generate-schema.sh ../oewn-grind_wndb2sql/sql
./generate-sources.sh ../oewn-grind_wndb2sql/sql/data
./generate-schema.sh ../oewn-grind_wndb2sql/sql31
./generate-sources.sh ../oewn-grind_wndb2sql/sql31/data
popd >/dev/null

echo -e "${Y}grind${Z}"
date > ${logdir}/errors_wndb.log
date > ${logdir}/errors_sql.log
date > ${logdir}/errors_json.log
date > ${logdir}/errors_ser.log


pushd oewn-grind_yaml2wndb >/dev/null
echo -e "${M}yaml2wndb${Z}"
./grind.sh yaml yaml2 wndb 2>> ${logdir}/errors_wndb.log
echo -e "${M}yaml2wndb (offsets)${Z}"
./grind_offsets.sh yaml wndb_offsets/wndb 2>> ${logdir}/errors_wndb.log
echo -e "${M}yaml2wndb (compat)${Z}"
./grind_compat.sh yaml yaml2 wndb_compat 2>> ${logdir}/errors_wndb.log
echo -e "${M}yaml2wndb (compat, offsets)${Z}"
./grind_offsets_compat.sh yaml wndb_offsets/wndb_compat 2>> ${logdir}/errors_wndb.log
popd >/dev/null

pushd oewn-grind_yaml2sql >/dev/null
echo -e "${M}yaml2sql${Z}"
./grind.sh yaml yaml2 sql/data 2>> ${logdir}/errors_sql.log
./generate-nidmaps.sh yaml yaml2 nidmaps 2>> ${logdir}/errors_sql.log
./generate-sers.sh yaml yaml2 sers 2>> ${logdir}/errors_ser.log
popd >/dev/null

pushd oewn-grind_yaml2ser >/dev/null
echo -e "${M}yaml2ser${Z}"
./grind.sh yaml yaml2 ser oewn.ser oewn.ser.info 2>> ${logdir}/errors_ser.log
popd >/dev/null

pushd oewn-grind_yaml2json >/dev/null
echo -e "${M}yaml2json${Z}"
./grind.sh yaml yaml2 json/oewn.json 2>> ${logdir}/errors_json.log
popd >/dev/null

if [ ! -z "$fromxml" ]; then
	pushd oewn-grind_xml2wndb >/dev/null
	echo -e "${M}xml2wndb${Z}"
	./grind.sh xml/oewn.xml xml2 wndb 2>> ${logdir}/errors_wndb.log
	popd >/dev/null
fi

if [ ! -z "$reapply" ]; then
	pushd oewn-grind_wndb2wndb >/dev/null
	echo -e "${M}wndb2wndb (re)${Z}"
	./grind.sh wndb wndb2 wndb_out 2>> ${logdir}/errors_wndb.log
	echo -e "${M}wndb2wndb (re_re)${Z}"
	./grind.sh wndb_out wndb2 wndb_out_out 2>> ${logdir}/errors_wndb.log
	popd >/dev/null
fi

if [ ! -z "$wn31" ]; then
	pushd oewn-grind_wndb2sql >/dev/null
	echo -e "${M}wndb2sql${Z}"
	./grind.sh wndb wndb2 sql/data 2>> ${logdir}/errors_sql.log
	./grind.sh wndb31 wndb2 sql31/data 2>> ${logdir}/errors_sql.log
	./generate-nidmaps.sh wndb31 wndb2 nidmaps31 2>> ${logdir}/errors_sql.log
	./generate-sers.sh wndb31 wndb2 sers31 2>> ${logdir}/errors_ser.log
	popd >/dev/null

	pushd oewn-grind_wndb2json >/dev/null
	echo -e "${M}wndb2json${Z}"
	./grind.sh wndb wndb2 json/wn31.json 2>> ${logdir}/errors_json.log
	popd >/dev/null
fi
