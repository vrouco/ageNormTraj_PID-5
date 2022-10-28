#In this script we test facet unidimensionality for the PID-5-100 facets. 
#Correlated Residuals are also explored in this script. CR search will be commented out.

#packages & dependencies
library(lavaan)
library(here)

source(here::here("data/data input.R"))
source(here::here("tools/models.R"))

##### #####

#### First chunk of models. estimator = MLR, no groups, no CRs

initial.config.modelfit <- data.frame(matrix(nrow=25, ncol=3))

for(i in 1:25){
  full <- cfa(model=facet_models_r[i][[1]], data, estimator="MLR")
  initial.config.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  initial.config.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)}

rownames(initial.config.modelfit) <- names(facet_models_r)
colnames(initial.config.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")

initial.config.modelfit <- initial.config.modelfit[my.order.facets, ]
#####

##### Derive models with mod.indices

#initial model specification list, equal to first chunk of models
facet_models_mod <- facet_models_r

##### MANUAL SEARCH AND DERIVATION ####

# In each model, search for large mispecifications. If any, implement and record on facet_models_mod list
# 
# myfit <- cfa(model=facet_models_r[1][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
# 
# myfit <- cfa(model=facet_models_r[2][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# facet_models_mod[2][[1]]<-"Anxiousness =~ i079 + i109 + i130 + i174
# i079 ~~ i109"
# myfit <- cfa(model=facet_models_mod[2][[1]], data, estimator="MLR", group="group")
# summary(myfit, fit.measures=T)
# 
# myfit <- cfa(model=facet_models_r[3][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# 
# myfit <- cfa(model=facet_models_r[4][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# myfit <- cfa(model=facet_models_r[5][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# myfit <- cfa(model=facet_models_r[6][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# facet_models_mod[6][[1]]<-"Depressivity =~  i081 + i151 + i163 + i169
# i151 ~~ i163"
#myfit <- cfa(model=facet_models_mod[6][[1]], data, estimator="MLR")
#summary(myfit, fit.measures=T)
#fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# myfit <- cfa(model=facet_models_r[7][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]
# # 
# myfit <- cfa(model=facet_models_r[8][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# facet_models_mod[8][[1]]<-"Eccentricity =~  i025 + i070 + i152 + i205
# i152 ~~ i205"
#myfit <- cfa(model=facet_models_mod[8][[1]], data, estimator="MLR")
#fitmeasures(myfit)[c("cfi", "rmsea")]

myfit <- cfa(model=facet_models_r[9][[1]], data, estimator="MLR")
modindices(myfit, power = T, sort. =T)
facet_models_mod[9][[1]]<-"EmotionalLability =~ i122 + i138 + i165 + i181
i138 ~~ i181"                  # The 9th model will be modified as it is here.
myfit <- cfa(model=facet_models_mod[9][[1]], data, estimator="MLR")
#summary(myfit, fit.measures=T, standardized=T)
#fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# myfit <- cfa(model=facet_models_r[10][[1]], data, estimator="MLR")
#  modindices(myfit, power = T, sort. =T)
# facet_models_mod[10][[1]]<-"Grandiosity =~ i040  + i114 + i187 + i197
# i187 ~~ i197"
# myfit <- cfa(model=facet_models_mod[10][[1]], data, estimator="MLR")
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]

# 
# myfit <- cfa(model=facet_models_r[11][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# fitmeasures(myfit)[c("cfi", "rmsea")]
# 
# myfit <- cfa(model=facet_models_r[12][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)


myfit <- cfa(model=facet_models_r[13][[1]], data, estimator="MLR")
modindices(myfit, power = T, sort. =T)
facet_models_mod[13][[1]]<-"IntimacyAvoidance =~ i089 + i120 + i145 + i203
i089 ~~ i203"
myfit <- cfa(model=facet_models_mod[13][[1]], data, estimator="MLR")
summary(myfit, standardized=T, fit.measures=T)

# 
# myfit <- cfa(model=facet_models_r[14][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# lavaan::residuals(myfit, type="cor.bollen")
# #facet_models_mod[14][[1]]<-"Irresponsibility =~ i129 + i156 + i160 + i171
# #i129 ~~ i160"
# myfit <- cfa(model=facet_models_mod[14][[1]], data, estimator="MLR")
# summary(myfit, fit.measures=T)


# 
#  myfit <- cfa(model=facet_models_r[15][[1]], data, estimator="MLR")
#  modindices(myfit, power = T, sort. =T)
# #  facet_models_mod[15][[1]]<-"Manipulativeness =~ i107 + i125 + i162 + i219
# # i107 ~~ i162"
# # myfit <- cfa(model=facet_models_mod[15][[1]], data, estimator="MLR")
# # summary(myfit, fit.measures=T)
# 
# 
#  myfit <- cfa(model=facet_models_r[16][[1]], data, estimator="MLR")
#  modindices(myfit, power = T, sort. =T)
# # facet_models_mod[16][[1]]<-"PerceptualDysregulation =~  i044 + i154 + i192 + i217
# i154 ~~ i192"
# myfit <- cfa(model=facet_models_mod[16][[1]], data, estimator="MLR")
# summary(myfit, fit.measures=T)


# 
# myfit <- cfa(model=facet_models_r[17][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
# 
# myfit <- cfa(model=facet_models_r[18][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# # facet_models_mod[18][[1]]<-"RestrictedAffectivity =~ i084 + i091 + i167 + i184
# # i091 ~~ i167"
# myfit <- cfa(model=facet_models_mod[18][[1]], data, estimator="MLR")
# summary(myfit, standardized=T)
# 
# myfit <- cfa(model=facet_models_r[19][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
# myfit <- cfa(model=facet_models_r[20][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
myfit <- cfa(model=facet_models_r[21][[1]], data, estimator="MLR")
modindices(myfit, power = T, sort. =T)
facet_models_mod[21][[1]]<-"SeparationInsecurity =~ i050 + i127 + i149 + i175
i149 ~~ i175"
# myfit <- cfa(model=facet_models_mod[21][[1]], data, estimator="MLR")
# summary(myfit, standardized=T)
# 
# 
# myfit <- cfa(model=facet_models_r[22][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# #facet_models_mod[22][[1]]<-"Submissiveness =~ i009 + i015 + i063 + i202
# #i009 ~~ i015"
# myfit <- cfa(model=facet_models_mod[22][[1]], data, estimator="MLR")
# summary(myfit, fit.measures=T)
# 
# 
# myfit <- cfa(model=facet_models_r[23][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
# 
# myfit <- cfa(model=facet_models_r[24][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)
# 
# 
# myfit <- cfa(model=facet_models_r[25][[1]], data, estimator="MLR")
# modindices(myfit, power = T, sort. =T)
# summary(myfit, fit.measures=T)

##### END OF MANUAL DERIVATION ####
# 3 models were modified

# final unidimensionality results. We construct Table 1 with this information

derived.config.modelfit <- data.frame(matrix(nrow=25, ncol=3))

for(i in 1:25){
  full <- cfa(model=facet_models_mod[i][[1]], data,estimator="MLR")
  derived.config.modelfit[i,1:6]<- round(fitMeasures(full)[c("chisq.scaled", "df.scaled","pvalue.scaled","cfi.scaled", "rmsea.scaled", "srmr")], 3)
  cr <- lavaan::residuals(full, type="cor.bollen")
  derived.config.modelfit$highest.cr[i]<- round(max(abs(as.numeric(unlist(cr)[grep("cov", names(unlist(cr)))]))), 3)
  }

rownames(derived.config.modelfit) <- names(facet_models_r)
colnames(derived.config.modelfit)[1:6] <- c("CHISQ", "DF", "PVAL", "CFI", "RMSEA", "SRMR")

 
derived.initial.config.modelfit <- derived.config.modelfit[my.order.facets, ]

table1 <- derived.initial.config.modelfit

table1[,1]<-  paste0(table1$CHISQ, "(", table1$DF, ")")

table1 <- table1[,c(-2,-5,-7)]

write.csv(table1,file=here::here("tables/tableS2_unidimensionality.csv"))


#save(facet_models_mod, file=here::here("objects/facet_models_mod.Rdata"))
