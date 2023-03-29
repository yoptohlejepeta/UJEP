
# Factor analysis

library(psych)
library(corrplot)
library(ggplot2)
library(car)



# Dataset loading
#url <- "https://raw.githubusercontent.com/housecricket/data/main/efa/sample1.csv"
#data_survey <- read.csv(url, sep = ",")
#write.table(data_survey, 'data_survey.txt')

data_survey <- read.table('data_survey.txt')


#Data analysis
describe(data_survey)

summary(data_survey)

dim(data_survey)

#Cleaning data

dat <- data_survey[,-1] 

# Correlation analysus

datamatrix <- cor(dat[,-13])
corrplot(datamatrix, method="number")

# The Factorability of the Data

X <- dat[,-13]
Y <- dat[,13]

scatterplotMatrix(dat)

# The Kaiser-Meyer-Olkin (KMO)

KMO(r=cor(X))

# Bartlett’s Test of Sphericity

cortest.bartlett(X)

# Determinant musi byt > 0
det(cor(X))


# The Number of Factors to Extract


fafitfree <- fa(dat,nfactors = ncol(X), rotate = "none")
n_factors <- length(fafitfree$e.values)
scree     <- data.frame(
  Factor_n =  as.factor(1:n_factors), 
  Eigenvalue = fafitfree$e.values)

ggplot(scree, aes(x = Factor_n, y = Eigenvalue, group = 1)) + theme_light() +
  geom_point() + geom_line() +
  xlab("Number of factors") +
  ylab("Initial eigenvalue") +
  labs( title = "Scree Plot", 
        subtitle = "(Based on the unreduced correlation matrix)")


# Parallel Analysis

library(nFactors)

parallel <- fa.parallel(X)

# Factor analysis using fa method

fa.none <- fa(r=X, nfactors = 4, fm="pa", max.iter=100,
              rotate="varimax",scores = T)

print(fa.none)

# Factor analysis using the factanal method

factanal.none <- factanal(X, factors=4, 
                          scores = c("regression"), rotation = "varimax")
print(factanal.none)

# Graph Factor Loading Matrices

fa.diagram(fa.none)

# Scores for all the rows

newVar <- as.data.frame(fa.none$scores)

newData <- cbind(QD = Y, newVar)
colnames(newData) = c('QD','FA1','FA2','FA3','FA4')

corrplot(cor(newData), method="number")

scatterplotMatrix(newData)

# Splitting the data to train and test set

#Splitting the data 70:30
#Random number generator, set seed.
set.seed(100)
indices <- sample(1:nrow(newData), 0.7*nrow(newData))
train <- newData[indices,]
test <- newData[-indices,]

# Regression Model using train data

model.fa.score = lm(QD ~., train)
summary(model.fa.score)

# Check prediction of the model in the test dataset

#Model Performance metrics:
pred_test <- predict(model.fa.score, newdata = test, type = "response")

test$QD_Predicted <- round(pred_test,0)

res <- table(test$QD, test$QD_Predicted)

acc <- sum(diag(res))/sum(res)

############################################################################






