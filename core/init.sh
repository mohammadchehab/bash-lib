#!/bin/bash
##
## (Usage) import modulename if your adding and include item
##         you can use import config inc to mark its an inc extension
##  
## Allows you include libraries
function import () {

  local src=${BASH__PATH:-"/opt/ek/-bash"};
  local extension=$([[ -z ${2} ]]  && echo "mod.sh" || echo "inc");

  if [[ ! -d ${src} ]]; then
      echo -e "\e[31mError: \e[0m Bash Path is not set \e[1mexport BASH__PATH=/opt/ek/-bash\e[0m"
      exit 1;
  fi

  local module=$(find ${src} -name "${1}.${extension}" 2>/dev/null)
  if [[  -f ${module} ]]; then
    source ${module}
    if [[ -z ${IMPORTED} ]]; then
      echo -e "\e[31mError:\e[0m Failed to load \e[1m${1}.${extension}\e[0m at ${src}";
      exit 2;
    fi
  else
    echo -e "\e[31mError: \e[0mCannot find \e[1m${1}\e[0m library inside: ${src}";
    exit 3;
  fi
}

# start importing pre-requisits
import logo
import build "inc";
import engine;
import math
import console;
import trapper;

## add a trapper for the exceptions
trapper.addTrap 'exit 1;' 10 

[[ -z ${BASH__VERBOSE} ]] &&  export BASH__VERBOSE=trace || export BASH__VERBOSE=${BASH__VERBOSE};
console.debug "Verbosity:  ${BASH__VERBOSE} ";
console.debug "Version : ${BASH__RELEASE} ";


