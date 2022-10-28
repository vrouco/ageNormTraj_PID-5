
##Packages (& built-in functions) & dependencies

library(lavaan)
source(here::here("tools/metric.partial.plot.R"))#this allows visual exploration of metric partial non-invariance



load(here::here("objects/facet_models_mod.Rdata"))

source(here::here("data/data input.R"))
source(here::here("MI/configural invariance.R"))


####

full.metric.modelfit <- data.frame(matrix(nrow=25, ncol=6))


for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"))
  full.metric.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  full.metric.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(full.metric.modelfit) <- names(facet_models_mod)
colnames(full.metric.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")

mi$metric <- full.config.modelfit$CFI - full.metric.modelfit$CFI



#partial.metric


partial.metric<- vector(mode = "list", length = 25)
names(partial.metric) <- rownames(mi)

#### MANUAL SEARCH FOR MODELS WHICH NEED PARTIAL METRIC SPECIFICATIONS ####
 
# this.cfa <- cfa(model=facet_models_mod["Grandiosity"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["Grandiosity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = c("Grandiosity=~i187"))
# full.config.modelfit[10, 4] - fitmeasures(this.cfa2)["cfi.scaled"]
partial.metric[[10]] <- "Grandiosity=~i187"


# this.cfa <- cfa(model=facet_models_mod["Hostility"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["Hostility"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = c("Hostility=~i170"))
# full.config.modelfit[11, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#no partial inv
partial.metric[[11]] <- "Hostility=~i170"


# this.cfa <- cfa(model=facet_models_mod["IntimacyAvoidance"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["IntimacyAvoidance"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = "IntimacyAvoidance=~i120")
# full.config.modelfit[13, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv. 2 items high in males adolescent
partial.metric[13] <-  "IntimacyAvoidance=~i120"


# this.cfa <- cfa(model=facet_models_mod["Manipulativeness"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["Manipulativeness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = "Manipulativeness=~i219")
# full.config.modelfit[15, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv. 2 items high in males adolescent
partial.metric[15] <-  "Manipulativeness=~i219"


# 
# this.cfa <- cfa(model=facet_models_mod["RestrictedAffectivity"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["RestrictedAffectivity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = "RestrictedAffectivity=~i091")
# full.config.modelfit[18, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.metric[18] <- "RestrictedAffectivity=~i091"


# this.cfa <- cfa(model=facet_models_mod["RiskTaking"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["RiskTaking"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = "RiskTaking=~i067")
# full.config.modelfit[20, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.metric[20] <- "RiskTaking=~i067"



# this.cfa <- cfa(model=facet_models_mod["UnusualBeliefs"][[1]], data, estimator="MLR", group="group")
# metric_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["UnusualBeliefs"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),group.partial = "UnusualBeliefs=~i139")
# full.config.modelfit[24, 4] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.metric[24] <- "UnusualBeliefs=~i139"

###### END OF MANUAL SEARCH ####


# partial metric model fit

partial.metric.modelfit <- data.frame(matrix(nrow=25, ncol=6))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"), group.partial=partial.metric[i][[1]])
  partial.metric.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  partial.metric.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(partial.metric.modelfit) <- names(facet_models_mod)
colnames(partial.metric.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")



mi$partial.metric <- full.config.modelfit$CFI - partial.metric.modelfit$CFI
#save(partial.metric.modelfit, file = here::here("objects/partial metric model fit.Rdata"))

#save(partial.metric, file=here::here("objects/partial metric params.Rdata"))
