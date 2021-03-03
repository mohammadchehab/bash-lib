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
