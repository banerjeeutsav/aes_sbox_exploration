#!/bin/bash

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

touch AES_SBox_GF_2_2_2_PolyNormMixBases_synth_summary.csv
echo "Design,Area(um2)" > AES_SBox_GF_2_2_2_PolyNormMixBases_synth_summary.csv

for i in {1..432}
do
    cp synth.ys.TEMPLATE synth.ys
    sed -i -e 's/AES_SBox_GF_2_2_2_PolyNormMixBasis_i/AES_SBox_GF_2_2_2_PolyNormMixBasis_'$i'/' synth.ys
    yosys synth.ys > synth.log
    echo "Synth ${i} ... DONE"
    area=$(grep "Chip area for top module" synth.log | grep -Po '[0-9]+\.[0-9]+')
    echo "${i},${area}" >> AES_SBox_GF_2_2_2_PolyNormMixBases_synth_summary.csv
    rm synth.log
    rm synth.ys
    rm synth.sp
    rm synth.v
done
