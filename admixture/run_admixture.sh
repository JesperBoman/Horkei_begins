#!/bin/bash -l


prefix="ArxRef.preBQSR.auto.LD.50kb.1.0.5"


#Copy .bim-file that is outputted by plink and correct chromosome names
sed 's/Chr_//g' $prefix.bim > tmp
mv tmp $prefix.bim


#Use filtered .bed-file from plink
infile="$prefix.bed"

threads=4

br=100

K=1

for K in {1..10}
do
 sbatch -J $prefix.admix.$K -t 2-00:00:00 -p core -n$threads -o slurm/$prefix.admixture.$K.out -e slurm/$prefix.admixture.$K.out -A "Project ID" admixture.sh $infile $threads $K $br
done


#Check for lowest cross-validation error
for K in {1..10}; do  grep "CV error"  slurm/*admixture.$K.out; done 
