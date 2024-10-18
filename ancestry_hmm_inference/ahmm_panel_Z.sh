#!/bin/bash -l

#Females: assume ploidy 1 on Z chromosomes. Not entirely correct for Aricia since the neo-Z part is not super differentiated between Z and W.

#Step 1
awk -f ahmm_panel_step1.awk <(grep "Chr_Z" ../03_Variant_calling/ploidyHapF.HQSNPs.KBH_artax.frq.count) <(grep "Chr_Z" ../03_Variant_calling/ploidyHapF.HQSNPs.Agestis.frq.count) > step1.Z.txt
 

#Step 2
ml bioinfo-tools BEDTools/2.31.1

bedtools intersect -a <(awk '{print $1 "\t" $2-1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6}' step1.Z.txt) -b ArxLM.interpol.1.0.bed -wa -wb | awk '{OFS="\t"; print $1, $3, $4, $5, $6, $7, $11}' > step2.Z.txt

cp step2.Z.txt tmp.1.txt


#Step 3
while IFS= read -r sample
do

let i++
let j=i+1

awk 'FNR==NR && FNR>1 && $3==2 {split($5, REF, ":"); split($6, ALT, ":"); sREF[$1,$2]=REF[2]; sALT[$1,$2]=ALT[2]} FNR!=NR{print $0 "\t" sREF[$1,$2] "\t" sALT[$1,$2] }' <(grep "Chr_Z" Individual_allele_counts/$sample.frq.count) tmp.$i.txt > tmp.$j.txt

done < "samples.list.Horkei"

mv tmp.$j.txt step3.Z.txt


#Assume at least 0.8 allele frequency difference between panels (i.e. parental populations artaxerxes and agestis)
awk '{arxF=$3/($3+$4); ageF=$5/($5+$6); diff=arxF-ageF; absDiff=(diff > 0) ? diff : -diff; if(absDiff>0.8){print $0}}' step3.Z.txt | sort -k2,2n > data.Z.0.8.txt

cat data.auto.0.8.txt data.Z.0.8.txt > data.both.0.8.txt
