#!/bin/bash -l

#Add hybrid population read counts according to column number below:
#8. Read counts of allele A in sample 1
#9. Read counts of allele a in sample 1
#10. Read counts of allele A in sample 2
#11. Read counts of allele a in sample 2

while IFS= read -r sample
do

let i++
let j=i+1

awk 'FNR==NR && FNR>1 && $3==2 {split($5, REF, ":"); split($6, ALT, ":"); sREF[$1,$2]=REF[2]; sALT[$1,$2]=ALT[2]} FNR!=NR{print $0 "\t" sREF[$1,$2] "\t" sALT[$1,$2] }' Individual_allele_counts/$sample.frq.count tmp.$i.txt > tmp.$j.txt

done < "samples.list.Horkei"

mv tmp.$j.txt step3.txt
