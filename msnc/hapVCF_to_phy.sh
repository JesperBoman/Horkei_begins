#!/bin/bash -l

mkdir work fasta phy

ref="../Reference/ilAriArta2.1_SH.fasta"

vcfdir="../Phasing/shapeit"

c=0

while IFS= read -r locus
do

Chr=$(cut -f1 <(echo $locus) -d ' ')
start=$(cut -f2 <(echo $locus) -d ' ')
end=$(cut -f3 <(echo $locus) -d ' ')

	while IFS= read -r sample
	do
	
	if [ $c -gt 9 ]
        then
        wait
        c=0
        fi

	(( c++ ))
		for hap in {1,2}
		do

		vcf=$Chr.phased.vcf.gz

		bash hapVCF_to_fa.sh $vcf $hap $ref $vcfdir $sample $Chr $start $end &

		done

	done < "samples.list"

wait
cat work/*.${Chr}_${start}-${end}.Hap*.fa > fasta/${Chr}_${start}-${end}.fa

seq_num=$(grep ">" fasta/${Chr}_${start}-${end}.fa -c)
length=500

awk -v seq_num="$seq_num" -v len="$length" 'BEGIN{print seq_num " " len } {if($1 ~ />/){split($1, a, ">")} else{seqs[a[2]]= seqs[a[2]] $0}} END{for (seq in seqs){print "^" seq "\t" seqs[seq]}}' fasta/${Chr}_${start}-${end}.fa > phy/${Chr}_${start}-${end}.phy

cd work
rm *
cd ..

done < "1000_random_autosomal_loci.bed"



cat phy/* > 1000_random_autosomal_loci.phy

#To handle overlapping deletions that are marked with an asterisk (*), we need to change them, I made them into N here
#Another alternative is to really dig in and understand the extent of the deletions, since now we assume that surrounding sequence is not deleted.
#Interesting that they are considered SNPs
#https://gatk.broadinstitute.org/hc/en-us/articles/360035531912-Spanning-or-overlapping-deletions-allele
sed 's/\*/N/g' 1000_random_autosomal_loci.phy > 1000_random_autosomal_loci_mod.phy
