#!/bin/bash


function validation_file() {
	local result=0
    local file_name=$1
	local name_func=${FUNCNAME[0]}
		if [[ $# -ne 1 ]] 
			then 
				result="Error number of arguments no valid"
				exit 5

		elif ! [[ -e $file_name ]]
			then
				result="File doesnt exists"
				exit 6

		elif ! [[ -s $file_name ]]
			then
				result="File is empty" 
				exit 7

		fi
	echo $result
}