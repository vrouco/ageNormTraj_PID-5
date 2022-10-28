# Here we explore configural invariance across the six groups, AND invariance over the correlated residual structure

#packages and dependencies
library(here)
library(lavaan)

source(here::here("data/data input.R"))
load(here::here("objects/facet_models_mod.Rdata"))


#### CONFIG INVARIANCE ####

pre.cu.config.modelfit <- data.frame(matrix(nrow=25, ncol=6))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group")
  pre.cu.config.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  pre.cu.config.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(pre.cu.config.modelfit) <- names(facet_models_mod)
colnames(pre.cu.config.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")

#there are two Heywood cases

# for(i in 1:25){
#   tryCatch(cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group"),
#            warning = function(w){
#              print(names(facet_models_mod[i]))
#            })
#               }
#Depressivity and Perceptual Dysregulation

#### CR INVARIANCE ####

full.config.modelfit <- data.frame(matrix(nrow=25, ncol=6))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal="residual.covariances")
  full.config.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  full.config.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

#there are three Heywood cases

# for(i in 1:25){
#   tryCatch(cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal="residual.covariances"),
#            warning = function(w){
#              print(names(facet_models_mod[i]))
#            })
# }
#Depressivity, Intimacy Avoidance, Perceptual Dysregulation


rownames(full.config.modelfit) <- names(facet_models_mod)
colnames(full.config.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")


mi <- data.frame(cr = pre.cu.config.modelfit$CFI - full.config.modelfit$CFI)
rownames(mi) <- names(facet_models_mod)


