#!/bin/bash


function validation_file() {
	local result=0
    local file_name=$1

		if [[ $# -ne 1 ]] 
			then 
				result="Error number of arguments no valid"

		elif ! [[ -e $file_name ]]
			then
				result="File doesnt exists"

		elif ! [[ -s $file_name ]]
			then
				result="File is empty" 

		fi
	echo $result
}


