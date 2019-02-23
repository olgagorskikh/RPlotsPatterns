data <- read.table("DataForMultipleHistos.txt",header=T,sep="\t")

library('ggplot2')
library('gridExtra')

plots <- list()
#titles of four historgrams to plot
names <- c("d=0.1","d=2","d=10", "d=20")
ditributionNames <-c("normal distribution","student distribution (df=3)")
xlabTitle <- "Amount of outliers, %"

#make a common legend for several plots
#https://github.com/hadley/ggplot2/wiki/Share-a-legend-between-two-ggplot2-graphs
g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}


for (i in 1:4)
{
  currentData <- data[((3*i)-2):((3-i)+1),]
  
  #relevant data retrieval part
  df2 = data.frame(y = currentData[,"All"], x = currentData[,"Outl"]*100)
  df3 = data.frame(y = currentData[,"All_s"], x = currentData[,"Outl"]*100)
  df2$id <- ditributionNames[1]
  df3$id <- ditributionNames[2]
  df4 <- rbind(df2,df3)
  df4 <- as.data.frame(lapply(df4, unlist))
  df4$id <- factor(df4$id)
  
  #create the plot itself
  currentPlot<- ggplot(data=df4, aes(x=factor(x), y=y, fill=id)) +
    #draw the bars
    geom_bar(width=.6,stat="identity", position=position_dodge(), colour="black") +
    #adjust labs data
    xlab(xlabTitle) +
    ylab("") +
    ylim(0, 130) +
    #set the title for the plot
    ggtitle(names[[i]])+
    #colors of bars
    scale_fill_manual(values=c("gray57", "gray15"), name ="")+
    theme_bw() +
    theme(
      #axis adjustment
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
      axis.text = element_text(size = 14),
      
      #legend adjustment
      legend.key = element_rect(fill = "navy"),
      legend.background = element_rect(fill = "white"),
      legend.position="bottom",
      legend.text = element_text(size = 14),
      
      #grid adjustment
      panel.grid.major = element_line(colour = "grey"),
      panel.grid.minor = element_blank()
    ) 
  
  plots[[i]] = currentPlot
}

#build a legend
mylegend<-g_legend(plots[[1]])

#draw the final plot
finalPlot <- grid.arrange(top="Percentage of all points detected",
                   arrangeGrob(plots[[1]] + theme(legend.position="none"),
                               plots[[2]] + theme(legend.position="none"),
                               plots[[3]] + theme(legend.position="none"),
                               plots[[4]] + theme(legend.position="none"),
                               nrow=1),
                   mylegend, nrow=2,heights=c(10, 1))

















