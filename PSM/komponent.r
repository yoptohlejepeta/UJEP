library(car)
library(corrgram)
library(corrplot)
library(FactoMineR)
library(factoextra)
library(psych)
library(clusterSim)


decath <- read.table("data/decathlon.txt")
scatterplotMatrix(decath[, -1], cex = 1.4, cex.axis = 1.6)
norm_data <- data.Normalization(
    decath[, -1],
    )
norm_data <- na.omit(norm_data)
cor_matrix <- cor(norm_data)
data_pca <- princomp(norm_data)
data_pca1 <- princomp(cor_matrix)

pcwt <- data_pca$loadings[, 1:2]
pcwt1 <- data_pca1$loadings[, 1:2]

fviz_eig(data_pca, addlabels = TRUE)
fviz_eig(data_pca1, addlabels = TRUE)

fviz_pca_var(data_pca, col.var = "black")
fviz_cos2(data_pca, choice = "var", axes = 1:2)

fviz_pca_var(data_pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"),
             repel = TRUE)

pc <- principal(norm_data, nfactors = 2, rotate = FALSE, scores = TRUE)
pc_values <- as.data.frame(pc$scores)

cor(pc_values)

pc_fun <- function(init_data, pc_loading) {
  res <- vector()
  for(i in 1: nrow(init_data)){
    res1 <- 0
    for(j in 1:ncol(init_data)){
      res1 <- res1 + pc_loading[j] * init_data[i, j]
    }
    res[i] <- res1
  }
  return(res)
}

pcwt <- data_pca$loadings[, 1]

PC_1 <- pc_fun(norm_data, pcwt)

new_data <- as.data.frame(cbind(Raiting = decath[, 1], PC = PC_1))
row.names(new_data) <- row.names(decath)

new_data1 <- as.data.frame(cbind(Raiting = decath[, 1], pc_values))
row.names(new_data1) <- row.names(decath)
