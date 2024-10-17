library(ggplot2)
library(ggpubr)
library(grid)

dataset_mC <- read.table(file=file.choose(), header = T)
dataset_mBaga <- read.table(file=file.choose(), header = T)
dataset_mBarx <- read.table(file=file.choose(), header = T)
dataset_mA <- read.table(file=file.choose(), header = T)

dataset<-dataset_mC
tnorm<-max(dataset[1,2:7])

theta_4R
space=0.1


root=round(dataset_mC$tau_4R[1]/(2.9*(10^-9))) #Mutation rate from Heliconius melpomene, see Keightley et al. 2015, Molecular Biology and Evolution
hevent=round(dataset_mC$tau_6H[1]/(2.9*(10^-9)))
phi1=round((dataset_mC$phi_H..S[1])*100, 1)
phi2=round((1-dataset_mC$phi_H..S[1])*100, 1)


mC<-ggplot() + 
  geom_rect(aes(xmin = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2 -dataset_mC$theta_4R[1] , xmax = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2 +dataset_mC$theta_4R[1], ymin = dataset_mC$tau_4R[1], ymax = dataset_mC$tau_4R[1]*1.01), 
            fill = "blue", alpha = 0.4, color = "black") + 
  
  geom_segment(aes(x = 0, xend=space+dataset_mC$theta_7T[1], y=dataset_mC$tau_4R[1] ))+
 
   geom_rect(aes(xmin = 0, xmax = dataset_mC$theta_5S[1], ymin = dataset_mC$tau_5S[1], ymax = dataset_mC$tau_4R[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space, xmax = space+dataset_mC$theta_7T[1], ymin = dataset_mC$tau_7T[1] , ymax = dataset_mC$tau_4R[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = 0, xmax = dataset_mC$theta_1Artax[1], ymin = 0, ymax = dataset_mC$tau_5S[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space+dataset_mC$theta_7T[1] - dataset_mC$theta_3Agestis[1], xmax = space+dataset_mC$theta_7T[1], ymin = 0 , ymax = dataset_mC$tau_7T[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2 -dataset_mC$theta_2Horkei[1] , xmax = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2 +dataset_mC$theta_2Horkei[1], ymin = 0 , ymax = dataset_mC$tau_6H[1]), 
            fill = "darkgreen", alpha = 1, color = "black")+
  
  geom_segment(aes(x = 0, y = dataset_mC$tau_6H[1], xend = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2, yend = dataset_mC$tau_6H[1]),
               arrow = arrow(length = unit(0.5*dataset_mC$phi_H..S[1], "cm")), linewidth=2*dataset_mC$phi_H..S[1])+
  geom_segment(aes(x = space+dataset_mC$theta_7T[1], y = dataset_mC$tau_6H[1], xend = dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2, yend = dataset_mC$tau_6H[1]),
             arrow = arrow(length = unit(0.5*(1-dataset_mC$phi_H..S[1]), "cm")), linewidth=2*(1-dataset_mC$phi_H..S[1]))+
  ylim(0, 0.00125)+
  
  #annotate("text", x=dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2, y=dataset_mC$tau_4R[1]*0.97, label= paste("\u03C4", bquote(.[R]), "=", root,  sep=" ")) + 
  annotate("text", x=dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2, y=dataset_mC$tau_4R[1]*0.97, label= bquote("\u03C4"[R]~" = "~.(root))) + 
  annotate("text", x=dataset_mC$theta_5S[1]+(space-dataset_mC$theta_5S[1])/2, y=dataset_mC$tau_6H[1]*1.5, label= bquote("\u03C4"[H]~" = "~.(hevent))) + 
  annotate("text", x=dataset_mC$theta_5S[1], y=dataset_mC$tau_6H[1]*0.8, label= paste(phi1, "%", sep="")) + 
  annotate("text", x=space, y=dataset_mC$tau_6H[1]*0.8, label= paste(phi2, "%", sep="")) + 
 
  
 theme_void()


#mBarx

root=round(dataset_mBarx$tau_4R[1]/(2.9*(10^-9)))
hevent=round(dataset_mBarx$tau_6H[1]/(2.9*(10^-9)))
phi1=round((dataset_mBarx$phi_H..T[1])*100, 1)
phi2=round((1-dataset_mBarx$phi_H..T[1])*100, 1)

mBarx<-ggplot() + 
  geom_rect(aes(xmin = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2 -dataset_mBarx$theta_4R[1] , xmax = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2 +dataset_mBarx$theta_4R[1], ymin = dataset_mBarx$tau_4R[1], ymax = dataset_mBarx$tau_4R[1]*1.01), 
            fill = "blue", alpha = 0.4, color = "black") + 
  
  geom_segment(aes(x = 0, xend=space+dataset_mBarx$theta_7T[1], y=dataset_mBarx$tau_4R[1] ))+
  
  geom_rect(aes(xmin = 0, xmax = dataset_mBarx$theta_5S[1], ymin = dataset_mBarx$tau_5S[1], ymax = dataset_mBarx$tau_4R[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space, xmax = space+dataset_mBarx$theta_7T[1], ymin = dataset_mBarx$tau_7T[1] , ymax = dataset_mBarx$tau_4R[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = 0, xmax = dataset_mBarx$theta_1Artax[1], ymin = 0, ymax = dataset_mBarx$tau_5S[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space+dataset_mBarx$theta_7T[1] - dataset_mBarx$theta_3Agestis[1], xmax = space+dataset_mBarx$theta_7T[1], ymin = 0 , ymax = dataset_mBarx$tau_7T[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2 -dataset_mBarx$theta_2Horkei[1] , xmax = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2 +dataset_mBarx$theta_2Horkei[1], ymin = 0 , ymax = dataset_mBarx$tau_6H[1]), 
            fill = "darkgreen", alpha = 1, color = "black")+
  
  geom_rect(aes(xmin = dataset_mBarx$theta_5S[1] -dataset_mBarx$theta_6H[1] , xmax = dataset_mBarx$theta_5S[1], ymin = dataset_mBarx$tau_6H[1] , ymax =dataset_mBarx$tau_5S[1] ), 
            fill = "brown4", alpha = 1, color = "black")+
  geom_segment(aes(x = dataset_mBarx$theta_5S[1] -dataset_mBarx$theta_6H[1],  xend = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2,  y = dataset_mBarx$tau_6H[1], yend = dataset_mBarx$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(1-dataset_mBarx$phi_H..T[1]), "cm")), linewidth=2*(1-dataset_mBarx$phi_H..T[1]))+
  geom_segment(aes(x = space+dataset_mBarx$theta_7T[1],  xend = dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2,  y = dataset_mBarx$tau_6H[1], yend = dataset_mBarx$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(dataset_mBarx$phi_H..T[1]), "cm")), linewidth=2*(dataset_mBarx$phi_H..T[1]))+
  ylim(0, 0.00125)+
  annotate("text", x=dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2, y=dataset_mBarx$tau_4R[1]*0.97, label= bquote("\u03C4"[R]~" = "~.(root))) + 
  annotate("text", x=dataset_mBarx$theta_5S[1]+(space-dataset_mBarx$theta_5S[1])/2, y=dataset_mBarx$tau_6H[1]*1.5, label= bquote("\u03C4"[H]~" = "~.(hevent))) + 
  
  annotate("text", x=dataset_mBarx$theta_5S[1], y=dataset_mBarx$tau_6H[1]*0.8, label= paste( phi2, "%", sep="")) + 
  annotate("text", x=space, y=dataset_mBarx$tau_6H[1]*0.8, label= paste( phi1, "%", sep="")) + 
  
 theme_void()




#mBaga


root=round(dataset_mBaga$tau_4R[1]/(2.9*(10^-9)))
hevent=round(dataset_mBaga$tau_6H[1]/(2.9*(10^-9)))
phi1=round((dataset_mBaga$phi_H..S[1])*100, 1)
phi2=round((1-dataset_mBaga$phi_H..S[1])*100, 1)


mBaga<-ggplot() + 
  geom_rect(aes(xmin = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2 -dataset_mBaga$theta_4R[1] , xmax = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2 +dataset_mBaga$theta_4R[1], ymin = dataset_mBaga$tau_4R[1], ymax = dataset_mBaga$tau_4R[1]*1.01), 
            fill = "blue", alpha = 0.4, color = "black") + 
  
  geom_segment(aes(x = 0, xend=space+dataset_mBaga$theta_7T[1], y=dataset_mBaga$tau_4R[1] ))+
  
  geom_rect(aes(xmin = 0, xmax = dataset_mBaga$theta_5S[1], ymin = dataset_mBaga$tau_5S[1], ymax = dataset_mBaga$tau_4R[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space, xmax = space+dataset_mBaga$theta_7T[1], ymin = dataset_mBaga$tau_7T[1] , ymax = dataset_mBaga$tau_4R[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = 0, xmax = dataset_mBaga$theta_1Artax[1], ymin = 0, ymax = dataset_mBaga$tau_5S[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space+dataset_mBaga$theta_7T[1] - dataset_mBaga$theta_3Agestis[1], xmax = space+dataset_mBaga$theta_7T[1], ymin = 0 , ymax = dataset_mBaga$tau_7T[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2 -dataset_mBaga$theta_2Horkei[1] , xmax = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2 +dataset_mBaga$theta_2Horkei[1], ymin = 0 , ymax = dataset_mBaga$tau_6H[1]), 
            fill = "darkgreen", alpha = 1, color = "black")+
  
  geom_rect(aes(xmin = space , xmax = space +dataset_mBaga$theta_8H[1], ymin = dataset_mBaga$tau_6H[1] , ymax =dataset_mBaga$tau_7T[1] ), 
            fill = "orange", alpha = 1, color = "black")+

  geom_segment(aes(x = dataset_mBaga$theta_5S[1] -dataset_mBaga$theta_8H[1],  xend = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2,  y = dataset_mBaga$tau_6H[1], yend = dataset_mBaga$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(dataset_mBaga$phi_H..S[1]), "cm")), linewidth=2*(dataset_mBaga$phi_H..S[1]))+
  geom_segment(aes(x = space +dataset_mBaga$theta_8H[1],  xend = dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2,  y = dataset_mBaga$tau_6H[1], yend = dataset_mBaga$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(1-dataset_mBaga$phi_H..S[1]), "cm")), linewidth=2*(1-dataset_mBaga$phi_H..S[1]))+
  ylim(0, 0.00125)+
  annotate("text", x=dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2, y=dataset_mBaga$tau_4R[1]*0.97, label= bquote("\u03C4"[R]~" = "~.(root))) + 
  annotate("text", x=dataset_mBaga$theta_5S[1]+(space-dataset_mBaga$theta_5S[1])/2, y=dataset_mBaga$tau_6H[1]*1.5, label= bquote("\u03C4"[H]~" = "~.(hevent))) + 
  
  annotate("text", x=dataset_mBaga$theta_5S[1], y=dataset_mBaga$tau_6H[1]*0.8, label= paste( phi1, "%", sep="")) + 
  annotate("text", x=space, y=dataset_mBaga$tau_6H[1]*0.8, label= paste( phi2, "%", sep="")) + 
  
  
 theme_void()



#mA

root=round(dataset_mA$tau_4R[1]/(2.9*(10^-9)))
hevent=round(dataset_mA$tau_6H[1]/(2.9*(10^-9)))
phi1=round((dataset_mA$phi_H..S[1])*100, 1)
phi2=round((1-dataset_mA$phi_H..S[1])*100, 1)

mA<-ggplot() +
  
  geom_rect(aes(xmin = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2 -dataset_mA$theta_4R[1] , xmax = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2 +dataset_mA$theta_4R[1], ymin = dataset_mA$tau_4R[1], ymax = dataset_mA$tau_4R[1]*1.01), 
            fill = "blue", alpha = 0.4, color = "black") + 
  
  geom_segment(aes(x = 0, xend=space+dataset_mA$theta_7T[1], y=dataset_mA$tau_4R[1] ))+
  
  geom_rect(aes(xmin = 0, xmax = dataset_mA$theta_5S[1], ymin = dataset_mA$tau_5S[1], ymax = dataset_mA$tau_4R[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space, xmax = space+dataset_mA$theta_7T[1], ymin = dataset_mA$tau_7T[1] , ymax = dataset_mA$tau_4R[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = 0, xmax = dataset_mA$theta_1Artax[1], ymin = 0, ymax = dataset_mA$tau_5S[1]  ), 
            fill = "brown4", alpha = 1, color = "black") +
  geom_rect(aes(xmin = space+dataset_mA$theta_7T[1] - dataset_mA$theta_3Agestis[1], xmax = space+dataset_mA$theta_7T[1], ymin = 0 , ymax = dataset_mA$tau_7T[1]), 
            fill = "orange", alpha = 1, color = "black") +
  
  geom_rect(aes(xmin = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2 -dataset_mA$theta_2Horkei[1] , xmax = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2 +dataset_mA$theta_2Horkei[1], ymin = 0 , ymax = dataset_mA$tau_6H[1]), 
            fill = "darkgreen", alpha = 1, color = "black")+
  
  geom_rect(aes(xmin = dataset_mA$theta_5S[1] -dataset_mA$theta_6H[1] , xmax = dataset_mA$theta_5S[1], ymin = dataset_mA$tau_6H[1] , ymax =dataset_mA$tau_5S[1] ), 
            fill = "brown4", alpha = 1, color = "black")+
  
  geom_rect(aes(xmin = space , xmax = space +dataset_mA$theta_8H[1], ymin = dataset_mA$tau_6H[1] , ymax =dataset_mA$tau_7T[1] ), 
            fill = "orange", alpha = 1, color = "black")+
  
  geom_segment(aes(x = dataset_mA$theta_5S[1] -dataset_mA$theta_6H[1],  xend = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2,  y = dataset_mA$tau_6H[1], yend = dataset_mA$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(dataset_mA$phi_H..S[1]), "cm")), linewidth=2*(dataset_mA$phi_H..S[1]))+
  geom_segment(aes(x = space +dataset_mA$theta_8H[1],  xend = dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2,  y = dataset_mA$tau_6H[1], yend = dataset_mA$tau_6H[1]),
               arrow = arrow(length = unit(0.5*(1-dataset_mA$phi_H..S[1]), "cm")), linewidth=2*(1-dataset_mA$phi_H..S[1]))+
  ylim(0, 0.00125)+
  annotate("text", x=dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2, y=dataset_mA$tau_4R[1]*0.97, label= bquote("\u03C4"[R]~" = "~.(root))) + 
  annotate("text", x=dataset_mA$theta_5S[1]+(space-dataset_mA$theta_5S[1])/2, y=dataset_mA$tau_6H[1]*1.5, label= bquote("\u03C4"[H]~" = "~.(hevent))) +  
  
  annotate("text", x=dataset_mA$theta_5S[1], y=dataset_mA$tau_6H[1]*0.7, label= paste( phi1, "%", sep="")) + 
  annotate("text", x=space, y=dataset_mA$tau_6H[1]*0.7, label= paste( phi2, "%", sep="")) + 
  
 theme_void()


ggarrange(mA,mBaga,mBarx, mC, ncol = 4)
