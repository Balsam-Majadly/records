#!/bin/bash
#source menu.sh
source validation_file.sh
source search.sh

file_name=0




function main () {
#menu
search $1 "jack"
}

validation_file $*
main $*
