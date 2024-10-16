library(ggplot2)
library(corrplot)
library(RColorBrewer)

#Plot relatednes matrix

sample.info <- read.table(file = file.choose(), header = T)

sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info <- sample.info[order(sample.info$Short.ID),]


setwd("~/Downloads")
rel.matrix <- scan(file="ArxRef.preBQSR.auto.LD.50kb.1.0.5.rel")


inbred_df <- read.table(file = "ArxRef.preBQSR.auto.LD.50kb.1.0.5.het", header=T)






m <-matrix(rel.matrix, nrow=45, ncol=45)


rownames(m) <- paste(sample.info$Locality, sample.info$Short.ID, round(inbred_df$F, 2), sep=".")
colnames(m) <- paste(sample.info$Locality, sample.info$Short.ID, round(inbred_df$F, 2), sep=".")



corrplot(m,  method="color", is.corr = FALSE, type="full", order = "hclust", diag=F,
         col=colorRampPalette(c("blue","white","red"))(100),
         #addCoef.col = "black",
         number.cex = 0.5
         )



king.matrix <- scan(file="ArxRef.preBQSR.auto.LD.50kb.1.0.5.king")

m2 <-matrix(king.matrix, nrow=45, ncol=45)


sample.info$Admixture_taxa <- ifelse(sample.info$Short.ID == 192, "Blekingehorkei", sample.info$Admixture_taxa)

rownames(m2) <- sample.info$Admixture_taxa #round(inbred_df$F, 2)
rownames(m2)<-ifelse(rownames(m2) == "Artax", "A. artaxerxes", rownames(m2))
rownames(m2)<-ifelse(rownames(m2) == "Agestis", "A. agestis", rownames(m2))

colnames(m2) <- sample.info$Locality

corrplot(m2,  method="color", is.corr = FALSE, type="lower", order = "hclust",
         col=colorRampPalette(c("blue","white","red"))(200),
         #addCoef.col = "black",
         number.cex = 0.5
)


