#!/bin/bash -l



#Load modules
module load bioinfo-tools GATK/4.3.0.0 bcftools/1.17

#Concatenate scaffold-separate allsites vcfs
bcftools concat --threads 2 -o Arx.preBQSR.allsites.vcf.gz Chr*.dir/Arx*.allsites.vcf.gz

#Index concatenated vcf
gatk --java-options "-Xmx6g" IndexFeatureFile \
  -I Arx.preBQSR.allsites.vcf.gz 

#Extract SNPs only

ref="../Reference/ilAriArta2.1_SH.fasta"


gatk --java-options "-Xmx6g" SelectVariants \
  -R $ref \
  -V Arx.preBQSR.allsites.vcf.gz \
  --select-type-to-include SNP \
  --create-output-variant-index \
  -O Arx.preBQSR.SNPs.vcf.gz



#Extract quality metrics
bcftools query  Arx.preBQSR.SNPs.vcf.gz -f'%FS\t%SOR\t%MQRankSum\t%ReadPosRankSum\t%QD\t%MQ\t%DP\n' > Arx.preBQSR_FS.SOR.MQRS.RPRS.QD.MQ.DP.txt



awk '{for (i=1; i<=NF; i++){if($i == ".")next} print $0}'  Arx.preBQSR_FS.SOR.MQRS.RPRS.QD.MQ.DP.txt > Arx.preBQSR_FS.SOR.MQRS.RPRS.QD.MQ.DP.filt.txt


#Applying filtering
#3x SD for coverage is 3533.594

bcftools filter -i 'FS<60.0 && SOR<3 && MQ>40 && MQRankSum>-12.5 && QD>2 && ReadPosRankSum>-8 && INFO/DP<3533.594' -O z -o Arx.preBQSR.HQSNPs.vcf.gz Arx.preBQSR.SNPs.vcf.gz



#Indexing HQSNPs vcf-file

gatk --java-options "-Xmx6g" IndexFeatureFile \
  -I Arx.preBQSR.HQSNPs.vcf.gz
