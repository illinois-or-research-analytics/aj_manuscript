# script to assemble data for a table that can be used in Fig. 1
# for the aj manuscript. GC 5/27/2022

# preamble
setwd('/shared/gc')
rm(list=ls())
library(data.table)
library(ggplot2)

# read in data from equil.R script
x <- fread('equil_1_kall.csv')

# split up by tags to recombine
o <- x[tag1=='o']
m <- x[tag1=='m']
k <- x[tag1=='k']

# for plot of o against k
ok <- merge(o, k, by= c('tag2','V1'))
# for plot of o against m
om <- merge(o, m, by= c('tag2','V1'))

colnames(ok)[1] <- 'ikc'
p_ok1 <- qplot(data=ok,log(N.x),log(N.y),color=ikc) + 
xlab("cluster size original") + 
ylab("cluster size aoc_k") + 
geom_abline(slope=1) + theme_bw()

p_ok2 <- p_ok1 + theme(axis.text=element_text(size=18),
      axis.title=element_text(size=20), legend.text=element_text(size=16),
      legend.title=element_blank(),legend.position=c(0.8,0.3))

# for plot of o against m
colnames(om)[1] <- 'ikc'
p_om1 <- qplot(data=om,log(N.x),log(N.y),color=ikc) + 
xlab("cluster size original") + 
ylab("cluster size aoc_m") + 
geom_abline(slope=1) + theme_bw()

p_om2 <- p_om1 + theme(axis.text=element_text(size=18),
      axis.title=element_text(size=20), legend.text=element_text(size=16),
      legend.title=element_blank(),legend.position=c(0.8,0.3))

pdf('fig1a.pdf')
print(p_ok2)
dev.off()

pdf('fig1b.pdf')
print(p_om2)
dev.off()



