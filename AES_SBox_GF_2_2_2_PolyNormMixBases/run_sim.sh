#!/bin/bash

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

err_count=0

for i in {1..432}
do
    cp AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v.TEMPLATE AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v
    sed -i -e 's/AES_SBox_GF_2_2_2_PolyNormMixBasis_i/AES_SBox_GF_2_2_2_PolyNormMixBasis_'$i'/' AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v
    iverilog -o aes_sbox ../aes_sbox_lut.v ../aes_sbox_modules.v AES_SBox_GF_2_2_2_PolyNormMixBases.v AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v
    vvp aes_sbox > sim.log
    if grep -q "PASS" sim.log; then
        echo "Test ${i} ... PASS"
    fi
    if grep -q "FAIL" sim.log; then
        echo "Test ${i} ... FAIL"
        err_count=$((err_count+1))
    fi
    rm sim.log
    rm aes_sbox
    rm AES_SBox_GF_2_2_2_PolyNormMixBases_tb.v
done

if [[ "$err_count" -eq "0" ]]; then
    echo "PASS: Verification Suite Passed"
else
    echo "FAIL: Verification Suite Failed"
fi
