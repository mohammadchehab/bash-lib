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