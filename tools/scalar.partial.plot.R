
scalar_partial_plot <- function(this.cfa=this.cfa){

fl <- inspect(this.cfa, "est")
estimates <- data.frame(matrix(nrow=4, ncol=1))
for(i in 1:6){
  estimates <- cbind(estimates, fl[i][[1]]$nu)
}
estimates <- estimates[,-1]
colnames(estimates)<- names(fl)
estimates <- estimates[,c(1,4,5,2,3,6)]
estimates$item <- rownames(estimates)


fl.se <- inspect(this.cfa, "se")
ses <- data.frame(matrix(nrow=4, ncol=1))
for(i in 1:6){
  ses <- cbind(ses, fl.se[i][[1]]$nu)
}
ses <- ses[,-1]
colnames(ses)<- names(fl)
ses <- ses[,c(1,4,5,2,3,6)]
ses$item <- rownames(ses)

estimates <- pivot_longer(estimates, cols=1:6)
estimates$name <- as.factor(estimates$name )
estimates$name <- levels(estimates$name)[c(3,1,2,6,4,5)]



ses <- pivot_longer(ses, cols=1:6)

estimates$se <- ses$value
estimates$name <- as.factor(estimates$name)

estimates$name <- factor(estimates$name, levels = c("female.younger adult", "female.mid adult", "female.older adult",
                                               "male.younger adult", "male.mid adult", "male.older adult"))

plot <- ggplot(data=estimates, aes(x=item, y=value, 
                                   fill=name))+
  geom_bar(stat="identity", color="black", position=position_dodge())+
  geom_errorbar( aes(x=item, ymin=value-1.96*se, ymax=value+1.96*se), position=position_dodge(),stat="identity")+
  ggtitle(colnames(unclass(inspect(this.cfa)[1][[1]]$psi)))+
  scale_fill_manual(values=c("gold2", "gold3", "gold4", "steelblue2", "steelblue3", "steelblue4"))




return(plot)}

