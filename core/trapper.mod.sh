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
