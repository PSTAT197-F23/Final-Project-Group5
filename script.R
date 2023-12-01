# Loading Packages
library(tidymodels)
library(ISLR)
library(ISLR2)
library(tidyverse)
library(glmnet)
library(modeldata)
library(kernlab)
library(tidyclust)
library(corrplot)
library(readr)
library(stats)
#Load Data
wine <- read_delim("winequality-white.csv", 
             delim = ";", escape_double = FALSE, trim_ws = TRUE)
scaled <-data.frame(scale(wine))

scaled<-wine%>%select(!c(quality))
c<-cor(scaled)
corrplot(c)

data.pca <- prcomp(c)
transformed<-data.frame(predict(data.pca, scaled))

ggplot(transformed, aes(PC1,PC2))+geom_point()
