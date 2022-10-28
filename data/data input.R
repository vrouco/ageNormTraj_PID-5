#########INIT script

#load packages
library(foreign)
library(here)

#read data

#first data source
data <- read.spss(here::here("data/merged_data_age_gender_PID5_final.sav"), to.data.frame = T, rownames=F, stringsAsFactors=F) 
#N = 2273
#second data source
study2 <- read.spss(here::here("data/stud2011_adoreport_raw_Victor.sav"), to.data.frame = T, rownames=F, stringsAsFactors=F)
#N = 443
 
###### DATA FORMATING ####


age_study2 <- round(as.numeric(difftime(as.Date(trimws(study2$end_time), format = "%d %m %Y"), as.Date(trimws(study2$birth_date), format = "%d-%m-%Y"),
         units="weeks"))/ 52.25, 0) #from weeks to years of age

age_study2[age_study2<10] <-NA  #remove impossible values
age_study2[age_study2>20] <-NA

study2 <- study2[,-5] #remove end_time column
study2[,4]<-study2$sex #set fourth column as age
study2[,2]<-"study2" #set second column as data source
study2[,3]<-age_study2 #set third column as age in years

colnames(study2)[1:4]<-colnames(data)[1:4] #set real column names, equal as data source 1

#collapse both data frames
data <- rbind(data, study2)
#remove non-necessary objects
rm(study2)
rm(age_study2)

#trim ages not belonging to study-target
data <- data[which(data$age>20), ]
data <- data[which(data$age<66), ]

#from N = 2716 to N = 1930

# change gender values

data$gender[data$gender==" V"] <- "female"
data$gender[data$gender==" M"] <- "male"
data$gender <- droplevels(data$gender)

#create age x gender groups
data$ageGroup<-cut(data$age,
                   breaks=c(20,35,50, 66),
                   include.lowest=TRUE,
                   labels=paste(c("younger adult", "mid adult","older adult")))

data$ageGroup <- droplevels(data$ageGroup)
data$group <- interaction(data$gender, data$ageGroup)

data$group <- droplevels(data$group)

##### create dataset for PID-5-100 ####
#change item names, from_pid5_xxx to ixxx
names(data)[5:224] <- sub(pattern = "pid5_","i", names(data)[5:224])

#choose reduced item set, following Maples et al, 2015 ----similar to table S1
pid5_reduced <- as.character(c(
  "079", "109", "130", "174",
  "122", "138", "165", "181",
  "038", "092", "158", "170",
  "060", "080", "100", "128",
  "084", "091", "167", "184",
  "050", "127", "149", "175",
  "009", "015", "063", "202",
  "023", "026", "124", "157",
  "081", "151", "163", "169",
  "089", "120", "145", "203",
  "002", "117", "133", "190",
  "082", "136", "146", "186",
  "025", "070", "152", "205",
  "044", "154", "192", "217",
  "106", "139", "150", "209",
  "074", "173", "191", "211",
  "019", "153", "166", "183",
  "053", "134", "206", "218",
  "040", "114", "187", "197",
  "107", "125", "162", "219",
  "118", "132", "144", "199",
  "004", "016", "017", "022",
  "129", "156", "160", "171",
  "105", "123", "176", "196",
  "039", "048", "067", "159"
))
pid5_reduced <- paste0("i", pid5_reduced)

#create PID-5-100 dataset
data_r <- data[,c(colnames(data)[c(1:4, 226)], pid5_reduced)]







# To follow Krueger's

my.order.facets <- c("EmotionalLability","Anxiousness","RestrictedAffectivity" ,
                     "SeparationInsecurity","Hostility" , "Perseveration" ,
                      "Submissiveness",
              "Withdrawal","Anhedonia","Depressivity" ,"IntimacyAvoidance","Suspiciousness",
              "Manipulativeness","Deceitfulness","Grandiosity","AttentionSeeking","Callousness",
              "Irresponsibility","Impulsivity","RigidPerfectionism" ,"Distractibility", "RiskTaking", 
              "UnusualBeliefs","Eccentricity","PerceptualDysregulation")

####


#### apply list-wise deletion for later collapse with lavaanPredict



#### SOCIODEMOGRAPHIC DESCRIPTIVES ####



#### OUT DATA FILES ####

#data to mplus

#write.table(data[,-1:-2], here::here("data to mplus.txt"), na = "-999", row.names = F, col.names = F)


#data to share




