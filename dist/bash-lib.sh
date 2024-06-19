#!/bin/bash
# Generated on Wed 19 Jun 2024 15:41:18 +04
# Author: Mohammad Chehab
# This is a generated file. Do not modify.

# Begin core/init.sh

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



# End core/init.sh


# Begin ./core/logo.mod.sh

#!/bin/bash

## bash asci banner openner

IMPORTED="."

import console;

echo -e """

██████╗  █████╗ ███████╗██╗  ██╗    ██╗     ██╗██████╗ ██████╗  █████╗ ██████╗ ██╗   ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██║     ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
██████╔╝███████║███████╗███████║    ██║     ██║██████╔╝██████╔╝███████║██████╔╝ ╚████╔╝ 
██╔══██╗██╔══██║╚════██║██╔══██║    ██║     ██║██╔══██╗██╔══██╗██╔══██║██╔══██╗  ╚██╔╝  
██████╔╝██║  ██║███████║██║  ██║    ███████╗██║██████╔╝██║  ██║██║  ██║██║  ██║   ██║   
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
                                                                                        

""" 1>&3



# End ./core/logo.mod.sh


# Begin ./core/exceptions/exceptionBase.mod.sh

#!/bin/bash

IMPORTED="."

import console

function exceptionBase.throw() {
    kill -10 $$
}

# End ./core/exceptions/exceptionBase.mod.sh


# Begin ./core/engine.mod.sh

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

# End ./core/engine.mod.sh


# Begin ./core/trapper.mod.sh

#!/bin/bash

function trapper.addTrap() {
    local cmd="$1"
    shift
    local sig traps
    for sig in "$@"; do
        traps="$(trapper.getTraps $sig | trapper.filterTraps "$cmd")"
        if [[ -n "$traps" ]]; then
            trap "$traps ; $cmd" $sig
        else
            trap "$cmd" $sig
        fi
    done
}

function trapper.getTraps() {
    echo $(trap | grep "$1" | sed -e "s/$'\n'/ ; /g")
}

function trapper.filterTraps() {
    local cmd="$1"
    shift
    echo $(trap | grep "$cmd" | sed -e "s/$'\n'/ ; /g")
}

# End ./core/trapper.mod.sh


# Begin ./config/build.inc

#!/bin/bash
IMPORTED="."
BASH__RELEASE=0.0.1
# End ./config/build.inc


# Begin ./config/colors.inc

#!/bin/bash
IMPORTED="./"

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# End ./config/colors.inc


# Begin ./modules/date/date.mod.sh

#!/bin/bash

IMPORTED="."

import console

function date.now(){
    local log_date=$(date)
    console.trace $log_date
    echo $log_date
}


# End ./modules/date/date.mod.sh


# Begin ./modules/utils/string.mod.sh

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
# End ./modules/utils/string.mod.sh


# Begin ./modules/directory/directory.mod.sh

#!/bin/bash

IMPORTED=".";

##
## (Usage)
##  Removes a directory forcefuly
##
function directory.destory(){
    rm -rf "$1";
}
# End ./modules/directory/directory.mod.sh


# Begin ./modules/math/mathExceptions.mod.sh

#!/bin/bash

IMPORTED=".";

import exceptionBase;

function math.exception.arithmeticComputation(){
     exceptionBase.throw "Failed to perform an arithmetic computation";
}
# End ./modules/math/mathExceptions.mod.sh


# Begin ./modules/math/math.mod.sh

#!/bin/bash

IMPORTED="."

import mathExceptions;

#
# (Usage)
#   adds to inputs e.g. math.add 1 2
#   Output
#        3
#
function math.add() {
    [[ $(math.__isNumber $1) == true && $(math.__isNumber $2) == true ]] && echo $(($1 + $2)) || math.exception.arithmeticComputation;
}

#
# (Usage)
#   Checks if an input is a digit
#
function math.__isNumber() {
    [[ -n $1 && $1 != *[^[:digit:]]* ]] && echo true || echo false
}

# End ./modules/math/math.mod.sh


# Begin ./modules/http/http.mod.sh

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

# End ./modules/http/http.mod.sh


# Begin ./modules/compressions/compression.mod.sh

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

# End ./modules/compressions/compression.mod.sh


# Begin ./modules/kernel/process.mod.sh

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

# End ./modules/kernel/process.mod.sh


# Begin ./modules/kernel/console.mod.sh

#!/bin/bash
exec 3>&1

IMPORTED="."

import "colors" "inc"

__CONSOLE__TIME__FORMAT="+%d/%m/%Y %H:%M:%S"
__CONSOLE__TEMPLATE="#{color}#{log_date} - #{host_name} - #{script} - [#{log_type}]:#{color_off}"

# Determine the shell type and current script file
if [[ -n "$ZSH_VERSION" ]]; then
  SHELL_NAME="zsh"
  CURRENT_SCRIPT=${(%):-%N}
elif [[ -n "$BASH_VERSION" ]]; then
  SHELL_NAME="bash"
  CURRENT_SCRIPT=$(basename "$0")
else
  SHELL_NAME="unknown"
  CURRENT_SCRIPT="unknown"
fi

function console.help() {
   cat <<EOF
-console.log
(Description):
   Throws a [log] identifier into the terminal
(Usage):
    console.log Hello World!
  
-console.info
(Description):
   Throws a [info] identifier into the terminal
(Usage):
    console.info Hello World!

-console.fatal
(Description):
   Throws a [fatal] identifier into the terminal
(Usage):
    console.fatal Woops an error just popped out!
EOF
}

console.__processLog() {
   local verbose=$(echo ${BASH__VERBOSE:-trace} | tr '[:upper:]' '[:lower:]')
   local requested_log_type=$(echo ${1} | tr '[:upper:]' '[:lower:]')
   local log=false

   case ${requested_log_type} in
   trace | debug | error | info)
      [[ ${verbose} == ${requested_log_type} ]] && log=true || log=false
      if [[ ${verbose} == "trace" ]]; then
         log=true
      fi
      ;;
   log | fatal | warn | error)
      log=true
      ;;
   esac

   if [[ ${log} == false ]]; then
      return
   fi

   local message="$5"
   local source_file=$3
   local line_no=$4
   local log_date=$(date "${__CONSOLE__TIME__FORMAT}")
   local host_name=$(hostname)
   local script=$CURRENT_SCRIPT
   local log_type=$1
   local color=$2
   local color_off=${Color_Off}
   local template="${color}${log_date} - ${host_name} - ${script} - [${log_type}]:${color_off}"

   echo -e "${template} ${message}" 1>&3
}

console.log() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "LOG" "${Color_Off}" "${source_file}" "${line_no}" "${message}"
}

console.fatal() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "FATAL" "${BRed}" "${source_file}" "${line_no}" "${message}"
}

console.error() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "ERROR" "${BRed}" "${source_file}" "${line_no}" "${message}"
}

console.trace() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "TRACE" "${BYellow}" "${source_file}" "${line_no}" "${message}"
}

console.warn() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "WARN" "${BYellow}" "${source_file}" "${line_no}" "${message}"
}

console.debug() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "DEBUG" "${BCyan}" "${source_file}" "${line_no}" "${message}"
}

console.info() {
   local message="$@"
   local line_no=$LINENO
   local source_file

   if [[ "$SHELL_NAME" == "bash" ]]; then
      source_file=$(caller 0 | awk '{print $2}' | xargs basename)
   elif [[ "$SHELL_NAME" == "zsh" ]]; then
      source_file=${(%):-%N}
   else
      source_file="unknown"
   fi

   console.__processLog "INFO" "${Color_Off}" "${source_file}" "${line_no}" "${message}"
}
# End ./modules/kernel/console.mod.sh

