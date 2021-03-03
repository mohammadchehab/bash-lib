#!/bin/bash

IMPORTED=".";

import exceptionBase;

function math.exception.arithmeticComputation(){
     exceptionBase.throw "Failed to perform an arithmetic computation";
}