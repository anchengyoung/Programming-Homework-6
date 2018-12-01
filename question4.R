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

df$band <- with(df, cut(x, breaks = quantile(x), include.lowest = TRUE))

df$bands <- with(df, cut(x, breaks = quantile(x, probs = seq(0,1,0.25)), include.lowest = TRUE))

table(df$bands)

ggplot(data = df, aes(x = x,y = y)) +
  geom_point() +
  facet_wrap(~bands, ncol = 4) + 
  geom_smooth(colour = "red")

