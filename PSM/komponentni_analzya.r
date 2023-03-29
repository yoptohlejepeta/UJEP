library(car)
library(corrgram)
library(corrplot)

# Dataset loading


mydata <- USJudgeRatings

# Data exploration

png('scatterplotmatrix.png', bg = 'white', width = 8000, height = 6000, 
    res = 600)
scatterplotMatrix(mydata[,-1],cex = 1.4, cex.axis = 1.6)
dev.off()


png('corrgram.png', bg = 'white', width = 6000, height = 6000, 
    res = 600)
par(cex.main = 1.6,las=1, cex = 1.2)
corrgram(mydata[,-1], order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Correlogram of the dataset variables intercorrelations")
dev.off()

datamatrix <- cor(mydata[,-1])
corrplot(datamatrix, method="number")


png('box_plot.png', bg = 'white', width = 8000, height = 4000, 
    res = 600)
boxplot(mydata[,-1])
dev.off()

# Data normalizing

library(clusterSim)

norm_data <- data.Normalization(mydata[,-1], type = 'n3', normalization = 'columns')

png('box_plot1.png', bg = 'white', width = 8000, height = 4000, 
    res = 600)
boxplot(norm_data)
dev.off()



# Applying PCA

library(FactoMineR)
library(factoextra)
library(psych)

cor_matrix <- cor(norm_data)


data.pca <- princomp(norm_data)

data_pca1 <- princomp(cor_matrix)




summary(data.pca)

summary(data_pca1)

# PCs' weigth calculation

pcwt <- data.pca$loadings[, 1:2]

pcwt1 <- data_pca1$loadings[, 1:2]

# Visualization of the principal components

# 1. Scree plot

png('scree_plot.png', bg = 'white', width = 5000, height = 4000, 
    res = 600)
fviz_eig(data.pca, addlabels = TRUE)
dev.off()

png('scree_plot_1.png', bg = 'white', width = 5000, height = 4000, 
    res = 600)
fviz_eig(data_pca1, addlabels = TRUE)
dev.off()

# 2. Biplot of the attributes

png('Biplot_plot.png', bg = 'white', width = 5000, height = 4000, 
    res = 600)
fviz_pca_var(data.pca, col.var = "black")
dev.off()

# Contribution of each variable

png('Bar_plot1.png', bg = 'white', width = 5000, height = 4000, 
    res = 600)
fviz_cos2(data.pca, choice = "var", axes = 1:2)
dev.off()

# Biplot combined with cos2 

png('Biplor_Cos2.png', bg = 'white', width = 5000, height = 4000, 
    res = 600)
fviz_pca_var(data.pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"),
             repel = TRUE)
dev.off()

pc <- principal(norm_data, nfactors=2, rotate = F, scores = T)
pc_values <- as.data.frame(pc$scores)


cor(pc_values)

pc_fun <- function(init_data, pc_loading){
  res <- vector()
  for(i in 1: nrow(init_data)){
    res1 <- 0
    for(j in 1:ncol(init_data)){
      res1 = res1 + pc_loading[j]*init_data[i,j]
    }
    res[i] <- res1
  }
  return(res)
}

pcwt <- data.pca$loadings[, 1]

PC_1 <- pc_fun(norm_data, pcwt)

new_data <- as.data.frame(cbind(Raiting = mydata[, 1], PC = PC_1))
row.names(new_data) <- row.names(mydata)

new_data1 <- as.data.frame(cbind(Raiting = mydata[, 1], pc_values))
row.names(new_data1) <- row.names(mydata)
