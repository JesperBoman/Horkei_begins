awk '(NR>=7)' <(zcat  data.filt.0.call.gz) |cut -f 1,2 >snps.0.txt
paste snps.0.txt maleInfMap.LODL7.sizeL100.txt |awk '($3>0)' > snps.0.maleInfMap.LODL7.txt
paste snps.0.txt maleInfMap.LODL7.sizeL100.txt |awk '{print $0}' > snps.0.maleInfMap.LODL7.UNFILT.txt



awk 'NR==FNR && FNR >1{a[$1]=$3} NR!=FNR && FNR >1{if(a[$1] == $3 )print FNR } ' chrom_to_LG.txt snps.0.maleInfMap.LODL7.UNFILT.txt > markers.to.keep

awk 'NR==FNR {a[$1]} NR!=FNR && FNR == 1{print $0} NR!=FNR && FNR != 1 {if(FNR in a)print $0 }' markers.to.keep  maleInfMap.LODL7.sizeL100.txt>  maleInfMap.LODL7.mod.txt

awk 'NR==FNR {a[$1+6]} NR!=FNR && FNR < 8{print $0} NR!=FNR && FNR > 7 {if(FNR in a)print $0 }' markers.to.keep <(zcat data.filt.0.call.gz) | gzip > data.filt.0.call.mod.gz

awk '(NR>=7)' <(zcat  data.filt.0.call.mod.gz) |cut -f 1,2 >snps.0.mod.txt

paste snps.0.mod.txt maleInfMap.LODL7.mod.txt|awk '($3>0)' > snps.0.maleInfMap.LODL7.mod.txt
