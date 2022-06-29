rm(list=ls())
setwd("/shared/gc")
library(data.table)
library(ggplot2)

# expt 51
ikc50_aoc_k <- fread('./experiment_51/equil_IKC_50.clustering_k')
ikc50_aoc_m <- fread('./experiment_51/equil_IKC_50.clustering_mcd')
ikc50 <- fread('../aj_manuscript_data/experiment_0/IKC_50_realignment.clustering')

# expt 52
ikc40_aoc_k <- fread('./experiment_52/equil_IKC_40.clustering_k')
ikc40_aoc_m <- fread('./experiment_52/equil_IKC_40.clustering_mcd')
ikc40 <- fread('../aj_manuscript_data/experiment_0/IKC_40_realignment.clustering')

# expt 53
ikc30_aoc_k <- fread('./experiment_53/equil_IKC_30.clustering_k')
ikc30_aoc_m <- fread('./experiment_53/equil_IKC_30.clustering_mcd')
ikc30 <- fread('../aj_manuscript_data/experiment_0/IKC_30_realignment.clustering')

# expt 54
ikc20_aoc_k <- fread('./experiment_54/equil_IKC_20.clustering_k')
ikc20_aoc_m <- fread('./experiment_54/equil_IKC_20.clustering_mcd')
ikc20 <- fread('../aj_manuscript_data/experiment_0/IKC_20_realignment.clustering')

# expt 55
ikc10_aoc_k <- fread('./experiment_55/equil_IKC_10.clustering_k')
ikc10_aoc_m <- fread('./experiment_55/equil_IKC_10.clustering_mcd')
ikc10 <- fread('../aj_manuscript_data/experiment_0/IKC_10_realignment.clustering')

## get counts per clustering and aoc_treatment

# expt 55
ikc10_c <- ikc10[,.N,by='V1']
ikc10_aoc_k_c <- ikc10_aoc_k[,.N,by='V1']
ikc10_aoc_m_c <- ikc10_aoc_m[,.N,by='V1']
ikc10_c[,tag1:='o']
ikc10_aoc_k_c[,tag1:='k']
ikc10_aoc_m_c[,tag1:='m']

# expt 54
ikc20_c <- ikc20[,.N,by='V1']
ikc20_aoc_k_c <- ikc20_aoc_k[,.N,by='V1']
ikc20_aoc_m_c <- ikc20_aoc_m[,.N,by='V1']
ikc20_c[,tag1:='o']
ikc20_aoc_k_c[,tag1:='k']
ikc20_aoc_m_c[,tag1:='m']

# expt 53
ikc30_c <- ikc30[,.N,by='V1']
ikc30_aoc_k_c <- ikc30_aoc_k[,.N,by='V1']
ikc30_aoc_m_c <- ikc30_aoc_m[,.N,by='V1']
ikc30_c[,tag1:='o']
ikc30_aoc_k_c[,tag1:='k']
ikc30_aoc_m_c[,tag1:='m']

# expt 52
ikc40_c <- ikc40[,.N,by='V1']
ikc40_aoc_k_c <- ikc40_aoc_k[,.N,by='V1']
ikc40_aoc_m_c <- ikc40_aoc_m[,.N,by='V1']
ikc40_c[,tag1:='o']
ikc40_aoc_k_c[,tag1:='k']
ikc40_aoc_m_c[,tag1:='m']

# expt 51
ikc50_c <- ikc50[,.N,by='V1']
ikc50_aoc_k_c <- ikc50_aoc_k[,.N,by='V1']
ikc50_aoc_m_c <- ikc50_aoc_m[,.N,by='V1']
ikc50_c[,tag1:='o']
ikc50_aoc_k_c[,tag1:='k']
ikc50_aoc_m_c[,tag1:='m']

#tags

k50 <- rbind(ikc50_c,ikc50_aoc_m_c,ikc50_aoc_k_c)
k50[,tag2:='ikc50']

k40 <- rbind(ikc40_c,ikc40_aoc_m_c,ikc40_aoc_k_c)
k40[,tag2:='ikc40']

k30 <- rbind(ikc30_c,ikc30_aoc_m_c,ikc30_aoc_k_c)
k30[,tag2:='ikc30']

k20 <- rbind(ikc20_c,ikc20_aoc_m_c,ikc20_aoc_k_c)
k20[,tag2:='ikc20']

k10 <- rbind(ikc10_c,ikc10_aoc_m_c,ikc10_aoc_k_c)
k10[,tag2:='ikc10']

k_all <- rbind(k50,k40,k30,k20,k10)
fwrite(k_all,file='equil_1_kall.csv')



