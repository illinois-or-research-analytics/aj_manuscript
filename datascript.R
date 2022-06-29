setwd('/shared/aj_manuscript_data/gc')
library(data.table)
input_el <- fread('/srv/local/shared/external/dbid/george/exosome_dimensions_wedell_retraction-depleted_jc250-corrected_no_header.tsv')
input_nl <- union(unique(input_el$V1),unique(input_el$V2))
input_nl <- setDT(data.frame(input_nl))
names(input_nl) <- 'node_id'
setkey(input_nl,node_id)
cited <- input_el[,.N,by='V2']
s1 <- merge(input_nl,cited,by.x='node_id',by.y='V2',all.x=TRUE)
names(s1) <- c('node_id','cited')
citing <- input_el[,.N,by='V1']
s2 <- merge(s1,citing,by.x='node_id',by.y='V1',all.x=TRUE)
s2[is.na(s2)] <- 0
names(s2) <- c('node_id','cited','citing')
s2[,total_degree:=cited+citing]
s3 <- s2[total_degree >= 180] # quantile 0.99
setwd("/shared/aj_manuscript_data/gc")
fwrite(s3,file='aj_top1percentbyquantile.csv')




