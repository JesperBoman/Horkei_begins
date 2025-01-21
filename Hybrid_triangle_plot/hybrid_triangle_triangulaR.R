# install.packages("devtools")
devtools::install_github("omys-omics/triangulaR")

library(triangulaR)
library(vcfR)

#Reading in a vcf-file with high-quality SNPs 
#that have at least 0.8 allele frequency difference between A. artaxerxes and A. agestis 
#to be used as ancestry-informative-markers

data <- read.vcfR("more_than_0.8.auto.HQSNPs.recode.vcf", verbose = F)

sample.info <- read.table(file = file.choose(), header = T)

sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info <- sample.info[order(sample.info$Short.ID),]

sample.info$Admixture_taxa <- ifelse(sample.info$Short.ID == 192, "Blekingehorkei", sample.info$Admixture_taxa)

popmap<-sample.info[,c("Short.ID", "Admixture_taxa")]
colnames(popmap)<-c("id", "pop")

vcfR.diff <- alleleFreqDiff(vcfR = data, pm = popmap, p1 = "Agestis", p2 = "Artax", difference = 0.8)

# Calculate hybrid index and heterozygosity for each sample. Values are returned in a data.frame
hi.het <- hybridIndex(vcfR = vcfR.diff, pm = popmap, p1 = "Agestis", p2 = "Artax")

triangle.plot(hi.het)+
  annotate(geom="point", x=0.5,y=1, col="black", size=5)+
  annotate(geom="text", x=0.7,y=1, col="black", size=5, label="F1 hybrid")+
  scale_colour_manual(values = c("orange", "brown4",  "red", "darkgreen"), labels=c(expression(italic("A. agestis")), expression(italic("A. artaxerxes")), "Blekingehorkei", expression(italic("horkei")) ), name="Ancestry"  ) +
  theme(aspect.ratio=1, title= element_text(size=16), legend.position = "right",  plot.title = element_text(face = "bold", hjust = 0.5), axis.text=element_text(size=15, colour="black"), axis.title=element_text(size=18), legend.text=element_text(size=16),  legend.title=element_text(size=18))

missing.plot(hi.het)

max(hi.het[hi.het$pop == "Horkei",]$hybrid.index)
min(hi.het[hi.het$pop == "Horkei",]$hybrid.index)
hi.het[hi.het$pop == "Blekingehorkei",]$hybrid.index


max(hi.het[hi.het$pop == "Horkei",]$heterozygosity)
min(hi.het[hi.het$pop == "Horkei",]$heterozygosity)
hi.het[hi.het$pop == "Blekingehorkei",]$heterozygosity
