#!/bin/bash
source log.sh
source validation_file.sh
#source menu.sh




function search () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name" | cut -d ',' -f 1 )
	echo $search_result
}

function menu_search () {
	local file_name=$1
	local name_func=${FUNCNAME[0]}
	read -p "Enter record name or part of it: " nameOfRecord
	local search_result=$(grep -i "^$nameOfRecord" "$file_name" | cut -d ',' -f 1 )

	if [[ -z "$search_result" ]]
		then
			echo "no records found!"
			res="Failure"
			log $name_func $res
		else 
			local sorted_search=$(echo "$search_result" | sort)
			echo "=============="
			echo "Records found!"
			echo "$sorted_search"
			echo "=============="
			res="Success"
			log $name_func $res
	fi
	#menu
}

