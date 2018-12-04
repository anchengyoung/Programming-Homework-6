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

SimCorrelation <- function(sample.frac){
  sample.size <- sample.frac*N
  sim.values <- c()
  num.interations <- 500
  for (i in 1:num.interations){
    df.sample <- df[sample(1:N,sample.size, replace = TRUE),]
    rho <- with(df.sample, cor(x,y))
    sim.values <- c(sim.values, rho)
  }
  sim.values
}

df.20 <- data.frame(rho = SimCorrelation(1/20), sample.size = "1/20")
df.100 <- data.frame(rho = SimCorrelation(1/100), sample.size = "1/100")

df.combo <- rbind(df.20, df.100)

ggplot(data = df.combo, aes(x = rho, colour = sample.size)) +
geom_density() + facet_wrap(~sample.size, ncol = 1)
