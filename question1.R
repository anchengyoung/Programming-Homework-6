library(ggplot2)

set.seed(100)
N <- 10000
Sigma <- matrix(c(1, 0.5, 0.5, 1), nrow = 2)
X <- matrix(c(rnorm(N), rnorm(N)), nrow= 2)
L <- chol(Sigma)
Z <-t(L) %*% X
y <- Z[1,]
x <- Z[2,]

df <- data.frame(x = x,y = y)

summary(df)

# Code correlation
cor(df$x,df$y)
# Code for covariance
cov(df$x,df$y)
# Summarize regression
summary(lm(y ~ x, data = df))