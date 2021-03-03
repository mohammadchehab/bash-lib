#!/bin/bash

IMPORTED="."

import console

##  (Usage)
##      List all available modules on the terminal
##
function engine.modules() {
    modules=$(ls ${BASH__PATH}/modules | sed "s/.mod.*//g")
    for m in $modules; do
         console.log "${BWhite}$m" && \
         [[  -z $( type "${m}.help" 2> /dev/null) ]] && console.warn "No Help Provided for the module ${m}" || eval "${m}.help";
    done
}
