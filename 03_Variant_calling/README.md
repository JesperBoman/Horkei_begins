This directory contains script for: 

1) Variant calling using GATK. First haplotype caller is used, then GenomicsDB and lastly genotypeGVCFs. This pipeline will produce a so-called all-sites vcf file, which is ideal when you want to calculate average pairwise differences (π) using [Pixy](https://pixy.readthedocs.io/en/latest/) . However, beware that GATK updated their genotype format recently and then reverted (https://gatk.broadinstitute.org/hc/en-us/articles/6012243429531-GenotypeGVCFs-and-the-death-of-the-dot-obsolete-as-of-GATK-4-6-0-0). Thus use with caution in terms of GATK and Pixy version.
3) Filtering vcf-files.
4) Calculating allele frequencies and obtaining fixed differences between A. agestis and A. artaxerxes.
