library(tidyverse)

#Loading the datasets
data(storms)
stor<-storms
head(storms)
str(storms)
view(storms)
summary(storms)
summary(stor$wind)

#get the information about the dataset
?storms

#Data validation
#inspecting first few values
head(storms)
print(head(storms),width=Inf)

#Check for missing values(NA)
anyNA(stor)

#Count for columns with the NA and counting number of NA
colSums(is.na(stor))

boxplot(storms$pressure,main="Pressure Boxplot")

#Handling the missing values ,you can either drop or input the value
#1.drop
stor$hurricane_force_diameter<-!(is.na(stor$hurricane_force_diameter))

#check now for any NA values 
anyNA(stor$hurricane_force_diameter)

#Impute the NA values
#For numeric data,mean or median can be used  depending on whether the 
median(stor$tropicalstorm_force_diameter,na.rm=TRUE)

#Replace NA
storms_clean <- storms %>% replace_na(list(tropicalstorm_force_diameter=0))
anyNA(storms_clean$tropicalstorm_force_diameter)

#Replace with mean (for numeric columns)
storms_clean<-storms %>% mutate(pressure = ifelse(is.na(pressure),mean(pressure,na.rm=TRUE),pressure))

#Numeric to character
storms <-storms %>% mutate(year_char = as.character(year))

#categorial
stor$category = as.factor(stor$category)

#Replace NA values with 0
stor<-stor %>% mutate(category=ifelse(is.na(category),"0",category))
anyNA(stor$category)


#change the text case to upper
stor$status <- str_to_sentence(stor$status)
stor$hurricane_force_diameter <- str_to_sentence(stor$hurricane_force_diameter)