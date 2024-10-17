library(ggplot2)

#See: https://bpp.github.io/bpp-manual/bpp-4-manual/#exercise-and-results
# and https://dx.doi.org/10.1093/sysbio/syw119 for details

setwd("~/Downloads")
margliks<-read.table(file="weights_and_elves.txt")

colnames(margliks)<-c("Model", "Weights", "Elves")


ggplot(margliks, aes(x=Weights, y=Elves, col=Model))+geom_point()+geom_line()


margliks2<-aggregate((Weights*Elves)/2~Model, margliks, sum)

colnames(margliks2) <- c("Model", "Marginal_L")

exp(margliks2[margliks2$Model=="mC",]$Marginal_L-margliks2[margliks2$Model=="mA",]$Marginal_L)
exp(margliks2[margliks2$Model=="mC",]$Marginal_L-margliks2[margliks2$Model=="mBarx",]$Marginal_L)
exp(margliks2[margliks2$Model=="mC",]$Marginal_L-margliks2[margliks2$Model=="mBaga",]$Marginal_L)
