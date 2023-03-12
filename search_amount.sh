#! /bin/bash


function search () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name" | cut -d ',' -f 1 )
	echo $search_result
}

function searchAmount () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name")
	echo $search_result
}

function validate_amount(){

	local result=1
	local amount=$1
	
	if [[ ! $amount =~ ^[0-9]+$ ]] || [[ $amount -lt 1 ]]
	then
		result=0
	fi
	
	echo $result
}

function amount() {
	local name_func=${FUNCNAME[0]}
	local res=""
	read -p "Enter record name to change amount : " record_name
	read -p "Enter the new amount of the record : " amount
	local file_name="$1"
	
	local name_amount="$(searchAmount $file_name $record_name)"
	local search_result="$(search $file_name $record_name)"
	local record_amount="$search_result,$amount"
	local word_count=$(echo $search_result | wc -w)
	local check="$(validate_amount $amount)"
	
	if [[ $word_count -eq 0 ]] 
	then
		res="Failure"
		log $name_func $res
		echo "Record Not Found"
		
	elif [[ $check -eq 0 ]]
	then
		res="Failure"
		log $name_func $res
		echo "Amount must be a number greater than 1 "
		
	elif [[ $word_count -eq 1 ]]
	then
		sed -i "s/$name_amount/$record_amount/" $file_name
		echo "Amount Updated"
		res="Success"
		log $name_func $res
	
	else
		echo "Select which one you want to cahnge : "
		select name in $search_result #one oneB
		do
			case $name in
			$name)
				sed -i "s/^$name,[[:digit:]]\+/$name,$amount/" $file_name
				echo "Amount Updated"
				res="Success"
				log $name_func $res
				sleep 2
				break
			;;
			*)
				echo "Not Found"
				res="Failure"
				log $name_func $res
				break
			esac
		done
	fi
	
	echo $res
		
}