#!/bin/bash

function log () {
    local name_func=$1
    local res=$2
    echo "$(date +'%d/%m/%Y %H:%M:%S'):  $name_func $res" >> file.log
}

function print_amount_log () {
    echo "$(date +'%d/%m/%Y %H:%M:%S'): $name_func $res" >> file.log
}

function Print_All_Records () {
    local file_name=$1
    #args -L 1 echo "$(date +'%Y-%m-%d %H:%M:%S'): PRINTALL  "  < $file_name >> file.log
    while read p; do
  	#echo "$p"
  	local line=$p
  	local name=$( echo $line | cut -d ',' -f 1 )
  	local amount=$( echo $line | cut -d ',' -f 2 )
  	echo "$(date +'%Y-%m-%d %H:%M:%S'): PRINTALL $name  $amount "  >> file.log
  	#echo $line
	done <$file_name
    }
