#!/bin/bash
source log.sh

function print_All () {
    local file_name=$1
	local name_func=${FUNCNAME[0]}
    local sorted_file=$(sort -t ',' -k1 $file_name)
    echo "List of all entries sorted by name: "
    echo "$sorted_file" | awk -F ',' '{ printf "%s, %s\n", $1, $2 }'
    res="Success"    
    Print_All_Records $1
}