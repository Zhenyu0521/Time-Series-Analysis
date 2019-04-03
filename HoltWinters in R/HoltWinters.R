##### Ingest #####
data <- data_week
sales = data[,3]/1000000		# currency in millions 
temp = data[,11]


##### Visualization of Sales and Temperature #####
yy <- ts(sales, frequency=52, start=c(2015,1))
plot.ts(yy)
xx <- ts(temp, frequency=52, start=c(2015,1))
plot.ts(xx)

temp = decompose(xx) 
trend = temp$trend
seasonal = temp$seasonal
plot.ts(cbind(temp,trend, seasonal))

xd = decompose(xx) 
xd.trend = xd$trend
xd.seasonal = xd$seasonal
plot.ts(cbind(xx,xd.trend, xd.seasonal))



##### Simple Exponential Smoothing #####
####### For temperature #######
out1 <- HoltWinters(xx, beta=FALSE, gamma=FALSE) 
plot(out1)
summary(out1)
sse1 <- out1$SSE
n <- nrow(xx)
sigma2_1 <- sse1/(n)
AIC1 <- n*log(sigma2_1) + 2 
AICc1 <- AIC1 + 2*(1+1)*(1+2)/(n-1-2)
BIC1 <- n*log(sigma2_1) + n*log(1)
n_p1 <- 1/n

out2 <- HoltWinters(xx, beta=TRUE, gamma=FALSE) 
plot(out2)
sse2 <- out2$SSE
n <- nrow(xx)
sigma2_2 <- sse2/(n)
AIC2 <- n*log(sigma2_2) + 2*(1+1)
AICc2 <- AIC2 + 2*(2+1)*(2+2)/(n-2-2)
BIC2 <- n*log(sigma2_2) + n*log(2)
n_p2 <- 2/n

out3 <- HoltWinters(xx, beta=TRUE, gamma=TRUE) 
plot(out3)
sse3 <- out3$SSE
n <- nrow(xx)
sigma2_3 <- sse3/(n)
AIC3 <- n*log(sigma2_3) + 2*(52+1+1)
AICc3 <- AIC3 + 2*(54+1)*(54+2)/(n-54-2)
BIC3 <-n*log(sigma2_3) + n*log(54)
n_p3 <- 54/n

out4 <- HoltWinters(xx, beta=FALSE, gamma=TRUE) 
plot(out4)
sse4 <- out4$SSE
n <- nrow(xx)
sigma2_4 <- sse4/(n)
AIC4 <- n*log(sigma2_4) + 2*53
AICc4 <- AIC4 + 2*(53+1)*(53+2)/(n-53-2)
BIC4 <- n*log(sigma2_4) + n*log(53)
n_p4 <- 53/n

xx_summary_data <- c(sse1, sse2, sse3, sse4, 
                     AIC1, AIC2, AIC3, AIC4, 
                     AICc1, AICc2, AICc3, AICc4, 
                     BIC1, BIC2, BIC3, BIC4, 
                     n_p1, n_p2, n_p3, n_p4)
xx_summary <- matrix(xx_summary_data, nrow=4, ncol=5)

rownames(xx_summary) <- c('bF_gF', 'bT_gF', 'bT_gT', 'bF_gT')
colnames(xx_summary) <- c('SSE', 'AIC', 'AICc', 'BIC', 'n/p')
xx_summary

##### Present Retained Model
plot(out4$fitted)

##### Forecasting #####
library("forecast")
out_predict = forecast:::forecast.HoltWinters(out4, h = 26, level = c(80, 95))	
plot(out_predict)