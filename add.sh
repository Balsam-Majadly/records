#!/bin/bash
source log.sh

function search() {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name" | cut -d ',' -f 1 )
	echo $search_result
}
function searchAmount() {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name")
	echo $search_result
}
function amountToDelete() {
	local nameAmount=$1
	local newAmount=$2
	local fileName=$3
	local name=$( echo $nameAmount | cut -d ',' -f 1 )
	local record_amount="$name,$newAmount"
	sed -i "s/$nameAmount/$record_amount/" $file_name
}
function amountToAdd() {
	local nameAmount=$1
	local newAmount=$2
	local fileName=$3
	local name=$( echo $nameAmount | cut -d ',' -f 1 )
	local record_amount="$name,$newAmount"
	sed -i "s/$nameAmount/$record_amount/" $file_name	
		
}
function validate_amount(){	local result=1
	local amount=$1
	
	if [[ ! $amount =~ ^[0-9]+$ ]] || [[ $amount -lt 1 ]]
	then
		result=0
	fi
	
	echo $result
}
function add(){	
    local name_func=${FUNCNAME[0]}
    local res=""
	read -p "Enter record name : " name
	local file_name=$1
    local result="$(searchAmount $file_name $name)"
	local word_count=$(echo $result | wc -w)	
    if [[ $word_count -eq 0 ]]
	then
		echo "record doesn't exsit"
		echo "would you like to add a new record?"
		select yn in "yes" "no"; do
		case $yn in
			yes)
				read -p "select amount to add : " amount
				check="$(validate_amount $amount)"
				if [[ $check -eq 0 ]]
				then
					res="Failure"
                        log $name_func $res
					echo "Error, invalid amount"
                    break
				else
					echo "$name,$amount" >> $file_name
					echo "the record $name have been added to the list"
					res="Success"
                        log $name_func $res
					break
				fi
			;;
			*)
				break
			;;
		esac
		done	elif [[ $word_count -eq 1 ]]
	then	
		#echo $result
		local aamount=$(grep -F "$name" "$file_name"| cut -d ',' -f 2 )
		local new_amount=0
		read -p "select amount to add : " amount
		check="$(validate_amount $amount)"
		if [[ $check -eq 0 ]]
		then
			res="Failure"
                log $name_func $res
			echo "Error, invalid amount"
		else
		let new_amount=aamount+amount
		amountToAdd $result $new_amount $file_name
		res="Success"
            log $name_func $res
		fi
		
	else
		echo "Select which one you want to Add to : "
		select Name in $result
		do
			case $Name in
			$Name)
				read -p "select amount to add : " amount
				check="$(validate_amount $amount)"
				if [[ $check -eq 0 ]]
				then
					res="Failure"
                        log $name_func $res
					echo "Error, invalid amount"
				else
					local aamount=$(grep -F "$Name" "$file_name"| cut -d ',' -f 2 )
					let new_amount=aamount+amount
					amountToDelete $Name $new_amount $file_name
					res="Success"
                        log $name_func $res
					break
				fi
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
    log $name_func $res
    }