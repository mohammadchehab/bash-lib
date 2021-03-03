#!/bin/bash
exec 3>&1

IMPORTED="."

import "colors" "inc"

__CONSOLE__TIME__FORMAT="+%d/%m/%Y %H:%M:%S"
__CONSOLE__TEMPLATE="#{color}#{log_date} - #{host_name} - #{script} - [#{log_type}]:#{color_off}"

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

##
## Private function which processes the message and throws it out
## to the stdout with some text formatting
##
function console.__processLog() {

   local verbose=$(echo ${BASH__VERBOSE:-trace} | tr '[:upper:]' '[:lower:]')
   # //todo:parameter substitution ${,,}  is not working with makefile on mac
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
   local script=$0
   local log_type=$1
   local color=$2
   local color_off=${Color_Off}
   local template="$(echo ${__CONSOLE__TEMPLATE} | sed -e 's,#,$,g')"

   ## redirect the log to the
   ## strerr as it's affecting the
   ## return value for functions and affects piping
   echo -e $(eval echo "${template}") ${message} 1>&3
}

##
## Allows you to throw generic messages to the stdout
## With a [LOG] label which can be used to do log filter
##
function console.log() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "LOG" "${Color_Off}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [FATAL] label which can be used to do log filter
##
function console.fatal() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "FATAL" "${BRed}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [ERROR] label which can be used to do log filter
##
function console.error() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "ERROR" "${BRed}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [TRACE] label which can be used to do log filter
##
function console.trace() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "TRACE" "${BYellow}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [TRACE] label which can be used to do log filter
##
function console.warn() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "WARN" "${BYellow}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [DEBUG] label which can be used to do log filter
##
function console.debug() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "DEBUG" "${BCyan}" "${line_no}" "${source_file}" "${message}"
}

##
## Allows you to throw generic messages to the stdout
## With a [INFO] label which can be used to do log filter
##
function console.info() {
   local message="$@"
   local line_no=$BASH_LINENO
   local source_file=$(caller | awk '{print $2}' | xargs basename)
   console.__processLog "INFO" "${Color_Off}" "${line_no}" "${source_file}" "${message}"
}
