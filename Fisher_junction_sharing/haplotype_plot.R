library(ggplot2)
library(reshape2)
library(viridis)
setwd("~/Downloads")
sample.info <- read.table(file = file.choose(), header = T)
sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info <- sample.info[order(sample.info$Short.ID),]
sample.info$Admixture_taxa[45] <- "Blekingehorkei"

phased_vcf_df<-read.table("Chr_1.phased_9.8-9.9MB.vcf", header=T)

phased_vcf_df_long<-melt(phased_vcf_df[,c(2,10:ncol(phased_vcf_df))], id.vars = c("POS"), variable.name = "Sample")


phased_vcf_df_long$Pos <- rep(1:length(phased_vcf_df$POS), 45)
phased_vcf_df_long$Sample <- gsub("X", "", phased_vcf_df_long$Sample)






phased_vcf_df_long$Taxa<-NA
for(i in 1:length(sample.info$Short.ID )){
  matches <-  sample.info$Short.ID [i] == phased_vcf_df_long$Sample 
  m_list <- (1:length(matches))[matches]
  phased_vcf_df_long$Taxa[m_list] <- sample.info$Admixture_taxa[i]
}

phased_vcf_df_long$Taxa <- factor(phased_vcf_df_long$Taxa, levels=c("Agestis", "Horkei", "Blekingehorkei", "Artax"))

phased_vcf_df_long<-phased_vcf_df_long[order(phased_vcf_df_long$Taxa),]

phased_vcf_df_long$Sample <- factor(phased_vcf_df_long$Sample,levels = unique(phased_vcf_df_long$Sample) )

phased_vcf_df_long$value2 <- ifelse(phased_vcf_df_long$value=="0|1", "Het", phased_vcf_df_long$value)
phased_vcf_df_long$value2 <- ifelse(phased_vcf_df_long$value2=="1|0", "Het", phased_vcf_df_long$value2)

phased_vcf_df_long$value2 <- factor(phased_vcf_df_long$value2, levels=c("0|0", "Het", "1|1"))
#[phased_vcf_df_long$Pos>4800 & phased_vcf_df_long$Pos<5000 ,]
ggplot(phased_vcf_df_long[phased_vcf_df_long$Pos<5000 ,] , aes(x=Pos, y=Sample, fill=value2))+geom_tile()+
  scale_fill_viridis_d(option="viridis")
  #theme_classic()+
  #theme(
  #  panel.background = element_rect(fill = "black", colour = "black",
  #                                  size = 2, linetype = "solid"),




