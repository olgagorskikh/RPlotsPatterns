# RPlotsPatterns
This repository is designed to store some nice R scripts for producing different types of plots. 

## Two curves on one plot
In many problems, comparison of different curves is quite essintial and we also faced this issue considerably often. This is why there appeared a need to store this type of a script separately. In the current case, we aim to compare the performance of two methods (abbreviated as BP and NSA) based on the number of changes they were able to detect in a set of datasets of different length.
we have a dataset (DataForTwoCurvesPlot.txt) containing three columns:
* DS - data size 
* BP - number of changes BP found in this dataset
* NSA - correspondingly, the number of changes NSA found in this dataset

This dataset was generated within my private research in educational purposes. To draw the plots we are using the library <br>ggplot2.</br> After draming the data to a required form we run the following code
```
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
  ```
  which gives us the desired graph
  
