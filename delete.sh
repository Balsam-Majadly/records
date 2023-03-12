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

function delete(){

    local name_func=${FUNCNAME[0]}
	local res=""
	read -p "Enter record name : " name
	local file_name="$1"
	local result="$(searchAmount $file_name $name)"
	local word_count=$(echo $result | wc -w)

	if [[ $word_count -eq 0 ]] 
	then
		res="Failure"
        log $name_func $res
		echo "Record Not Found"

	elif [[ $word_count -eq 1 ]]
	then	
		echo $result
		local aamount=$(grep -F "$name" "$file_name"| cut -d ',' -f 2 )
		local new_amount=0
		read -p "select amount to delete : " amount
		let new_amount=aamount-amount
		
		if [[ $new_amount -lt 0 ]]
		then
			echo "error"
			res="Failure"
            log $name_func $res
		elif [[ $new_amount -eq 0 ]]
		then
			sed -i "/$name/d" $file_name
			res="Success"
            log $name_func $res
		else
			amountToDelete $result $new_amount $file_name
			res="Success"
            log $name_func $res
		fi
		
	else
		echo "Select which one you want to Delete : "
		select Name in $result 
		do
			case $Name in
			$Name)
				read -p "select amount to delete : " amount
				local aamount=$(grep -F "$Name" "$file_name"| cut -d ',' -f 2 )
				let new_amount=aamount-amount
				
				
				if [[ $new_amount -lt 0 ]]
				then
					res="Failure"
					echo "error"
                    log $name_func $res
					break

				elif [[ $new_amount -eq 0 ]]
				then
					sed -i "/$Name/d" $file_name
					res="Success"
                    log $name_func $res
					break
				else	
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

}