#!/bin/bash -l

#### Autosomes ####

grep -v "Chr_Z" step3.txt > data.auto.txt
awk '{arxF=$3/($3+$4); ageF=$5/($5+$6); diff=arxF-ageF; absDiff=(diff > 0) ? diff : -diff; if(absDiff>0.8){print $0}}' data.auto.txt | sort -k2,2n > data.auto.0.8.txt

$dir/ancestry_hmm -i ../data.auto.0.8.txt -s ../samples.list.Horkei.auto.ploidy -a 2 0.67 0.33 

#Nota bene: I could not run the program with any more priors other than ancestry proportions. 
#Then it outputs likelihood which is "-nan".
#Other users have similar issues with ancestry_hmmm. 
#However, it works well enough for our purposes in the current manuscript since we only want the local ancestry inference.


#### Z chromosome ####

#I forgot to set seed here. Ask me for data.Z.0.8.5k.txt if you want to replicate.

#I had to subset variants on the Z chromosome otherwise ancestry_hmm did not finish the run. It seems like it is much slower when using samples of different ploidy.
shuf -n 5000 ../data.Z.0.8.txt | sort -k2,2n > ../data.Z.0.8.5k.txt
$dir/ancestry_hmm -i ../data.Z.0.8.5k.txt -s ../samples.list.Horkei.Z.ploidy -a 2 0.67 0.33 
