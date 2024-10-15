#!/bin/bash -l


module load bioinfo-tools GATK/4.3.0.0

id=$1
scaffold=$2
ref=$3


gatk --java-options "-Xmx120g" GenotypeGVCFs \
 -R $ref \
 -V gendb://genomicsdb_preBQSR.$id.$scaffold\
 -all-sites \
 -L $scaffold \
 -O $scaffold.dir/$id.$scaffold.allsites.vcf.gz
