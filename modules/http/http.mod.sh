#!/bin/bash

IMPORTED="."

import console

#
# (Usage) Allows you to perform a Get Request to an http server
#         Your can pass headers as such: --header='key:value'
function http.get() {
    http.__proccesor "$1" "--verb=GET" "$@"
}

##
## (Usage)
##      Alows you to perform post operation on an http server
function http.post() {
    http.__proccesor "$1" "--verb=POST" "$@"
}

function http.__proccesor() {

    local __headers=()
    local __dataUrls=()
    local __verb=""
    local __url=$1
    local __rawData

    ##todo: before we move ahead we check the status code

    local result=$(
        curl -s -k -w '%{http_code}' ${__url} >/dev/null 2>&1
        echo $?
    )

    console.trace "curl -s -k -w '%{http_code}' ${__url} "
    
    [[ "${result}" -gt 0 ]] && {
        console.fatal "Failed to Ping the following URL ${__url}"
        exceptionBase.throw
        exit
    }

    for i in "$@"; do
        case $i in
        -k=* | --insecure=*)
            local insecure=true
            ;;
        -h=* | --header=*)
            __headers+=("${i#*=}")
            ;;
        -v=* | --verb=*)
            __verb=${i#*=}
            ;;
        -d=* | --data-urlencode=*)
            __dataUrls+=(${i#*=})
            ;;
        -r=* | --data-raw=*)
            __rawData="${i#*=}"
            ;;
        *) ;;

        esac

    done

    local response headers dataEncodedUrls rawData

    if ! [[ -z ${__rawData} ]]; then
        rawData="--data-raw '${__rawData}'"
    fi

    for i in "${__headers[@]}"; do
        console.log "${i}"
        headers+=" --header '${i}'"
    done

    for i in ${__dataUrls[@]}; do
        dataEncodedUrls+=" --data-urlencode '${i}'"
    done

    str_command="curl --insecure -s --location --request ${__verb} '${__url}' ${headers} ${dataEncodedUrls} ${rawData}"

    console.debug "${str_command}"

    response=$(eval "${str_command} 2>&1")
    ## redirect the stderr to stout
    ## in case we get an error
    ## add it to the exception message;

    echo "${response}"
}
