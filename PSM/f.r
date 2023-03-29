library(car)
library(corrgram)
library(corrplot)
library(FactoMineR)
library(factoextra)
library(psych)
library(car)
library(clusterSim)

data <- read.table("data/sleepData.txt")
View(data)

scatterplotMatrix(data[, -1], cex = 1.4, cex.axis = 1.6)
describe(data)
summary(data)
dim(data)

norm_data <- data.Normalization(
    data[, -1],
    type = "n3",
    normalization = "columns"
    )
