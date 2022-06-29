rm(list=ls())
library(data.table)

ikc50_k <- fread('./experiment_51/equil_IKC_50.clustering_k')
ikc50_m <- fread('./experiment_51/equil_IKC_50.clustering_mcd')

ikc40_k <- fread('./experiment_52/equil_IKC_40.clustering_k')
ikc40_m <- fread('./experiment_52/equil_IKC_40.clustering_mcd')

ikc30_k <- fread('./experiment_53/equil_IKC_30.clustering_k')
ikc30_m <- fread('./experiment_53/equil_IKC_30.clustering_mcd')

ikc20_k <- fread('./experiment_54/equil_IKC_20.clustering_k')
ikc20_m <- fread('./experiment_54/equil_IKC_20.clustering_mcd')

ikc10_k <- fread('./experiment_55/equil_IKC_10.clustering_k')
ikc10_m <- fread('./experiment_55/equil_IKC_10.clustering_mcd')

df_vec <- ls()
ikc_list <- list()

for (i in 1:length(df_vec)){
ikc_list[[i]] <- get(noquote(df_vec[i]))
}

names(ikc_list) <- df_vec
ikc_list2 <- lapply(ikc_list,FUN=function(x) x[,.(no_clusters=.N),by='V2'][,.(node_count=.N),by='no_clusters'][order(no_clusters)])

for (i in 1:length(ikc_list2)){
ikc_list2[[i]][,tag:=names(ikc_list2)[i]]
}
df_ikc_list2 <- rbindlist(ikc_list2)
fwrite(df_ikc_list2,file='df_ikc_list2.csv')

# for Table 1
library(xtable)
xtable(dcast(df_ikc_list2,no_clusters~tag,value.var="node_count"))



