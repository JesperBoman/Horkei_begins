install.packages("ape")
install.packages("phangorn")
install.packages("phytools")
install.packages("geiger")

library(ape)
library(phangorn)
library(phytools)
library(geiger)

splitAxisTree<-function(tree,start,end,buffer=0.03,...){
  tt<-make.era.map(tree,limits=c(0,start,end))
  H<-max(nodeHeights(tree))
  buffer<-buffer*(H-end+start)
  scale<-setNames(c(1,buffer/(end-start),1),1:3)
  tt$maps<-lapply(tt$maps,function(x,scale) 
    x*scale[names(x)],scale=scale)
  tt$edge.length<-sapply(tt$maps,sum)
  args<-list(...)
  args$x<-tt
  args$colors<-cols
  args$direction<-"rightwards"
  if(is.null(args$mar)) args$mar<-c(2.1,1.1,1.1,1.1)
  if(is.null(args$ylim)) args$ylim<-c(0,Ntip(tt))
  if(is.null(args$ftype)) args$ftype<-"i"
  do.call(plot,args)
  markChanges(tt,setNames(rep("black",3),1:3))
  ## I'm doing some weird stuff here in case we're
  ## cutting out a lot of our tree!
  labs<-pretty(c(0,max(nodeHeights(tt))),n=8)
  labs<-seq(0,max(nodeHeights(tree)),by=labs[2]-labs[1])
  labs<-labs[labs<max(nodeHeights(tree))]
  at<-max(nodeHeights(tree))-labs
  labs<-labs[-intersect(which(at>start),which(at<end))]
  at<-at[-intersect(which(at>start),which(at<end))]
  at[at>=end]<-at[at>=end]-(end-start)+buffer
  axis(1,at=at,labels=labs,pos=0,cex.axis=0.8)
  polygon(start+c(0,buffer,buffer,0),
          0.5*mean(strheight(LETTERS))*c(-1,-1,1,1),
          col=if(par()$bg=="transparent") "white" else 
            par()$bg,border=FALSE)
  segments(start+c(0,buffer),
           0.5*mean(strheight(LETTERS))*c(-1,-1),
           start+c(0,buffer),
           0.5*mean(strheight(LETTERS))*c(1,1),lwd=2)
}

#This is the inferred phylogeny
mt_tree<-ape::read.tree(text = "(184:0.0001342330,(142:0.0000671131,160:0.0000020330)82:0.0000671131,((((136:0.0000020330,166:0.0000020330)78:0.0000020330,((((((150:0.0000000000,112:0.0000000000):0.0000000000,176:0.0000000000):0.0000000000,111:0.0000000000):0.0000000000,152:0.0000000000):0.0000000000,168:0.0000000000):0.0000020330,158:0.0000020330)58:0.0000020330)70:0.0000020330,144:0.0000671131)76:0.0001498458,((110:0.0000020330,(118:0.0000020330,(173:0.0000020330,181:0.0000020330)75:0.0000020330)78:0.0000670376)99:0.0006122621,((((((141:0.0000020330,101:0.0000020330)57:0.0000020330,149:0.0000671131)22:0.0000020330,((134:0.0000020330,133:0.0000020330)16:0.0000020330,125:0.0000020330)9:0.0000020330)9:0.0000020330,(117:0.0000020330,((109:0.0000000000,157:0.0000000000):0.0000020330,126:0.0000020330)64:0.0000020330)29:0.0000020330)66:0.0000020330,(165:0.0000020330,189:0.0000020330)76:0.0000671131)100:0.0004716088,((102:0.0002016994,192:0.0000671131)100:0.0003363265,((((((((((159:0.0000000000,127:0.0000000000):0.0000000000,135:0.0000000000):0.0000000000,183:0.0000000000):0.0000020330,119:0.0000020330)71:0.0000020330,175:0.0000020330)61:0.0000020330,105:0.0000671131)68:0.0000020330,151:0.0003364720)83:0.0000671131,128:0.0000671131)52:0.0000020330,(120:0.0000671131,167:0.0000020330)45:0.0000020330)57:0.0000020330,174:0.0000671131)89:0.0002016062)42:0.0000020330)74:0.0002662717)100:0.0259163827)81:0.0000511877);
")

mt_tree$edge.length <- ifelse(mt_tree$edge.length==0.0259163827, mt_tree$edge.length/20, mt_tree$edge.length )

plot.new()
plotTree(mt_tree, edge.width=2)


sample.info <- read.table(file = file.choose(), header = T)
sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info$Admixture_taxa2 <- ifelse(sample.info$Short.ID == 192, "Blekingeartax", sample.info$Admixture_taxa)



mt_tree$Pop <- NA


for(i in 1:length(sample.info$Short.ID)){
  ID <- sample.info$Short.ID[i]
  POS <- grep(ID, mt_tree$tip.label)
  mt_tree$POP[POS] <- sample.info$Admixture_taxa2[i]
}
POP.pat<-setNames(as.factor(mt_tree$POP), mt_tree$tip.label)
cols<-setNames(c("orange", "brown4",  "purple", "darkgreen"),levels(POP.pat))

h<-max(nodeHeights(mt_tree))

plot(unroot(mt_tree), type="unrooted",cex=1, show.tip.label=F, show.node.label=F,
     use.edge.length=TRUE,lab4ut="axial",
     no.margin=F)
pp<-get("last_plot.phylo",envir=.PlotPhyloEnv)
points(pp$xx[1:Ntip(mt_tree)]+0.00001*h,pp$yy[1:Ntip(mt_tree)],pch=16,
       col=cols[POP.pat[mt_tree$tip.label]])

add.scale.bar(0.001,0.0002)


nodelabels(node=1:mt_tree$Nnode+Ntip(mt_tree),
           pie=cbind(as.numeric(mt_tree$node.label),100-as.numeric(mt_tree$node.label)),
           piecol=c("black","white"),cex=0.5)





dotTree(mt_tree,mt_tree$POP,standardize=TRUE)
pp<-get("last_plot.phylo",envir=.PlotPhyloEnv)
points(pp$xx[1:Ntip(mt_tree)]+0.00001*h,pp$yy[1:Ntip(mt_tree)],pch=16,
       col=cols[POP.pat[mt_tree$tip.label]])
nodelabels()#node=1:mt_tree$Nnode+Ntip(mt_tree))
          # pie=cbind(as.numeric(mt_tree$node.label),100-as.numeric(mt_tree$node.label)),
           #piecol=c("black","white"),cex=0.5)




df<-data.frame(tip = mt_tree$tip.label,
               vector.to.color.with = as.factor(c("<10", "10-20", "10-20", "10-20", "NA", "10-20", 
                                                  "10-20", "10-20", "20-35", "<10", "10-20", "<10", 
                                                  "35", "20-35", "<10", "NA", "10-20", "<10")))

cols<-setNames(c("black","transparent","black"),1:3)
splitAxisTree(mt_tree,0.001,0.0259, type="unrooted")



#Average branch length between agestis and artaxerxes



average_len_mt=15515 #From seqkit stats

average_len_mt*0.0259163827


#Horkei internal branch length

average_len_mt*0.0001498458
