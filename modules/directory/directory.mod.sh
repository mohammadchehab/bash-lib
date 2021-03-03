#!/bin/bash

IMPORTED=".";

##
## (Usage)
##  Removes a directory forcefuly
##
function directory.destory(){
    rm -rf "$1";
}