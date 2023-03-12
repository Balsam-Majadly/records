#!/bin/bash

function Print_Amount () {
local file_name=$1
local name_func=${FUNCNAME[0]}
local sum=$(awk -F ',' '{count+=$2} END{print count}' $file_name)
local result="Success"
echo $sum
log $name_func $sum
}
