rm(list=ls())
library(data.table)
setwd('/shared/aj_manuscript_data/experiment_0')


k50_real_ns <- fread('IKC_50_realignment.clustering')
k50_expt1 <- fread('../experiment_1/IKC_50_km_totaldegree_1percent.clustering')

k40_real_ns <- fread('IKC_40_realignment.clustering')
k40_expt1_totdeg <- fread('../experiment_1/IKC_40_km_totaldegree_1percent.clustering')
k40_expt2_indegree_1percent <- fread('../experiment_2/IKC_40_km_indegree_1percent.clustering')
k40_expt2_indegree_5percent <- fread('../experiment_2/IKC_40_km_indegree_5percent.clustering')
k40_expt2_indegree_95thperc <- fread('../experiment_2/IKC_40_km_indegree_95percentile.clustering')
k40_expt3_totdeg_mcd <- fread('../experiment_3/IKC_40_mcd_totaldegree_1percent.clustering')

k40_expt0_counts <- k40_real_ns[,.N,by='V1']
k40_expt1_totdeg_counts <- k40_expt1_totdeg[,.N,by='V1']
k40_expt2_indeg_1p_counts <- k40_expt2_indegree_1percent[,.N,by='V1']
k40_expt2_indeg_5p_counts <- k40_expt2_indegree_5percent[,.N,by='V1']
k40_expt2_indeg_95thperc_counts <- k40_expt2_indegree_95thperc[,.N,by='V1']
k40_expt3_totdeg_mcd_counts <- k40_expt3_totdeg_mcd[,.N,by='V1']

t <- merge(k40_expt0_counts,k40_expt1_totdeg_counts,by.x='V1',by.y='V1')
colnames(t) <- c('cluster_id','expt0','expt1_totdeg')

t <- merge(t,k40_expt2_indeg_1p_counts,by.x='cluster_id',by.y='V1')
colnames(t) <- c('cluster_id','expt0','expt1_totdeg','expt2_indeg_1p')

t <- merge(t,k40_expt2_indeg_5p_counts,by.x='cluster_id',by.y='V1')
colnames(t) <- c('cluster_id','expt0','expt1_totdeg','expt2_indeg_1p','expt2_indeg_5p')

t <- merge(t,k40_expt2_indeg_95thperc_counts,by.x='cluster_id',by.y='V1')
colnames(t) <- c('cluster_id','expt0','expt1_totdeg','expt2_indeg_1p','expt2_indeg_5p','expt2_indeg_95thperc')

t <- merge(t,k40_expt3_totdeg_mcd_counts,by.x='cluster_id',by.y='V1')
colnames(t) <- c('cluster_id','expt0','expt1_totdeg','expt2_indeg_1p','expt2_indeg_5p','expt2_indeg_95thperc','expt3_totdeg_1p_mcd')

t_perc <- t[,.(cluster_id, expt0_counts=expt0,expt0=expt0/expt0,
     expt1_total_deg=round(expt1_totdeg/expt0,3),
     expt2_indeg_1p=round(expt2_indeg_1p/expt0,3),
     expt2_indeg_5p=round(expt2_indeg_5p/expt0,3),
     expt2_indeg_95thperc=round(expt2_indeg_95thperc/expt0,3),
     expt3_totdeg_1p_mcd=round(expt3_totdeg_1p_mcd/expt0,3))]

library(gridExtra)
table1 <- tableGrob(t)
table2 <- tableGrob(t_perc)

pdf("test.pdf", height=7, width = 12)
grid.arrange(table1,table2,ncol=1,nrow=2)
dev.off()
