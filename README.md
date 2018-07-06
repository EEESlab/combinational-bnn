# Combinational Binarized Neural Network (BNN)

This repository contains the System-Verilog source files describing a HW fully-combinational BNN model. 

### Folders Content
- `src\` includes the HDL description of basic BNN building blocks (spatial convolutional and fully-connected layers)
- `test\` contains multiple example of network models
 - `src\` includes network-specific HDL descriptions. Among them, `weights.sv` contains the networks parameters.
 - `tb\` inlcudes the testbench files for running simulation. 
 - `sim\` used for simulation purpose with ModelSim (tested with version 10.6b)

### Try the code
Simply navigate to the `sim\` folder of the desidered netowork example and type
```
make clean build run
```
for sythesis and simulation. Stimulus is defined in `tb/data.sv`.


### Results
Sythensis results with GF22 SOI technology are reported in the [paper](https://arxiv.org/abs/1712.01743).
Please, acknowledge it if you make use of our code.

```
Rusci, Manuele, Lukas Cavigelli, and Luca Benini. 
"Design Automation for Binarized  Neural Networks: A Quantum Leap Opportunity?." 
Circuits and Systems (ISCAS), 2018 IEEE International Symposium on. IEEE, 2018.

```





