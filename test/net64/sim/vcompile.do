#!/bin/tcsh
clear
source ./colors.sh

\rm -rf modelsim_libs
vlib modelsim_libs
\rm -rf work
vlib work


echo ""
echo "${Green}  -> Compiling BNN layers...${NC}"
echo ""

vlog -quiet -sv ../../../src/popcnt.sv                                 || exit 1
vlog -quiet -sv ../../../src/bconv_layer.sv                            || exit 1
vlog -quiet -sv ../../../src/bview_layer.sv                            || exit 1
vlog -quiet -sv ../../../src/blin_layer.sv                             || exit 1
vlog -quiet -sv ../../../src/blast_layer.sv                            || exit 1

echo ""
echo "${Green}  -> Compiling BNN network...${NC}"
echo ""

vlog -quiet -sv ../src/bnn.sv                                 	|| exit 1
vlog -quiet -sv ../src/weight.sv                                 || exit 1
vlog -quiet -sv ../src/top.sv                                    || exit 1

echo ""
echo "${Green}  -> Compiling Testbench...${NC}"
echo ""
vlog -quiet -sv ../tb/data.sv                                 || exit 1
vlog -quiet -sv ../tb/tb_top.sv                                 || exit 1


echo ""
echo "${Green}  -> Compiling OK ${NC}"
echo ""
