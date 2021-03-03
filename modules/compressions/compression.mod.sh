#!/bin/bash

[[ $BASH__DEBUG && $(basename "$ENTRY__POINT") == "$(basename $0)" ]] && source ./core/init.sh

IMPORTED="."

import console
import string
import directory
import exceptionBase

##
## (Usage)
##  Un compresses a file
##
compression.uncompress() {

    local file="$1"
    local destination="$2"

    if [[ ! $(string.isEmpty "$file") == false ]]; then
        console.warn "src is required"
        return 1
    fi

    if [[ ! $(string.isEmpty "${destination}") == false ]]; then
        console.warn "destination is required"
        return 1
    fi

    if [[ -d ${destination} ]]; then
        console.warn "[$destination] directory is already available, removing directory"
        directory.destory $destination
    fi

    command="unzip ${file} -d ${destination}"

    console.debug "${command}"

    ## redirect the stderr to stout
    ## in case we get an error
    ## add it to the exception message;
    result=$(${command} 2>&1)

    if [[ $? == 0 ]]; then
        console.log "Successfully extracted ${file} to ${destination}"
        return 1
    fi

    exceptionBase.throw $result
}

##
## (Usage)
##  Compresses a file
##
compression.compress() {
    zip "$1" "$2"
}
