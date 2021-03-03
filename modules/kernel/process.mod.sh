#!/bin/bash

IMPORTED="."

import console

##
## (Usage) returns a list of running processes on the host
##  you can specify -l=10 to return only 10 lines 
##
function process.list() {

    for i in "$@"; do
        case $i in
        -l=* | --limit=*) local limit="${i#*=}" ;;
        *) ;;
        esac
    done

    local list

    if [[ ${limit} ]]; then
        n=${limit}
        t=$(expr ${n} - 1)
        list=$(ps aecux | head -${n} | tail -${t})
        unset limit
    else
        list=$(ps aecux)
    fi

    while IFS= read line; do
        console.log "$line"
    done <<<"${list}"
}
