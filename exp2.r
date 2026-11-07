library(tidyverse)
#loading and inspecting data
data(mtcars)
head(mtcars,10)
view(mtcars)
#check structure
str(mtcars)
#dimensions:Rows and columns 
dim(mtcars)
nrow(mtcars)
ncol(mtcars)
#column names
names(mtcars)

#Measures of central tendency
#Calculate mean of mpg(miles per gallon)
cat("Mean:",mean(mtcars$mpg),"\n")
#Handling missing data
data(airquality)
mean(airquality$Ozone)
sum(is.na(airquality$Ozone))
#Remove NA values before calculating
mean(airquality$Ozone,na.rm= TRUE )

#Median
cat("Median:",median(mtcars$mpg),"\n")

#Mode
#Function to find mode
get_mode <- function(x){
  unique_values<-unique(x)
  unique_values[which.max(tabulate(match(x,unique_values)))]
}
get_mode(mtcars$mpg)

cylinders<-mtcars$cyl
get_mode(cylinders)
#count frequency by creating frequency table
cylinder_freq <-table(mtcars$cyl)
print(cylinder_freq)

#measures of spread
#1.Range = Max value -Min value
max_mpg<-max(mtcars$mpg)
min_mpg <- min(mtcars$mpg)
range_mpg <- max_mpg - min_mpg
print(range_mpg)
#Method 2 : Using range function
diff(range(mtcars$mpg))

#SD
std_dev <- sd(mtcars$mpg)
print(std_dev)

#Variance
variance <-var(mtcars$mpg)
sd<-sqrt(variance)
print(variance)

#IQR
quantile(mtcars$mpg)
IQR(mtcars$mpg)

boxplot(mtcars$mpg,
        main="MPG Distribution",
        ylab="Miles per gallon",
        col="lightblue")
#BOX represents IQR
#Line in box = Median
#Dots = Outliers

#Summary function : all statistics at once
summary(mtcars$mpg)