#!/bin/bash

IMPORTED="."

import console

function date.now(){
    local log_date=$(date)
    console.trace $log_date
    echo $log_date
}

