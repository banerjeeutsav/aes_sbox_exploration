# Design Space Exploration of AES S-Box

This repository presents Python-based programs to generate various AES S-Box designs with the GF(2^8) field operations implemented in GF((2^4)^2) and GF(((2^2)^2)^2) composite field representations. Automation scripts are also provided to simulate and verify the designs using Icarus Verilog and synthesize the designs using Yosys, both widely used open-source EDA tools.

### Usage

This repository has been tested on Ubuntu 22.04.1 LTS and the pre-requisites can be installed as ```sudo apt install python2 iverilog yosys```.

The ```aes_sbox_modules.v``` file contains all the sub-module definitions required for various S-Box implementations. The ```aes_sbox_lut.v``` file contains the LUT-based S-Box implementation used as golden reference specification for verifying the composite field S-Box implementations.

The ```AES_SBox_GF_2_4_PolyBases/``` directory contains all the fiels necessary to generate, simulate, verify and synthesize S-Box designs implemented using various GF((2^4)^2) composite field representations. To programmatically generate the S-Box designs, run ```python2 gen_AES_SBox_GF_2_4_PolyBases.py```. The output file ```AES_SBox_GF_2_4_PolyBases.v``` containing all 192 S-Box designs is also provided for reference. To verify all the designs, run ```source run_sim.sh```. It simulates each S-Box with all 256 possible inputs and compares the outputs with the LUT-based S-Box specification using the test-bench template ```AES_SBox_GF_2_4_PolyBases_tb.v.TEMPLATE```. The message ```PASS: Verification Suite Passed``` is displayed after all 192 simulations are completed.

The ```gen_AES_SBox_GF_2_4_PolyBases.py``` program is written based on the theory presented in [Gueron et al, "Masked Inversion in GF (2^N) using Mixed Field Representations and its Efficient Implementation for AES," 2004](https://pluto.huji.ac.il/~orzu/publications/ijcr_book_2004_01_03.pdf).

The ```AES_SBox_GF_2_2_2_PolyNormMixBases/``` directory contains all the fiels necessary to generate, simulate, verify and synthesize S-Box designs implemented using various GF(((2^2)^2)^2) composite field representations. To programmatically generate the S-Box designs, run ```python2 gen_AES_SBox_GF_2_2_2_PolyNormMixBases.py```. The output file ```AES_SBox_GF_2_2_2_PolyNormMixBases.v``` containing all 432 S-Box designs is also provided for reference. To verify all the designs, run ```source run_sim.sh```. It simulates each S-Box with all 256 possible inputs and compares the outputs with the LUT-based S-Box specification using the test-bench template ```AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v.TEMPLATE```. The message ```PASS: Verification Suite Passed``` is displayed after all 432 simulations are completed.

The ```gen_AES_SBox_GF_2_2_2_PolyNormMixBases.py``` program is written based on the theory presented in [Canright, "A Very Compact Rijndael S-Box," 2004](https://core.ac.uk/download/pdf/36694529.pdf).
