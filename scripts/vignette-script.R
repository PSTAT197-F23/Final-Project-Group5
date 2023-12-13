
# This script contains code to replicate the results in our primary vignette document.

## K-means & PCA ============================================================
library(tidyverse) # For data manipulation and visualization
data("iris") # Load the iris dataset
set.seed(0)

# Calculate the principal components using prcomp() function
pca <- prcomp(iris[, -5], scale = TRUE)

# Extract the scores for the first two principal components
pc1 <- pca$x[, 1]
pc2 <- pca$x[, 2]
summary(pca)

# Combine the original and transformed variables into one data frame
iris_pca <- data.frame(cbind(pc1, pc2))
colnames(iris_pca)[1:2] <- c("PC1", "PC2")

library(ggplot2) # For plotting

# Create a scatter plot of the first two principal components
ggplot(iris_pca, aes(x = PC1, y = PC2)) +
  geom_point()

inertia<-c()
for (i in 1:10){
  m<-kmeans(iris_pca, centers = i)
  inertia<-c(inertia,m$tot.withinss)
}

ggplot(data = NULL, aes(x = 1:10, y = inertia))+
      geom_line()+geom_point()+
      labs(title = "Elbow Plot", x = "n Clusters", 
           y = "Within Cluster SS")+
      scale_x_continuous(breaks = pretty(1:10, n = 10))

model<-kmeans(iris_pca, centers = 3)
preds<-cbind(iris_pca, model$cluster)
colnames(preds)[3]<-"Group"
ggplot(preds, aes(x = PC1, y = PC2, color = as.factor(Group))) +
  geom_point()+labs(title="Predicted Clusters")


## Hierarchical =============================================================

# hierarchical clustering using default method:
clusters_complete <- hclust(dist(iris[, 3:4]), method = 'complete')

# plot the dendrogram:
plot(clusters_complete, main = 'Iris Cluster Dendrogram (Complete linkage)')
abline(h = 3, col = 'red', lty = 'dashed')

# cut the tree at the desired number of clusters (3):
cut_complete <- cutree(clusters_complete, 3)

# observe results in table form:
table(cut_complete, iris$Species)

# cut tree for 4 clusters:
cut_2 <- cutree(clusters_complete, 4)
table(cut_2, iris$Species)

# hierarchical clustering using average method:
clusters_average <- hclust(dist(iris[, 3:4]), method = 'average')

# plot the dendrogram:
plot(clusters_average, main = 'Iris Cluster Dendrogram (Average linkage)')
abline(h = 1.3, col = 'red', lty = 'dashed')

# cut the tree at the desired number of clusters (3):
cut_average <- cutree(clusters_average, 3)

# observe results in table form:
table(cut_average, iris$Species)

# Visualize classification using average linkage method
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + 
  geom_point(alpha = 0.4, size = 3) + geom_point(col = cut_average) + 
  scale_color_manual(values = c('black', 'red', 'green'))

## SVM ===================================================================
#load in all necessary packages 
library(tidymodels)
library(ISLR)
library(ISLR2)
library(tidyverse)
library(glmnet)
library(modeldata)
library(kernlab)
library(tidyclust)
library(corrplot)
tidymodels_prefer()

#set seed for no shifts and play with data
library(tidyverse)
library(ggplot2)
set.seed(0)
#import data
data("iris")
iris %>% head(4)

#split data and cross validate on folds 
iris_split <- initial_split(data=iris)

iris_train <- training(iris_split)
iris_test <- testing(iris_split)

iris_folds <- vfold_cv(iris_train,v=3)

#color coded clusters plotted here on petal length and width corr. on outcome  
ggplot(iris_train, aes(Petal.Length, Petal.Width,Sepal.Length,Sepal.Width, 
                       color = Species)) + geom_point()


#color coded clusters plotted here on sepal length and width corr. on outcome  
ggplot(iris_train, aes(Sepal.Length,Sepal.Width, color = Species)) +
       geom_point()

#create a recipe to run a linear kernel and check metrics 
svm_rec <- recipe(Species ~ Petal.Length + Petal.Width + 
                  Sepal.Length + Sepal.Width,
                  data = iris_train) %>%
                  step_normalize(all_predictors())

svm_linear_spec <- svm_poly(degree = 1, cost = tune()) %>%
  set_mode("classification") %>%
  set_engine("kernlab")

svm_linear_wkflow <- workflow() %>%
  add_recipe(svm_rec) %>%
  add_model(svm_linear_spec)

svm_linear_grid <- grid_regular(cost(), degree(), levels = 3)
svm_linear_res <- tune_grid(svm_linear_wkflow, iris_folds, svm_linear_grid)
svm_linear_res %>% autoplot()

#fit the best value for the linear kernel in case we move forward with it 
svm_best_linear <- select_best(svm_linear_res)
svm_final_linear_fit <- finalize_workflow(svm_linear_wkflow, 
                                          svm_best_linear) %>% fit(iris_train)

#run a radial kernel as well as its metrics
svm_rbf_spec <- svm_rbf(cost=tune()) %>%
  set_mode('classification') %>%
  set_engine('kernlab')

svm_rbf_wkflow <- workflow() %>%
  add_recipe(svm_rec) %>%
  add_model(svm_rbf_spec)

svm_rbf_grid. <- grid_regular(cost(),levels=5)
svm_rbf_res <- tune_grid(svm_rbf_wkflow, iris_folds,svm_rbf_grid)
svm_rbf_res %>% autoplot()

#grab best metrics for radial kernel 
svm_best_radial <- select_best(svm_rbf_res)
svm_final_radial_fit <- finalize_workflow(svm_rbf_wkflow, svm_best_radial) %>%
  fit(iris_train)

#plot a confusion matrix of radial kernel 
augment(svm_final_radial_fit, iris_test) %>%
  select(Species, starts_with(".pred")) %>%
  conf_mat(Species, .pred_class) %>%
  autoplot(type = "heatmap")

## End of code ====================================