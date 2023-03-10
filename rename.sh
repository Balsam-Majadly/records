#! /bin/bash


function search () {
	local file_name=$1
	local name_record=$2
	local search_result=$(grep "$name_record" "$file_name" | cut -d ',' -f 1 )
	echo $search_result
}



function rename () {

	local res=""
	read -p "Enter record name you need to change : " old_name
	read -p "Enter the new name of the record : " new_name
	file_name="test.txt"
	
	local search_result="$(search $file_name $old_name)"
	local word_count=$(echo $search_result | wc -w)
	
	if [[ $word_count -eq 0 ]]
	then
		res="Failure"
		echo "Record Not Found"
	elif [[ $word_count -eq 1 ]]
	then
		sed -i "s/$old_name/$new_name/g" $file_name
		echo "$old_name Changed To $new_name"
		res="Success"
	
	else
		echo "Select which one you want to cahnge : "
		select name in $search_result
		do
			case $name in
			$name)
				sed -i "s/$name/$new_name/g" $file_name
				echo "$name Changed To $new_name"
				echo "Success"
				res="Success"
				sleep 2
				break
			;;
			*)
				echo "Not Found"
				res="Failure"
				break
			esac
		done
	fi
	
	echo $res
		
}

#search $*
rename

