#! /bin/bash
source delete.sh

function search () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name" | cut -d ',' -f 1 )
	echo $search_result
}



function rename () {
	local name_func=${FUNCNAME[0]}
	local res=""
	read -p "Enter record name you need to change : " old_name
	read -p "Enter the new name of the record : " new_name
	file_name="$1"
	
	local search_result="$(searchAmount $file_name $old_name)"

	local word_count=$(echo $search_result | wc -w)
	
	if [[ $word_count -eq 0 ]]
	then
		res="Failure"
        log $name_func $res
		echo "Record Not Found"
	elif [[ $word_count -eq 1 ]]
	then
	local amount=$( echo $search_result | cut -d ',' -f 2 )
	local new="$new_name,$amount"
		sed -i "s/$search_result/$new/g" $file_name
		echo "$search_result Changed To $new"
		res="Success"
        log $name_func $res
	else
		echo "Select which one you want to cahnge : "
		select name in $search_result
		do
			case $name in
			$name)
				local amount=$( echo $name | cut -d ',' -f 2 )
				local new="$new_name,$amount"
				sed -i "s/$name/$new/g" $file_name
				echo "$name Changed To $new"
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
