#!/bin/bash

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

touch AES_SBox_GF_2_4_PolyBases_synth_summary.csv
echo "Design,Area(um2)" > AES_SBox_GF_2_4_PolyBases_synth_summary.csv

for i in {1..3}
do
    for j in {1..8}
    do
        for k in {1..8}
        do
            cp synth.ys.TEMPLATE synth.ys
            sed -i -e 's/AES_SBox_GF_2_4_PolyBasis_i_j_k/AES_SBox_GF_2_4_PolyBasis_'$i'_'$j'_'$k'/' synth.ys
            yosys synth.ys > synth.log
            echo "Synth ${i}_${j}_${k} ... DONE"
            area=$(grep "Chip area for top module" synth.log | grep -Po '[0-9]+\.[0-9]+')
            echo "${i}_${j}_${k},${area}" >> AES_SBox_GF_2_4_PolyBases_synth_summary.csv
            rm synth.log
            rm synth.ys
            rm synth.sp
            rm synth.v
        done
    done
done
