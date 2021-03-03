#!/bin/bash

IMPORTED=".";

#
# (Usage)
#   Checks if a paticular string is empty returns true; false otherwise    
#
function string.isEmpty() {
    [[ -z $1 ]] && echo true || echo false;
}

#
# (Usage)
#   Replaces a character with another character if matched in the input string
#
function string.replace (){
    local replace=$1;
    local with=$2;
    local str=$3;

    echo ${str//$1/$2};
}