library(expm)

tb <- Sys.time()

prob <- c(0.1, 0.02, 0.03, 0.05, 0.07, 0.09, 0.11, 0.13, 0.14, 0.12, 0.07, 0.04, 0.02, 0.01)

m <- matrix(0, nrow = 102, 115)
for (i in 1:102){
    m[i, i:(i + 13)] <- prob
}

m[, 102] <- rowSums(m[, 102:115])
m <- m[, 1:102]
a <- numeric(102)
a[1] <- 1
a <- a %*% (m %^% 14)
colnames(a) <- 100:(-1)


tk <- Sys.time()
print(tk - tb)
