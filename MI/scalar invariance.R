
##Packages (& built-in functions) & dependencies

library(lavaan)
source(here::here("tools/scalar.partial.plot.R"))



load(here::here("objects/facet_models_mod.Rdata"))
source(here::here("data/data input.R"))
source(here::here("MI/configural invariance.R"))
source(here::here("MI/metric invariance.R"))


###scalar invariance

full.scalar.modelfit <- data.frame(matrix(nrow=25, ncol=6))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"), group.partial=partial.metric[i][[1]])
  full.scalar.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  full.scalar.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(full.scalar.modelfit) <- names(facet_models_mod)
colnames(full.scalar.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")

mi$scalar <- partial.metric.modelfit$CFI - full.scalar.modelfit$CFI


#partial.scalar

partial.scalar <- vector(mode = "list", length = 25)
names(partial.scalar) <- rownames(mi)

#### MANUAL SEARCH FOR MODELS WHICH NEED PARTIAL METRIC SPECIFICATIONS ####

#Anxiousness
 # this.cfa <- cfa(model=facet_models_mod["Anxiousness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
 #                 group.partial=partial.metric["Anxiousness"][[1]])
 # scalar_partial_plot(this.cfa)
 # this.cfa2 <- cfa(model=facet_models_mod["Anxiousness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
 #                  group.partial=c(partial.metric["Anxiousness"][[1]], "i130~1"))
 # 
 # fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
 partial.scalar["Anxiousness"] <- "i130~1"

#AttentionSeeking
# this.cfa <- cfa(model=facet_models_mod["AttentionSeeking"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["AttentionSeeking"][[1]])
# scalar_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["AttentionSeeking"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["AttentionSeeking"][[1]], "i191~1"))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar["AttentionSeeking"] <- "i191~1"



#Depressivity
# this.cfa <- cfa(model=facet_models_mod["Depressivity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["Depressivity"][[1]])
# scalar_partial_plot(this.cfa)
# this.cfa2 <- cfa(model=facet_models_mod["Depressivity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["Depressivity"][[1]], c("i081~1", "i163~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar[["Depressivity"]][1:2] <- c("i081~1", "i163~1")


#EmotionalLability. very interesting facet
# this.cfa <- cfa(model=facet_models_mod["EmotionalLability"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["EmotionalLability"][[1]])
# scalar_partial_plot(this.cfa)#both gender and age diff
# 
# this.cfa2 <- cfa(model=facet_models_mod["EmotionalLability"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["EmotionalLability"][[1]], c("i122~1", "i165~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#no partial inv
partial.scalar[["EmotionalLability"]][1:2] <- c("i122~1", "i165~1")


#Grandiosity
# this.cfa <- cfa(model=facet_models_mod["Grandiosity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["Grandiosity"][[1]])
# scalar_partial_plot(this.cfa2)#gender diff
# 
# this.cfa2 <- cfa(model=facet_models_mod["Grandiosity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["Grandiosity"][[1]], "i187~1"))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar["Grandiosity"] <- "i187~1"


#IntimacyAvoidance
# this.cfa <- cfa(model=facet_models_mod["IntimacyAvoidance"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["IntimacyAvoidance"][[1]])
# scalar_partial_plot(this.cfa)#u-shaped effect on age
# 
# this.cfa2 <- cfa(model=facet_models_mod["IntimacyAvoidance"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["IntimacyAvoidance"][[1]], c("i120~1", "i145~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar[["IntimacyAvoidance"]][1:2] <- c("i120~1", "i145~1")



#Irresponsibility
#  this.cfa <- cfa(model=facet_models_mod["Irresponsibility"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                  group.partial=partial.metric["Irresponsibility"][[1]])
#  fitMeasures(this.cfa)
# # scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# # 
#  this.cfa2 <- cfa(model=facet_models_mod["Irresponsibility"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                   group.partial=c(partial.metric["Irresponsibility"][[1]], c("i160~1", "i156~1")))
# # 
#  fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
 partial.scalar[["Irresponsibility"]][1:2] <- c("i160~1", "i156~1")


#Manipulativeness
# this.cfa <- cfa(model=facet_models_mod["Manipulativeness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["Manipulativeness"][[1]])
# scalar_partial_plot(this.cfa)#
# 
# this.cfa2 <- cfa(model=facet_models_mod["Manipulativeness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["Manipulativeness"][[1]], c("i107~1", "i125~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar[["Manipulativeness"]][1:2] <- c("i107~1", "i125~1")


#PerceptualDysregulation
# this.cfa <- cfa(model=facet_models_mod["PerceptualDysregulation"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["PerceptualDysregulation"][[1]])
# scalar_partial_plot(this.cfa)#
# this.cfa2 <- cfa(model=facet_models_mod["PerceptualDysregulation"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["PerceptualDysregulation"][[1]], "i192~1"))
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar[["PerceptualDysregulation"]][1:2] <- "i192~1"


#RestrictedAffectivity
# this.cfa <- cfa(model=facet_models_mod["RestrictedAffectivity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["RestrictedAffectivity"][[1]])
# scalar_partial_plot(this.cfa)#
# 
# this.cfa2 <- cfa(model=facet_models_mod["RestrictedAffectivity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["RestrictedAffectivity"][[1]], c("i167~1", "i084~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar[["RestrictedAffectivity"]][1:2] <- c("i167~1", "i084~1")


#RigidPerfectionism
# this.cfa <- cfa(model=facet_models_mod["RigidPerfectionism"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["RigidPerfectionism"][[1]])
# scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# 
# this.cfa2 <- cfa(model=facet_models_mod["RigidPerfectionism"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["RigidPerfectionism"][[1]], c("i196~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar["RigidPerfectionism"] <- "i196~1"



#SeparationInsecurity
# this.cfa <- cfa(model=facet_models_mod["SeparationInsecurity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["SeparationInsecurity"][[1]])
# scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# 
# this.cfa2 <- cfa(model=facet_models_mod["SeparationInsecurity"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["SeparationInsecurity"][[1]], c("i127~1", "i149~1")))
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
#no partial inv


#Suspiciousness
# this.cfa <- cfa(model=facet_models_mod["Suspiciousness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["Suspiciousness"][[1]])
# scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# 
# this.cfa2 <- cfa(model=facet_models_mod["Suspiciousness"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["Suspiciousness"][[1]], c("i117~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar["Suspiciousness"] <- "i117~1"


#UnusualBeliefs
# this.cfa <- cfa(model=facet_models_mod["UnusualBeliefs"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["UnusualBeliefs"][[1]])
# scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# 
# this.cfa2 <- cfa(model=facet_models_mod["UnusualBeliefs"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["UnusualBeliefs"][[1]], c("i106~1", "i150~1")))
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]
partial.scalar[["UnusualBeliefs"]][1:2] <- c("i106~1", "i150~1")

#Withdrawal
# this.cfa <- cfa(model=facet_models_mod["Withdrawal"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances"),
#                 group.partial=partial.metric["Withdrawal"][[1]])
# scalar_partial_plot(this.cfa)#age effects (some u-shapes)
# 
# this.cfa2 <- cfa(model=facet_models_mod["Withdrawal"][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"),
#                  group.partial=c(partial.metric["Withdrawal"][[1]], c("i082~1")))
# 
# fitmeasures(this.cfa)["cfi.scaled"] - fitmeasures(this.cfa2)["cfi.scaled"]#partial inv
partial.scalar["Withdrawal"] <- "i082~1"





###### END OF MANUAL SEARCH ####


partial.scalar.modelfit <- data.frame(matrix(nrow=25, ncol=6))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", group.equal=c("loadings", "residual.covariances", "intercepts"), 
              group.partial=c(partial.metric[i][[1]], partial.scalar[i][[1]]))
  partial.scalar.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  partial.scalar.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(partial.scalar.modelfit) <- names(facet_models_mod)
colnames(partial.scalar.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")



mi$partial.scalar <- partial.metric.modelfit$CFI - partial.scalar.modelfit$CFI
#save(partial.scalar.modelfit, file=here::here("partial scalar model fit.Rdata"))

#save(partial.scalar, file=here::here("partial scalar params.Rdata"))
