#!/bin/bash

IMPORTED="."

import console

function exceptionBase.throw() {
    kill -10 $$
}
