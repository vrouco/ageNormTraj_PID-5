
##Packages (& built-in functions) & dependencies

library(lavaan)
library(here)



load(here::here("tools/facet_models_mod.Rdata"))
source(here::here("data/data input.R"))
load(here::here("objects/partial metric params.Rdata"))
load(here::here("objects/partial scalar params.Rdata"))
load(here::here("objects/partial scalar model fit.Rdata"))
load(here::here("objects/mi object.Rdata"))

##### theta params of facets out of completely pooled model ####

c.data <- data[complete.cases(data),]#for lavPredict. take only complete cases.

c.data <- data.frame(age = c.data$age, gender = c.data$gender)

for(i in 1:25){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR"#, group="group", #mod models can include some correlated residual
                 # group.equal=c("residual.covariances")
                 )#no group model. completely pooled

  
  theta <- lavPredict(fitted,
                      data[complete.cases(data),], type="lv", assemble = T)
  c.data[,2+i]<-theta[,1]
  names(c.data)[2+i]<-names(facet_models_mod)[i]
}

pooled.data <- c.data

#### theta parameters of facets out of meas. invariant models ####
c.data <- data[complete.cases(data),]#for lavPredict. take only complete cases.

c.data <- data.frame(age = c.data$age, gender = c.data$gender)


for(i in 1:25){
  if(mi$level[i]=="scalar" | mi$level[i]=="partial.scalar"){#if the facet is scalar invariant apply equal intercepts
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group",
                  group.equal=c("loadings", "residual.covariances", "intercepts"),
                  group.partial=c(partial.metric[i][[1]], partial.scalar[i][[1]]))#include non-invariant params
  }else if(mi$level[i]=="metric" | mi$level[i]=="partial.metric"){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group",
                  group.equal=c("loadings", "residual.covariances"),
                  group.partial=c(partial.metric[i][[1]]))
  }else if(mi$level[i]=="configural"){
    fitted <- cfa(model=facet_models_mod[i][[1]], data, estimator="MLR", group="group",
                  group.equal=c("residual.covariances"))#configural is actually corr.residuals invariant
  }

  theta <- lavPredict(fitted,
                      data[complete.cases(data),], type="lv", assemble = T)
  c.data[,2+i]<-theta[,1]
  names(c.data)[2+i]<-names(theta)[1]
}

invariant.data <- c.data

################# DATA FOR LINEAR MODELS #####################


age.dev <- data.frame(facet = rep(my.order.facets, each=2),
                      group = rep(c("males", "females"), 25),
                      bage = NA,
                      page = NA,
                      bage.2 =NA,
                      page.2 = NA,
                      r2 = NA)

c.data$ageM<-c.data$age-min(c.data$age,na.rm = T)
c.data$ageM <- c.data$ageM/10
males <- c.data[c.data$gender=="male", ]
females <- c.data[c.data$gender=="female", ]
males <- males[,c("age","gender",my.order.facets, "ageM")]
females <- females[,c("age","gender",my.order.facets, "ageM")]
males.index <- seq(1, 50, 2)
females.index <- seq(2, 50, 2)


##### FIT MODELS #####

for(i in 1:25){
fit.male <- lm(males[,2+i]~males$ageM + I(males$ageM^2))
fit.female <- lm(females[,2+i]~females$ageM + I(females$ageM^2))
age.dev[males.index[i],3]<-round(summary(fit.male)$coefficients[2,1], 3)
age.dev[males.index[i],4]<-round(summary(fit.male)$coefficients[2,4], 3)
age.dev[males.index[i],5]<-round(summary(fit.male)$coefficients[3,1], 3)
age.dev[males.index[i],6]<-round(summary(fit.male)$coefficients[3,4], 5)
age.dev[males.index[i],7]<-round(summary(fit.male)$r.squared, 3)

age.dev[females.index[i],3]<-round(summary(fit.female)$coefficients[2,1], 3)
age.dev[females.index[i],4]<-round(summary(fit.female)$coefficients[2,4], 3)
age.dev[females.index[i],5]<-round(summary(fit.female)$coefficients[3,1], 5)
age.dev[females.index[i],6]<-round(summary(fit.female)$coefficients[3,4], 3)
age.dev[females.index[i],7]<-round(summary(fit.female)$r.squared, 3)

}



#### if quadratic is non sig, do not fit ####
for(i in 1:25){
  fit.male <- lm(males[,2+i]~males$ageM + I(males$ageM^2))
  if(summary(fit.male)$coefficients[3,4] > 0.05){
    fit.male <- lm(males[,2+i]~males$ageM)
  }
  fit.female <- lm(females[,2+i]~females$ageM + I(females$ageM^2))
  if(summary(fit.female)$coefficients[3,4] > 0.05){
    fit.female <- lm(females[,2+i]~females$ageM)
  }
  
  age.dev[males.index[i],3]<-round(summary(fit.male)$coefficients[2,1], 3)
  age.dev[males.index[i],4]<-round(summary(fit.male)$coefficients[2,4], 3)
  if(dim(summary(fit.male)$coefficients)[1]==3){
    age.dev[males.index[i],5]<-round(summary(fit.male)$coefficients[3,1], 3)
    age.dev[males.index[i],6]<-round(summary(fit.male)$coefficients[3,4], 5)
  } else {
    age.dev[males.index[i],5]<-NA
    age.dev[males.index[i],6]<-NA
  }
  age.dev[males.index[i],7]<-round(summary(fit.male)$r.squared, 3)
  
  age.dev[females.index[i],3]<-round(summary(fit.female)$coefficients[2,1], 3)
  age.dev[females.index[i],4]<-round(summary(fit.female)$coefficients[2,4], 3)
  if(dim(summary(fit.female)$coefficients)[1]==3){
    age.dev[females.index[i],5]<-round(summary(fit.female)$coefficients[3,1], 3)
    age.dev[females.index[i],6]<-round(summary(fit.female)$coefficients[3,4], 5)
  } else {
    age.dev[females.index[i],5]<-NA
    age.dev[females.index[i],6]<-NA
  }
  age.dev[females.index[i],7]<-round(summary(fit.female)$r.squared, 3)
  
}



#write.csv(age.dev, here::here("tables/Table1.csv"))


#### Test gender differences #########

mydata <- c.data[,c("age","gender",my.order.facets)]
gender.diff <- data.frame(matrix(ncol=2, nrow=length(my.order.facets)))
gender.diff[,1]<-my.order.facets
colnames(gender.diff)<-c("facet", "gender_differences")

for(i in 1:length(my.order.facets)){
fit0 <- lm(mydata[,2+i] ~ mydata$age)
fit1 <- lm(mydata[,2+i] ~ mydata$age + I(mydata$age^2))
if(anova(fit0, fit1)$`Pr(>F)`[2] > 0.05){
  fit1 <- lm(mydata[,2+i] ~ mydata$age)
  fit2 <- lm(mydata[,2+i] ~ mydata$age + mydata$gender)
} else{
fit2 <- lm(mydata[,2+i] ~ mydata$age + I(mydata$age^2) + mydata$gender)}
gender.diff[i,2] <- anova(fit1, fit2)$`Pr(>F)`[2] < 0.05
}



################# MAKE BIG PLOT #################

abbrev.facets <- c("EMLAB", "ANXIOU", "RESTAFF", "SEPINSEC", "HOST","PERSEV","SUBM",
                   "WITHDR","ANHED","DEPRES","INTAVOID","SUSP",
                   "MANIP","DECEIT","GRAND","ATTSEEK","CALLO",
                   "IRRESP","IMPU","RIGPERF","DISTRA","RISKTAK",
                   "UNBELIEF","ECCEN","PERCEPDYSR")

full.facets <- c("Emotional Lability*","Anxiousness*","Restricted Affectivity*" ,
                  "Separation Insecurity*","Hostility" , "Perseveration" ,
                  "Submissiveness*",
                  "Withdrawal*","Anhedonia","Depressivity" ,"Intimacy Avoidance*","Suspiciousness",
                  "Manipulativeness*","Deceitfulness*","Grandiosity*","Attention Seeking*","Callousness",
                  "Irresponsibility*","Impulsivity","Rigid Perfectionism" ,"Distractibility", "Risk Taking*", 
                  "Unusual Beliefs*","Eccentricity*","Perceptual Dysregulation")

c.data <- c.data[,c("age", "gender", my.order.facets, "ageM")]



c.data$gender <- factor(c.data$gender, levels = c("female", "male"))



facet.plot <- function(i=i, grey=F){
  
  this.plot <- 
    ggplot(c.data, aes(age, c.data[,2+i], fill=gender)) +
    
    {if(is.na(age.dev[age.dev$facet==colnames(c.data)[2+i] & age.dev$group == "males","bage.2"]))
    stat_smooth(data=subset(c.data,gender=="male"),
                aes(c.data$age[c.data$gender=="male"], c.data[c.data$gender=="male",2+i], colour=gender),
      geom="line",method = "lm", size = 1, se=T) }+
    {if(!is.na(age.dev[age.dev$facet==colnames(c.data)[2+i] & age.dev$group == "males","bage.2"]))
      stat_smooth(data=subset(c.data,gender=="male"),
                  aes(c.data$age[c.data$gender=="male"], c.data[c.data$gender=="male",2+i], colour=gender),
                  geom="line",method = "lm", formula = y ~ x + I(x^2), size = 1, se=T) 
        }  +
    
    
    {if(is.na(age.dev[age.dev$facet==colnames(c.data)[2+i] & age.dev$group == "females","bage.2"]))
      stat_smooth(data=subset(c.data,gender=="female"),
                  aes(c.data$age[c.data$gender=="female"], c.data[c.data$gender=="female",2+i], colour=gender),
                  geom="line",method = "lm", size = 1, se=T) }+
    {if(!is.na(age.dev[age.dev$facet==colnames(c.data)[2+i] & age.dev$group == "females","bage.2"]))
      stat_smooth(data=subset(c.data,gender=="female"),
                  aes(c.data$age[c.data$gender=="female"], c.data[c.data$gender=="female",2+i], colour=gender),
                  geom="line",method = "lm", formula = y ~ x + I(x^2), size = 1, se=T) 
    }  +
  
    #stat_smooth(method="gam", formula = y ~s(x) + s(I(x^2)), span=100, se=T)+
    #scale_y_continuous(limits=c(-0.5,0.5), name= element_blank())+
    #scale_x_continuous(breaks = seq(15, 90, 5), limits=c(12,90))+
    coord_cartesian(xlim=c(20,65), ylim=c(-0.8, 0.8))+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5, size=10,margin=unit(c(+0.1,0.1,0,0), "cm")))+
    theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.ticks.length=unit(+0.05, "cm"),
          axis.text.y = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=7),
          axis.text.x = element_text(margin=unit(c(+0.1,0.1,0.1,0.1), "cm"), size=7),
          legend.position = "none",
          plot.margin = unit(c(0,0,0,0), "cm"),
          panel.background = element_rect(fill="#fffaee"),
          aspect.ratio=0.75)+
    ggtitle(full.facets[i])
  if(grey==T){
    this.plot <- this.plot + theme(plot.background = element_rect(fill = "#FAFAFA", colour = NA))
  }
  
  return(this.plot)
}



library(gridExtra)
library(grid)
library(cowplot)
library(ggplot2)

neg_aff_trends <- plot_grid(facet.plot(1, grey=T), facet.plot(2, grey=T), facet.plot(3, grey=T),
                            facet.plot(4, grey=T), facet.plot(5, grey=T), facet.plot(6, grey=T),
                            facet.plot(7, grey=T),
                            nrow = 3, ncol=3)


neg_aff_trends <- cowplot::ggdraw(neg_aff_trends) + 
  theme(plot.background = element_rect(fill="#FAFAFA", colour=NA),plot.margin = unit(c(0,0,0,0), "cm"))


neg_aff_text <- grobTree( rectGrob(gp=gpar(fill="#FAFAFA", col=NA)), 
                          textGrob("Negative \nAffectivity",
                                   gp = gpar(fontsize = 12, fontface = 'bold', col="black")))

##


detach_trends <- plot_grid(facet.plot(8),facet.plot(9),facet.plot(10),
                           facet.plot(11),facet.plot(12),align = "v", nrow = 2, ncol=3)


detach_trends <- cowplot::ggdraw(detach_trends) + 
  theme(plot.background = element_rect(fill="white", color = NA))

detach_text <- textGrob("Detachment",
                        gp = gpar(fontsize = 12, fontface = 'bold'))


detach_text <- grobTree( rectGrob(gp=gpar(fill="white", col=NA)), 
                         textGrob("Detachment",
                                  gp = gpar(fontsize = 12, fontface = 'bold', col="black")))



antag_trends <- plot_grid(facet.plot(13, grey=T), facet.plot(14, grey=T), facet.plot(15, grey=T),
                          facet.plot(16, grey=T), facet.plot(17, grey=T),
                          align = "v", nrow = 2, ncol=3)

antag_trends <- cowplot::ggdraw(antag_trends) + 
  theme(plot.background = element_rect(fill="#FAFAFA", color = NA))



antag_text <- grobTree( rectGrob(gp=gpar(fill="#FAFAFA", col="#FAFAFA")), 
                        textGrob("Antagonism",
                                 gp = gpar(fontsize = 12, fontface = 'bold')))




dish_trends <- plot_grid(facet.plot(18), facet.plot(19), facet.plot(20),
                         facet.plot(21), facet.plot(22),
                         align = "v", nrow = 2, ncol=3)

dish_trends <- cowplot::ggdraw(dish_trends) + 
  theme(plot.background = element_rect(fill="white", color = NA))



dish_text <- textGrob("Disinhibition",
                      gp = gpar(fontsize = 12, fontface = 'bold'))


dish_text <- grobTree( rectGrob(gp=gpar(fill="white", col=NA)), 
                       textGrob("Disinhibition",
                                gp = gpar(fontsize = 12, fontface = 'bold', col="black")))


psych_trends <- plot_grid(facet.plot(23, grey=T),facet.plot(24, grey=T),facet.plot(25, grey=T), align = "v", nrow = 1, ncol=3)


psych_trends <- cowplot::ggdraw(psych_trends) + 
  theme(plot.background = element_rect(fill="#FAFAFA", color = NA))



psych_text <- grobTree( rectGrob(gp=gpar(fill="#FAFAFA", col="#FAFAFA")), 
                        textGrob("Psychoticism",
                                 gp = gpar(fontsize = 12, fontface = 'bold')))


trends <- 
  plot_grid(neg_aff_trends, detach_trends, antag_trends, dish_trends, 
            psych_trends,
            nrow=5,ncol=1,
            rel_heights = c(3/10, 2/10, 2/10, 2/10, 1/10))

texts <- 
  plot_grid(neg_aff_text, detach_text, antag_text, dish_text, psych_text, 
            nrow=5,ncol=1,
            rel_heights = c(3/10, 2/10, 2/10, 2/10, 1/10))

full.plot <- plot_grid(texts, trends, ncol=2, nrow=1, rel_widths = c(2/8, 6/8))


ggsave(filename = here::here("plots/all facets dev trajectories.png"),
       cowplot::ggdraw(full.plot) +
         theme(panel.border = element_rect(colour = "black", fill=NA, size=1)),
       dpi=700,
       width=7.5, height = 16)

#one plot per domain

neg_aff_trends <- plot_grid(facet.plot(1), facet.plot(2), facet.plot(3),
                            facet.plot(4), facet.plot(5), facet.plot(6),
                            facet.plot(7),
                            nrow = 3, ncol=3)+ 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))


neg_aff_title <- ggdraw() + 
                  draw_label("Negative Affectivity",
                  fontface = 'bold', x = 0.5,hjust = 0.5) +
                  theme(plot.margin = margin(0, 0, 0, 7),
                        plot.background = element_rect(fill="white", colour="white"))


ggsave(filename = here::here("plots/NegAff dev trajectories.png"),
       plot_grid(neg_aff_title, neg_aff_trends,
                 ncol = 1,
                 rel_heights = c(0.1, 1)),
       dpi=700,
       width=7.5, height = 7)

##

detach_trends <- plot_grid(facet.plot(8),facet.plot(9),facet.plot(10),
                           facet.plot(11),facet.plot(12),align = "v", nrow = 2, ncol=3) + 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))


detach_title <- ggdraw() + 
  draw_label("Detachment",
             fontface = 'bold', x = 0.5,hjust = 0.5) +
  theme(plot.margin = margin(0, 0, 0, 7),
        plot.background = element_rect(fill="white", colour="white"))


ggsave(filename = here::here("plots/Detach dev trajectories.png"),
       plot_grid(detach_title, detach_trends,
                 ncol = 1,
                 rel_heights = c(0.1, 1)),
       dpi=700,
       width=7.5, height = 4.5)


##



antag_trends <- plot_grid(facet.plot(13), facet.plot(14), facet.plot(15),
                          facet.plot(16), facet.plot(17),
                          align = "v", nrow = 2, ncol=3) + 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))


antag_title <- ggdraw() + 
  draw_label("Antagonism",
             fontface = 'bold', x = 0.5,hjust = 0.5) +
  theme(plot.margin = margin(0, 0, 0, 7),
        plot.background = element_rect(fill="white", colour="white"))


ggsave(filename = here::here("plots/Antag dev trajectories.png"),
       plot_grid(antag_title, antag_trends,
                 ncol = 1,
                 rel_heights = c(0.1, 1)),
       dpi=700,
       width=7.5, height = 4.5)


##

dish_trends <- plot_grid(facet.plot(18), facet.plot(19), facet.plot(20),
                         facet.plot(21), facet.plot(22),
                         align = "v", nrow = 2, ncol=3) + 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))


dish_title <- ggdraw() + 
  draw_label("Disinhibition",
             fontface = 'bold', x = 0.5,hjust = 0.5) +
  theme(plot.margin = margin(0, 0, 0, 7),
        plot.background = element_rect(fill="white", colour="white"))


ggsave(filename = here::here("plots/Disinh dev trajectories.png"),
       plot_grid(dish_title, dish_trends,
                 ncol = 1,
                 rel_heights = c(0.1, 1)),
       dpi=700,
       width=7.5, height = 4.5)

##

psych_trends <- plot_grid(facet.plot(23),facet.plot(24),facet.plot(25), 
                          align = "v", nrow = 1, ncol=3)+ 
  theme(plot.background = element_rect(fill="white", colour=NA),plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.3))


psych_title <- ggdraw() + 
  draw_label("Psychoticism",
             fontface = 'bold', x = 0.5,hjust = 0.5) +
  theme(plot.margin = margin(0, 0, 0, 7),
        plot.background = element_rect(fill="white", colour="white"))


ggsave(filename = here::here("plots/Psych dev trajectories.png"),
       plot_grid(psych_title, psych_trends,
                 ncol = 1,
                 rel_heights = c(0.1, 1)),
       dpi=700,
       width=7.5, height = 3)

