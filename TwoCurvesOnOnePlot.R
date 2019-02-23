library(ggplot2)

data <- read.table("DataForTwoCurvesPlot.txt",header=T,sep="\t")


df2 = data.frame(y = data[,2], x = data[,"DS"])
df3 = data.frame(y = data[,3], x = data[,"DS"])

df2$Method <- "BP"
df3$Method <- "NSA"

df4 <- rbind(df2,df3)
df4$Method<- factor(df4$Method)


ggplot(data=df4, aes(x=x, y=y)) +
  #draw line with different linetypes
  geom_line(size=1, aes(linetype=Method))+
  #axis titles
  xlab("Data size, pc") +
  ylab("Number of changes detected, pc") +
  #set limits for y axis
  ylim(0, 4) +
  #set line types manually (to redo the automatic selection of types)
  scale_linetype_manual(values=c("dashed","solid"))+
  theme_bw() +
  theme(
    #axis adjustment
    axis.title.x = element_text(face="bold",size=14),
    axis.title.y = element_text(face="bold",size=14),
    axis.text = element_text(size = 14),
    
    #legend adjustment
    legend.key = element_rect(fill = "white"),
    legend.background = element_rect(fill = "white"),
    
    #grid adjustment
    panel.grid.major = element_line(colour = "grey"),
    panel.grid.minor = element_blank()
  ) 

