#!/bin/bash
#source menu.sh
source validation_file.sh
source search.sh

file_name=0




function main () {
#menu
menu_search $1 
}

validation_file $*
main $*
