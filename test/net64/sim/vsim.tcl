set cmd "vsim -quiet $TB \
  +nowarnTRAN \
  +nowarnTSCALE \
  +nowarnTFMPC \
  -t ps \
  -voptargs=\"+acc -suppress 2103\" \
  $VSIM_FLAGS"

eval $cmd