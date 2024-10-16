library(ggplot2)

setwd("~/Downloads")

#Eigenvec file starts with hash, so remove that manually before loading in here
pca.dat <- read.table("ArxRef.preBQSR.auto.LD.50kb.1.0.5.eigenvec", header = T)

pca.eigenvals <- read.table("ArxRef.preBQSR.auto.LD.50kb.1.0.5.eigenval", header = F)


pve <- data.frame(PC = 1:10, pve = pca.eigenvals/sum(pca.eigenvals)*100)

sample.info <- read.table(file = file.choose(), header = T)

sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info <- sample.info[order(sample.info$Short.ID),]


pca.dat.ext <- cbind(pca.dat, sample.info)

pca.dat.ext[pca.dat.ext$Short.ID == 192,]$Admixture_taxa <- "Blekingehorkei"



eigenval.percent <-round(pca.eigenvals$V1/sum(  pca.eigenvals$V1)*100, 1)

ggplot(pca.dat.ext, aes(x=PC1, y=PC2, col=Admixture_taxa))+geom_point()+
  #geom_text(position=position_dodge2(width=0.1))+
  scale_colour_manual(values = c("orange","brown4", "purple", "darkgreen"), labels=c("Agestis", "Artaxerxes", "Blekingehorkei", "Horkei"), name="Ancestry"  ) +
  theme_bw()+
  geom_text(aes(label=Short.ID), position=position_dodge2(width=0.1))+
  xlab(paste0("PC1 (",eigenval.percent[1], " %)" ))+
  ylab(paste0("PC2 (",eigenval.percent[2], " %)" ))+
  theme(aspect.ratio=1, legend.position = "none", panel.border = element_rect(colour = "black", fill=NA, size=1), plot.title = element_text(face = "bold", hjust = 0.5), axis.text=element_text(size=14, colour="black"), axis.title=element_text(size=16), legend.text=element_text(size=14),  legend.title=element_text(size=16))
