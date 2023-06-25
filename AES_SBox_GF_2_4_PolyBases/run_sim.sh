#!/bin/bash

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

err_count=0

for i in {1..3}
do
    for j in {1..8}
    do
        for k in {1..8}
        do
            cp AES_SBox_GF_2_4_PolyBases_tb.v.TEMPLATE AES_SBox_GF_2_4_PolyBases_tb.v
            sed -i -e 's/AES_SBox_GF_2_4_PolyBasis_i_j_k/AES_SBox_GF_2_4_PolyBasis_'$i'_'$j'_'$k'/' AES_SBox_GF_2_4_PolyBases_tb.v
            iverilog -o aes_sbox ../aes_sbox_lut.v ../aes_sbox_modules.v AES_SBox_GF_2_4_PolyBases.v AES_SBox_GF_2_4_PolyBases_tb.v
            vvp aes_sbox > sim.log
            if grep -q "PASS" sim.log; then
                echo "Test ${i}-${j}-${k} ... PASS"
            fi
            if grep -q "FAIL" sim.log; then
                echo "Test ${i}-${j}-${k} ... FAIL"
                err_count=$((err_count+1))
            fi
            rm sim.log
            rm aes_sbox
            rm AES_SBox_GF_2_4_PolyBases_tb.v
        done
    done
done

if [[ "$err_count" -eq "0" ]]; then
    echo "PASS: Verification Suite Passed"
else
    echo "FAIL: Verification Suite Failed"
fi
