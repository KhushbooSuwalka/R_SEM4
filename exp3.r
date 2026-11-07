library (tidyr)

#LOADING DATA FROM MTCARS
data(mtcars)
head(mtcars,10)

#LINE PLOT IS USED FOR CONTINUOUS AND NUMERIC VALUES
plot(mtcars$wt,type="l",col="black")
plot(mtcars$wt,type="l",col="blue",lwd=2,
     ylim=range(c(mtcars$wt,mtcars$mpg)),
     main="Weight VS  MPG",
     xlab="Car Index",
     ylab="Value")
lines(mtcars$mpg,col="red",lwd=2,type="l")
#type="l" for line in plot
#type="p" for points in plot
#type="b" for both line and point in the plot

legend("topleft",
       legend=c("Weight","MPG"),
       col=c("blue","red"),
       lwd=2,lty=1)
#lwd stands for line ki width
#lty stands for line type


#BAR PLOT
cyl_count <- table(mtcars$cyl)
jpeg("barplot.jpeg",width=800,height=900)
barplot(cyl_count,
        col=c("orange","skyblue","violet"),
        main="Cars By Cylinder Count",
        xlab="Cylinders",
        ylab="No. of Cars")
dev.off()

#SCATTER PLOT:Horsepower VS Mileage
plot(mtcars$hp,mtcars$mpg,
     pch=21,col="red",
     main="HP VS MPG",
     xlab="Horsepower",
     ylab="Mileage")
#pch for point shape ,its range is around 25

#HEATMAP (data intensity)
png("heatmap.png")
heatmap(as.matrix(mtcars),
        col=heat.colors(10),
        main="Heatmap of mtcars")
dev.off()
#For heatmap we have change the table in matrix form first
#dev.off() function is for closing the png image part
#lines in heatmap are dendrograms ,the small lines close to each other means they make a cluster. 

#TREEMAP(Hierarchical data)
install.packages("treemap")
library(treemap)

treemap(mtcars,
        index="cyl",
        vSize="hp",
        title="Horsepower by Cylinder Group")

#Interactive plot
install.packages("plotly")
install.packages("htmlwidgets")
library(plotly)
library(htmlwidgets)
savewidget(p,"interactive_plot.html")
plot_ly(mtcars,x=~hp,y=~mpg,
        type="scatter",mode="markers")
dev.off()