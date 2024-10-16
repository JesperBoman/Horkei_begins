#!/bin/bash -l




conda activate /conda_envs/pixy #pixy 1.2.10.beta2

#vcf="../03_Variant_calling/Arx.preBQSR.allsites.vcf.pixy_filt.gz"
vcf="../03_Variant_calling/Arx.preBQSR.allsites.Z_ploidyHapF.vcf.pixy_filt.Males.gz"

wsize=10000

pixy --stats pi dxy fst \
--vcf $vcf \
--populations sampop.males.list \
--window_size $wsize \
--n_cores 8 \
--fst_type 'hudson' \
--output_prefix Z.Filt


#Window size 10 kb took ca 1.5 hours with 8 core for Aricia (A.filt)
