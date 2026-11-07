# k means cluster 
data("iris")
iris_data <- iris[ ,1:4]
head(iris_data)
scaled_data <- scale(iris_data)
head(scaled_data)

set.seed(123)
kmeans_r = kmeans(scaled_data,centers = 3,nstart = 10)
print(kmeans_r)

install.packages("ggplot2")
library(ggplot2)
iris$cluster <- as.factor(kmeans_r$cluster)
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color=cluster))+geom_point(size=3)+labs(title = "K_means clustering on IRIS dataset")