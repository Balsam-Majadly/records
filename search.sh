#!/bin/bash
#source log.sh
source validation_file.sh
#source menu.sh

#function check_for_record (){
	
#}



function search () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep $name_record $file_name | cut -d ',' -f 1 )
	echo $search_result
}





















