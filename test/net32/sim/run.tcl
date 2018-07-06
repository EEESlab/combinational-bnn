#!/bin/bash 
# \
exec vsim -do "$0"

set TB            tb
set VSIM_FLAGS    ""

source ./vsim.tcl
