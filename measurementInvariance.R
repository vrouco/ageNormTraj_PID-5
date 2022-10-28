library(here)
source(here("data/data input.R"))
source(here("tools/models.R"))
source(here("tools/functions.R"))
library(lavaan)

source(here::here("MI/configural invariance.R"))
source(here::here("MI/metric invariance.R"))
source(here::here("MI/scalar invariance.R"))

for(i in 1:25){
  if(mi$scalar[i]<0.01){
    mi$level[i] <- "scalar"
  }else if(mi$partial.scalar[i]<0.01){
    mi$level[i] <- "partial.scalar"
  }else if(mi$metric[i]<0.01){
    mi$level[i] <- "metric"
  }else if(mi$partial.metric[i]<0.01){
    mi$level[i] <- "partial.metric"
  }else {
    mi$level[i] <- "configural"
  }
}


pre.cu.config.modelfit <- pre.cu.config.modelfit[my.order.facets, ]


mi <- mi[my.order.facets, ]
mi[,1:5] <- as.data.frame(lapply(mi[,1:5], round, 3))

pre.cu.config.modelfit$CHISQ <- paste0(pre.cu.config.modelfit$CHISQ, " (", pre.cu.config.modelfit$DF, ")")
pre.cu.config.modelfit <- pre.cu.config.modelfit[,c(-2,-5,-7)]

save(mi, file=here::here("objects/mi object.Rdata"))
write.csv(cbind(pre.cu.config.modelfit, mi), here::here("tables/full mi table.csv"))
