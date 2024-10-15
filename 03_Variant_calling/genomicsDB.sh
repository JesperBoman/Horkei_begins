#!/bin/bash -l

module load bioinfo-tools GATK/4.3.0.0


id=$1
scaffold=$2



while IFS= read -r sample
do

fp="$sample.$id.$scaffold.dedup.g.vcf"

echo -e "$sample\t$scaffold.dir/$fp" >> sample_map.$scaffold

done < "samples.list"



date
echo "GenomicsDB $id.$scaffold, begun"

#PI
#sample="ERR9123829" #Only when updating Genomics DB

#gatk --java-options "-Xmx28g" GenomicsDBImport \
#  -V $scaffold.dir/$sample.$id.$scaffold.dedup.g.vcf \
#  --genomicsdb-update-workspace-path genomicsdb_preBQSR.$id.$scaffold \
#  --tmp-dir $SNIC_TMP # \


#Sample map
gatk --java-options "-Xmx28g" GenomicsDBImport \
  --sample-name-map  sample_map.$scaffold \
  --genomicsdb-workspace-path genomicsdb_preBQSR.$id.$scaffold \  
  -L $scaffold
  
rm sample_map.$scaffold
  
date
echo "GenomicsDB $id.$scaffold, DONE"
