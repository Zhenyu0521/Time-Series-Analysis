# Time Series Analysis

In this part, I have explored some ways to apply the time series analysis in R and Python seperately. The final goal is to make accurate predictions of time series data. 

[The Holtwinters model](https://github.com/Zhenyu0521/Time-Series-Analysis/tree/master/HoltWinters%20in%20R) is the most simplest time-series model. Alpha, beta, and gamma can control levels, trends, and seasonality. And I make predictions of temperature in one area.

![hw picture](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/Pics/Picture4.png)

[ARIMA model (R)](https://github.com/Zhenyu0521/Time-Series-Analysis/tree/master/ARIMA%20in%20R) is an advanced way to conduct time series analysis. In R, there is auto.arima helping determine (p, d, q) * (P, D, Q) automatically and in most cases, it can get very accurate results. However, you can also adjust these parameters manually and check AIC, BIC, AICc of different models to find better one. And in R code, I applied ARIMA to make predictions of whether in one area. The result is as follows:

![arimar picture](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture6.png)

[Making predictions of American housing price](https://github.com/Zhenyu0521/Time-Series-Analysis/tree/master/Predictions%20of%20House%20Prices%20(Python)) illustrates the way to realize ARIMA model in Python. The most important technique in this notebook is making use of grid search to find the best combination of (p, d, q) * (P, D, Q). And the final predication looks very precise:

![usahp picture](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Pics/time%20series%20picture3.jpg)


