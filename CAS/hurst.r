library(pracma)

model2 <- function(n, mean, sd) {
  y <- rep(0, n)
  eps <- rnorm(n, mean, sd)
  y[1] <- eps[1]
  for (i in 2:n) y[i] <- y[i - 1] + eps[i]
  return(y)
}


n <- 2^14
x <- model2(N, 0, 1)
plot(x)

m <- 0:5
m <- 2^m
n <- n / m

for (i in 1:6) {
    print(m[i])
    x <- matrix(x, ncol = m[i])
    means <- colSums(X)
    y <- t(t(X) - means)
}
# foreach knihovna