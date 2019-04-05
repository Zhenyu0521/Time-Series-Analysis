#####################
#####Ingest Data#####
#####################
data <- data_week
#select columns we need
x <- c("avg_cloud_index", "avg_temp", "avg_hours_sun")
d1 <- data[x]
d1 <- as.matrix(d1)


#############
#####PCA#####
#############

xcor = cor(d1)

# Eigen decomposition 
out = eigen(xcor)  # eigen decomposition of correlation matrix. Yields eiganvalues and eigenvectors

va = out$values		# eigenvalues
ve = out$vectors	# eigenvectors. Each column is an eigenvector and has a unit length. 	

# Scree Plot		# to decide how many variables to keep. Look for "elbow" in the scree plot
plot(va, type = "o", col = "blue")

# eigenvector proivdes the weights to create new variables (aka loadings)
w1 = ve[,1]			

# check each eignvector has unit length (for your learning)
chk = t(w1) %*% w1

# new variables weather_index (aka principal components scores)
weather_index = d1 %*% w1


###################################
#####Exploratory Data Analysis#####
###################################

yy = ts(weather_index, frequency = 52,start = c(2015,1))		# coverts sales data as time series object with start date and frequency (weekly here)
plot.ts(yy)
plot(decompose(yy))    # Must consider the seasonal factor


#########################
#####Automated ARIMA#####
#########################

library("forecast")
library("tseries") 

auto_model = auto.arima(yy)		# fits ARIMA(p,d,q) x (P, D, Q) automatically - ARIMA(1,0,1) and No seasonality
summary(auto_model)
AICc = function(model){
  n = model$nobs
  p = length(model$coef)
  AICc = model$aic + 2*(p+1)*(p+2)/(n-p-2)
  return(AICc)
}
AIC1 <- AIC(auto_model)
AICc1 <- AICc(auto_model)
BIC1 <- BIC(auto_model)

auto_model.predict = forecast:::forecast.Arima(auto_model, h = 52, level = c(68, 80, 90, 95))
plot(auto_model.predict)


########################
#####Adjusted ARIMA#####
########################

#### Let's firstly determine d - stationality ####
adf.test(yy)
yd1 <- diff(yy, differences=1)
adf.test(yd1)  # The d in ARIMA must be 1

#### Perturb model with p+/-1, q+/-1, and no seasonality
p_d_q_result <- data.frame(matrix(nrow=9,ncol=3))
colnames(p_d_q_result) <- c('AIC', 'AICc', 'BIC')

# Possible combinations of p and q #
p <- c(0,1,2)
q <- c(0,1,2)
p_q <- list()
for (i in 1:3) {
  for (j in 1:3) {
    one_p_q <- list(c(p[i],1,q[j]))
    p_q <- append(p_q, one_p_q)
  }
}
p_q

# Possible AIC, AICc, and BIC #
for (m in 1:9) {
    model <- Arima(yy, order=c(p_q[[m]][1], p_q[[m]][2], p_q[[m]][3]))
    p_d_q_result[m,1] <- AIC(model)
    p_d_q_result[m,2] <- AICc(model)
    p_d_q_result[m,3] <- BIC(model)
    rownames(p_d_q_result)[m] <- c(p_q[m])
}
p_d_q_result

# The best combination of p, d, and q 
p_d_q_best <- row.names(subset(p_d_q_result, AIC==min(p_d_q_result['AIC']) & AICc==min(p_d_q_result['AICc']) | BIC==min(p_d_q_result['BIC'])))
p_d_q_best  # The best combination of p, d, and q is (0,1,1)


#### Take seasonality into consideration and find best combination of P, D, Q
P_D_Q_result <- data.frame(matrix(nrow=27,ncol=3))
colnames(P_D_Q_result) <- c('AIC', 'AICc', 'BIC')

# Possible combinations of P, D, and Q #
P <- c(0,1,2)
D <- c(0,1,2)
Q <- c(0,1,2)
P_D_Q <- list()
for (i in 1:3) {
  for (j in 1:3) {
    for (u in 1:3) {
      one_P_D_Q <- list(c(P[i],D[j],Q[u]))
      P_D_Q <- append(P_D_Q, one_P_D_Q)
    }
  }
}
P_D_Q

# Possible results of AIC, AICc, and BIC #
for (m in 1:27) {
  model <- Arima(yy, order=c(0,1,1), seasonal=list(order=c(P_D_Q[[m]][1], P_D_Q[[m]][2], P_D_Q[[m]][3]), period=52))
  P_D_Q_result[m,1] <- AIC(model)
  P_D_Q_result[m,2] <- AICc(model)
  P_D_Q_result[m,3] <- BIC(model)
  rownames(P_D_Q_result)[m] <- c(P_D_Q[m])
}

P_D_Q_result

# The best combination of P, D, and Q
P_D_Q_best <- row.names(subset(P_D_Q_result, AIC==min(P_D_Q_result['AIC']) & AICc==min(P_D_Q_result['AICc']) & BIC==min(P_D_Q_result['BIC'])))
P_D_Q_best  # The best combination of P, D, and Q is (0,2,0)

## The best ARIMA model should be (0,1,1) * (0,2,0)


#####################
#####Predictions#####
#####################
best_model <- Arima(yy, order=c(0,1,1), seasonal=list(order=c(0,2,0), period=52))
summary(best_model)
weather.predict = forecast:::forecast.Arima(best_model, h=52, level=c(68,80,90,95))
plot(weather.predict)