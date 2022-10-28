
gof_loop <- function(x,methodFactor=F,include.fl=F,corr.resid =F,group=NULL, data=data, ...){

  library(lavaan)
  gof <- as.data.frame(matrix(ncol=6))
  for(i in 1:length(x)){
    
    if(methodFactor==F){
      this <- cfa(x[i][[1]], data=data, group=group, ...)}else{
        this <- cfa(paste(x[i][[1]],method_f(x[i][[1]]), sep="\n"), data=data,group=group, ...)
        }
    gof[i,1:6] <- round(fitMeasures(this)[c("chisq", "df", "pvalue", "rmsea", "cfi", "srmr")], 3)
    if(include.fl==T){
      fl <- lavaan::inspect(this, what="standardized")$lambda
      gof$mean.fl[i] <- round(mean(fl), 3)
      gof$low.fl[i] <- round(min(fl), 3)
      gof$high.fl[i] <- round(max(fl), 3)
    }
    if(corr.resid==T){
      if(is.null(group)){
      resid <- abs(residuals(this, type = "cor")$cov)
      gof$res.mean[i] <- round(mean(resid[lower.tri(resid)]), 3)
      gof$res.sd[i] <- round(sd(resid[lower.tri(resid)]), 3)
      gof$res.max[i] <- round(max(resid[lower.tri(resid)]), 3)
    }
      if(!is.null(group)){
      resid <- residuals(this, type = "cor")
      no_groups <- length(resid)
      res.group <- list()
      for(j in 1:no_groups){
        res.group[j][[1]]<-abs(resid[j][[1]]$cov)[lower.tri(abs(resid[j][[1]]$cov))]
      }
      res.group <- unlist(res.group)
      gof$res.mean[i] <- round(mean(res.group), 3)
      gof$res.sd[i] <- round(sd(res.group), 3)
      gof$res.max[i] <- round(max(res.group), 3)
    }
    }
  }
  names(gof)[1:6] <- c("chisq", "df", "pvalue", "rmsea", "cfi", "srmr")
  rownames(gof)<- names(unlist(x))
  return(gof)
  
}


method_f <- function(x){
  line<- paste("acquiescence =~ ",
               paste("1*",grep("i[0-9]", unlist(strsplit(x=unlist(strsplit(x, split=c("\n"))), split=" ")),value=T), sep="", collapse=" + "),
               sep="")
  return(line)
}
