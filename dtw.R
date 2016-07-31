###Exploring Dynamic Time Warp to cluster Time Series

master_ts <- read.table('data/synthetic_control.data', header=F, sep='')
#master_ts contains 600 time-series of 60 values. 
#master_ts contains 6 classes of time-series trends: Normal, Cyclic, Increasing, Decreasing, Upward Shift, Downward Shift

### randomly sampled n cases from each class, to make it easy for plotting
n <- 10
s <- sample(1:100, n)
idx <- c(s, 100+s, 200+s, 300+s, 400+s, 500+s) #creates a list of 60 random IDs
sample_ts <- master_ts[idx,]#selects 60 random time series

### compute DTW distances
library(dtw)
library(proxy)
distMatrix <- dist(sample_ts, method='DTW')

### hierarchical clustering
hc <- hclust(distMatrix, method="average")
observedLabels <- c(rep(1,n), rep(2,n), rep(3,n), rep(4,n), rep(5,n), rep(6,n))
plot(hc, labels=observedLabels)

###performing the same example using dtwclust package
library(dtwclust)
install_github('renozao/pkgmaker', ref = 'develop') #pkpgmaker is a required package for the dtwclust package
dtw_ts <- dtwclust(sample_ts,type="hierarchical",k=10,method="average")