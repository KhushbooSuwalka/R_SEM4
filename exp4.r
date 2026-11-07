#Linear Regression-predict continuous values
library(tidyverse)
data(mtcars)
head(mtcars)
str(mtcars)
#column names
names(mtcars)

#Visualize
plot(mtcars$wt,mtcars$mpg,
     main="Relation Between weight and mpg",
     xlab="Weight (1000 lbs)",
     ylab="Miles per Gallon",
     pch=19,col="red")

#Calculate correlaion coefficient
#range of correlation coefficient=(+1,-1)
#correlation helps to understand relationship 
#if correlation coefficient is -ve,that mean on increasing x(input),y(output) will decrease
#if correlation coefficient is +ve,that mean on increasing x(input),y(output) will increase
cor(mtcars$wt,mtcars$mpg)
#Build the linear regression model
model<-lm(mpg ~ wt,data=mtcars)
#view model summary
summary(model)
#Get coefficients
coef(model)

#Plot Data with regression line
#(line of best fit) abline is used to draw the line
abline(model,col="blue",lwd=2)

#Make predictions
new_data<- data.frame(wt=c(2.5,3.0,3.5))
predict(model,newdata=new_data)