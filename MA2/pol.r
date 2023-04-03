n <- 5
x <- pi * (0:(n - 1)) / (n - 1)
y <- sin(x)
plot(sin, xlim = c(0, pi), col = "blue")


lagrange <- function(t, x, y) {
    n <- length(x)
    res <- 0
    for (i in 1:n){
        for (j in 1:n){
            lij <- 1
            if (j != i) {
                lij <- j * (t - x[j]) / (x[i] - x[j])
            }
        }
        res <- res + y[i] * lij
    }
    return(res)
}