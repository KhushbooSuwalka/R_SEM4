#KNN CLASSIFICATION ON IRIS DATASET
# classify iris species using KNN

#Step 1: Load and prepare data
data<-iris #Load built-in iris dataset
head(iris)
summary(data)
str(data)

#SAVE ORIGINAL SPECIES NAMES FOR LATERAL VISUALIZATION
row_labels<-data[,5]
#
#row_labels:"setosa","versicolor","verginica"

#Convert species from text to numbers
data$Species <-as.numeric(data$Species)
#setosa -1,versicolor -2,virginica -3

#Standardize features (mean=0,sd=1)
#Critical for KNN ! Prevents bias from different
data[,1:4]<-scale(data[,1:4])
#Before:sepal.length 4.4-7.9 ,petal.width 0.1-2.5
#After All features approximately -3 to +3

#step 2: split data into training and testing 
set.seed(42) #makes result reproducible

#calculate training set size (80% of 150=120)
size<- floor(0.8 * nrow(data)) #floor(120)-120

#randomly select 120 row indices for training
train_ind <- sample(seq_len(nrow(data)),size=size)
#Example:[45,32,89,12......] (120 random numbers)

#Extract labels (species)for training and testing
train_labels <-data[train_ind,5]  #120 training labels(numbers)
test_labels<-row_labels[-train_ind]  #30 testing labels(text)

#Extract features for training and testing
data_train<-data[train_ind,1:4] #120 rows,4 columns (scaled)
data_test<-data[-train_ind,1:4] #30 rows,4 columns (scaled)

#Step 3: train KNN model and make prediction
library(class) #Load KNN package

#Run algorithm
predictions<-knn(
  train=data_train, #Training data(120 flowers)
  test=data_test, #Testing data(30 flowers)
  cl=train_labels, #Training labels(1,2,3)
  k=round(sqrt(nrow(data_train)))  #k=11 neighbors
)
#output: Predicted species for 30 test flowers

#step 4:Prepare Data for visualization
#Combine test features with predictions
plot_predictions <-data.frame(
  data_test$Sepal.Length,
  data_test$Sepal.Width,
  data_test$Petal.Length,
  data_test$Petal.Width,
  predicted=predictions  #Add predictions as new column
)
#rename columns for clarity
colnames(plot_predictions)<-c(
  "Sepal.Length",
  "Sepal.Width",
  "Petal.Length",
  "Petal.Width",
  "predicted"
)

#Step 5: create visualizations
library(ggplot2) # Advanced plotting
install.packages("gridExtra")
library(gridExtra) # Arrange multiple plots

# Plot 1: Sepal Length vs Width
p1 <- ggplot(
  plot_predictions,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    colour = predicted,  # Color by predicted species
    fill = predicted
  )
) +
  geom_point(size = 5) +  # Large points
  geom_text(  # Add text labels
    aes(label = test_labels),
    hjust = 1,  # Horizontal position
    vjust = 2   # Vertical position (below point)
  ) +
  ggtitle("Predicted relationship between Sepal Length and Width") +
  theme(plot.title = element_text(hjust = 0.5)) +  # Center title
  theme(legend.position = "none")  # Hide legend

# Plot 2: Petal Length vs Width
p2 <- ggplot(
  plot_predictions,
  aes(
    x = Petal.Length,
    y = Petal.Width,
    colour = predicted,
    fill = predicted
  )
) +
  geom_point(size = 5) +
  geom_text(
    aes(label = test_labels),
    hjust = 1,
    vjust = 2
  ) +
  ggtitle("Predicted relationship between Petal Length and Width") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")

# Display both plots side by side
grid.arrange(p1, p2, ncol = 2)

# Step 6: Evaluate Model Performance
# Calculate accuracy
accuracy <- sum(predictions == as.numeric(factor(test_labels))) / length(test_labels)
cat("Model Accuracy:", round(accuracy * 100, 2), "%\n")

# Confusion matrix
table(Predicted = predictions, Actual = as.numeric(factor(test_labels)))