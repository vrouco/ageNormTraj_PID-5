c.data <- data[complete.cases(data),]

c.data <- data.frame(age = c.data$age, gender = c.data$gender)

for(i in 1:25){
  if(mi$scalar[i]<=0.01){
    mi$level[i] <- "scalar"
  }else if(mi$partial.scalar[i]<=0.01){
    mi$level[i] <- "partial.scalar"
  }else if(mi$metric[i]<=0.01){
    mi$level[i] <- "metric"
  }else if(mi$partial.metric[i]<=0.01){
    mi$level[i] <- "partial.metric"
  }else {
    mi$level[i] <- "configural"
  }
}


var.table <- data.frame(facet = rep(names(facet_models_mod), each=6),
                        gender = rep(c("female","female","female", "male","male","male"), 25),
                        age.group = rep(c("young", "mid", "old"), 50),
                        variance = NA,
                        lower.CI = NA,
                        upper.CI = NA)



for(i in 1:25){
  if(mi$level[i]=="scalar" | mi$level[i]=="partial.scalar"){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", 
                  group.equal=c("loadings", "residual.covariances", "intercepts"), 
                  group.partial=c(partial.metric[i][[1]], partial.scalar[i][[1]]))
  }else if(mi$level[i]=="metric" | mi$level[i]=="partial.metric"){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", 
                  group.equal=c("loadings", "residual.covariances"), 
                  group.partial=c(partial.metric[i][[1]]))
  }else if(mi$level[i]=="configural"){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group", 
                  group.equal=c("residual.covariances"))
  }
  params <- parameterestimates(fitted)
  params <- params[grep(names(facet_models_mod[i]), params$lhs),]
  variances <- params[grep(names(facet_models_mod[i]), params$rhs),]
  means <- params[grep("~1", params$op),]
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="young", "variance"]<-round(variances$est[variances$group == "1"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="young", "lower.CI"]<-round(variances$ci.lower[variances$group == "1"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="young", "upper.CI"]<-round(variances$ci.upper[variances$group == "1"], 2)
  
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="young", "variance"]<-round(variances$est[variances$group == "2"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="young", "lower.CI"]<-round(variances$ci.lower[variances$group == "2"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="young", "upper.CI"]<-round(variances$ci.upper[variances$group == "2"], 2)
  
  
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="mid", "variance"]<-round(variances$est[variances$group == "4"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="mid", "lower.CI"]<-round(variances$ci.lower[variances$group == "4"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="mid", "upper.CI"]<-round(variances$ci.upper[variances$group == "4"], 2)
  
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="mid", "variance"]<-round(variances$est[variances$group == "3"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="mid", "lower.CI"]<-round(variances$ci.lower[variances$group == "3"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="mid", "upper.CI"]<-round(variances$ci.upper[variances$group == "3"], 2)
  
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="old", "variance"]<-round(variances$est[variances$group == "5"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="old", "lower.CI"]<-round(variances$ci.lower[variances$group == "5"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="female" & 
              var.table$age.group=="old", "upper.CI"]<-round(variances$ci.upper[variances$group == "5"], 2)
  
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="old", "variance"]<-round(variances$est[variances$group == "6"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="old", "lower.CI"]<-round(variances$ci.lower[variances$group == "6"], 2)
  
  var.table[var.table$facet==names(facet_models_mod)[i] & 
              var.table$gender=="male" & 
              var.table$age.group=="old", "upper.CI"]<-round(variances$ci.upper[variances$group == "6"], 2)

}

var.table.plot <- var.table

facets <- unique(var.table$facet)

selected.facets <- c("RestrictedAffectivity", "Anhedonia", "Manipulativeness", "Deceitfulness", 
                     "Grandiosity", "Callousness", "RiskTaking", "UnusualBeliefs")

abbrev.facets <- c("RESTAFF", "ANHED",
                   "MANIP","DECEIT","GRAND","CALLO",
                   "RISKTAK",
                   "UNBELIEF")

labels <- c("Restricted Affectivity", "Anhedonia", "Manipulativeness", "Deceitfulness", 
                     "Grandiosity", "Callousness", "Risk Taking", "Unusual Beliefs")

abbrev.key <- data.frame(full = selected.facets, abbrev = abbrev.facets)

var.table.plot <- var.table.plot[which(var.table.plot$facet %in% selected.facets),]
library(tidyverse)

#write.csv(var.table.plot, here::here("tables/Table2.csv"))

#save one by one 

# for(i in 1:length(selected.facets)){
  plotdata <- var.table.plot[var.table.plot$facet==unique(var.table.plot$facet)[i],] 
   
  plotdata$age.group <- fct_relevel(plotdata$age.group, "young", "mid", "old")
  pos <- position_dodge(width = 0.7)
  
    ggplot(plotdata, aes(x=age.group, y=variance, colour = gender)) +
      geom_point(position=pos, size=2)+
      geom_errorbar(aes(ymin=lower.CI, ymax=upper.CI),position=pos, size=0.7)+
      scale_y_continuous(limits=c(0, 0.6), breaks=seq(0,0.6,0.1))+
      scale_x_discrete(name="",labels = c("21-34", "35-49", "50-65")) +
      theme_bw()+
      theme(plot.title = element_text(hjust = 0.5, size=12,margin=unit(c(+0.1,0.1,0.1,0.1), "cm")))+
      theme(axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            axis.ticks.length=unit(+0.05, "cm"),
            axis.text.y = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=10),
            axis.text.x = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=10),
            legend.position = "none",
            plot.margin = unit(c(0,0,0,0), "cm"),
            panel.background = element_rect(fill="#fffaee"),
            aspect.ratio=0.75)+
      ggtitle(abbrev.key$abbrev[abbrev.key$full==plotdata$facet[1]])
  
    
  
#       ggsave(filename = here::here(paste0("plots/variance plot ",i,".png")),
#              dpi=700)
# }

library(cowplot)
    
  
    
plot_maker <- function(i=i){
  plotdata <- var.table.plot[var.table.plot$facet==unique(var.table.plot$facet)[i],] 
  
  plotdata$age.group <- fct_relevel(plotdata$age.group, "young", "mid", "old")
  pos <- position_dodge(width = 0.7)
  
  this.plot <- ggplot(plotdata, aes(x=age.group, y=variance, colour = gender)) +
      geom_point(position=pos, size=2)+
      geom_errorbar(aes(ymin=lower.CI, ymax=upper.CI),position=pos, size=0.7)+
      scale_y_continuous(limits=c(0, 0.6), breaks=seq(0,0.6,0.1))+
      scale_x_discrete(name="",labels = c("21-34", "35-49", "50-65")) +
      theme_bw()+
      theme(plot.title = element_text(hjust = 0.5, size=12,margin=unit(c(+0.1,0.1,0.1,0.1), "cm")))+
      theme(axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            axis.ticks.length=unit(+0.05, "cm"),
            axis.text.y = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=10),
            axis.text.x = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=10),
            legend.position = "none",
            plot.margin = unit(c(0,0,0,0), "cm"),
            panel.background = element_rect(fill="#fffaee"),
            aspect.ratio=0.75)+
      ggtitle(labels[i])
  
  return(this.plot)
}



full.plot <- plot_grid(plot_maker(1), plot_maker(2), plot_maker(3),
            plot_maker(4), plot_maker(5), plot_maker(6),
            plot_maker(7),plot_maker(8),
            nrow = 4, ncol=2)+ 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))

ggsave(filename = here::here("plots/Figure2.png"),
       cowplot::ggdraw(full.plot) +
         theme(panel.border = element_rect(colour = "white", fill=NA, size=1),
               panel.background = element_rect(fill = "white")),
       dpi=700,
       width=7, height = 11.4)

