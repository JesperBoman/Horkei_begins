library(ggplot2)
library(plyr)


setwd("~/Downloads")

snps.lg<-read.table("snps.0.maleInfMap.LODL7.mod.txt")

head(snps.lg)
colnames(snps.lg)<-c("Chromosome", "Position", "LG")
snps.lg$Position2 <- gsub("\\*", "", snps.lg$Position)
snps.lg$Position2 <- as.numeric(snps.lg$Position2)

snps.lg$Type <- ifelse(grepl("\\*", snps.lg$Position), "Asterisk", "Normal")


snps.lg$Chr_num <- as.numeric(gsub("Chr_", "", snps.lg$Chromosome))
snps.lg$Chr_num <- ifelse(snps.lg$Chromosome == "Chr_Z", 23, snps.lg$Chr_num)

ggplot(snps.lg, aes(x=Position2, y=LG, col=as.factor(LG) ))+
  geom_point(alpha=0.2)+
  theme_classic()+
  theme(legend.position="right")+
  facet_grid(~Chr_num, scales = 'free_x', space = 'free_x', switch='x')




#To figure out the LG to chromosome mapping
df.lg.snp<-as.data.frame(table(snps.lg$Chromosome, snps.lg$LG))
colnames(df.lg.snp) <- c("Chromosome", "LG", "Frequency")

aggregate(Frequency~Chromosome, df.lg.snp, max)

chrom_to_LG<-ddply(df.lg.snp, c("Chromosome"), function(x) c(max(x$Frequency), x[x$Frequency == max(x$Frequency),]$LG ))

colnames(chrom_to_LG) <- c("Chromosome", "Num_markers", "LG")

write.table(chrom_to_LG, file="chrom_to_LG.txt", quote=F, sep="\t", row.names=F)
