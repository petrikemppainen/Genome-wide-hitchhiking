library(data.table)
library(ggplot2)
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
par(mfcol=c(2,1))

## read in simulated data, means from 100 replicates
dt_1 <- fread("~/Dropbox/quantiNemo/proof_of_principle/Ne_LD/unlinked/selection_met_1/simulation_mean.txt")
dt_0.8 <- fread("~/Dropbox/quantiNemo/proof_of_principle/Ne_LD/unlinked/selection_met_0.8/simulation_mean.txt")
dt_0.5 <- fread("~/Dropbox/quantiNemo/proof_of_principle/Ne_LD/unlinked/selection_met_0.5/simulation_mean.txt")
dt_0.001 <- fread("~/Dropbox/quantiNemo/proof_of_principle/Ne_LD/unlinked/selection_met_0.001/simulation_mean.txt")

col2 = "salmon"
col1 = "steelblue"

data <- rbind(data.table(Mean_LD=apply(dt_1[,-c(1:4)], 1, function(x) mean(x,   na.rm = T)), Genearation=1:100, Heritability="1"),
              data.table(Mean_LD=apply(dt_0.8[,-c(1:4)], 1, function(x) mean(x,   na.rm = T)), Genearation=1:100, Heritability="0.8"),
              data.table(Mean_LD=apply(dt_0.5[,-c(1:4)], 1, function(x) mean(x,   na.rm = T)), Genearation=1:100, Heritability="0.5"),
              data.table(Mean_LD=apply(dt_0.001[,-c(1:4)], 1, function(x) mean(x,   na.rm = T)), Genearation=1:100, Heritability="0.001"))

p1 <- ggplot(data, aes(Genearation, Mean_LD, col=Heritability)) +
  geom_line() +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor  = element_blank(),
        strip.background = element_blank(),
        #strip.text.x = element_blank(),
        #strip.text.y = element_blank(),
        #plot.title = element_text(size=8),
        legend.position = c(0.9, 0.82),
        legend.background = element_rect(fill="transparent")
  ) +
  ylab("Mean LD (r^2) among neutral unlinked loci") +
  xlab("Generations of selection")


data2 <- rbind(data.table(Hobs=as.vector(as.matrix(dt_1[,4])), Genearation=1:100, Heritability="1", Loci="QTL"),
               data.table(Hobs=as.vector(as.matrix(dt_0.8[,4])), Genearation=1:100, Heritability="0.8", Loci="QTL"),
               data.table(Hobs=as.vector(as.matrix(dt_0.5[,4])), Genearation=1:100, Heritability="0.5", Loci="QTL"),
               data.table(Hobs=as.vector(as.matrix(dt_0.001[,4])), Genearation=1:100, Heritability="0.001", Loci="QTL"),
               data.table(Hobs=as.vector(as.matrix(dt_1[,3])), Genearation=1:100, Heritability="1", Loci="Neutral"),
               data.table(Hobs=as.vector(as.matrix(dt_0.8[,3])), Genearation=1:100, Heritability="0.8", Loci="Neutral"),
               data.table(Hobs=as.vector(as.matrix(dt_0.5[,3])), Genearation=1:100, Heritability="0.5", Loci="Neutral"),
               data.table(Hobs=as.vector(as.matrix(dt_0.001[,3])), Genearation=1:100, Heritability="0.001", Loci="Neutral"))


p2 <- ggplot(data2, aes(Genearation, Hobs, col=Heritability)) +
  geom_line(aes(linetype=Loci)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor  = element_blank(),
        strip.background = element_blank(),
        #strip.text.x = element_blank(),
        #strip.text.y = element_blank(),
        #plot.title = element_text(size=8),
        legend.position = c(0.9, 0.88),
        legend.background = element_rect(fill="transparent")
  ) +
  ylab("Observed heterozygosity") +
  scale_colour_discrete(guide = FALSE) +
  xlab("Generations of selection")

png("Figure1.png", res = 300, units = "in", height = 5, width = 10)
multiplot(p1+ggtitle("A"), p2+ggtitle("B"), cols = 2)
dev.off()

