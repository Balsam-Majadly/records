#!/bin/bash
source menu.sh
source validation_file.sh




function main () {
menu "$1"
}

validation_file $*
main $*
