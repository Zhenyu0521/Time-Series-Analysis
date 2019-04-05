# ARIMA Modeling

## Principal Components Analysis
The given time series dataset contains 130 weekly records from 2015 to 2017. First, I did a Principal Components Analysis to represent the three chosen variables ‘avg_cloud_index’, ‘avg_temp’, and ‘avg_hours_sun’ as one ‘weather_index’ variable. 

After decomposing the time series data, I could plot the data series, trend and seasonal components as follows. As you can see from the plots, the data does not show an obvious trend but has an apparent seasonality.

![picture1](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture1.png)

## Build up ARIMA Model
### Automated ARIMA Version
To predict future temperatures based on previously observed values, ARIMA is chosen. ARIMA is an acronym that stands for AutoRegressive Integrated Moving Average. It is a class of model that captures a suite of different standard temporal structures in time series data. A non-seasonal ARIMA model is classified as an "ARIMA (p, d, q)" model, where:

●	p is the number of autoregressive terms,

●	d is the number of non-seasonal differences needed for stationarity, and

●	q is the number of lagged forecast errors in the prediction equation.

If seasonality is considered, (P, D, Q) will be also included in the ARIMA model.

I first used Automated ARIMA to get a target set of parameters for reference and I got a combination of (p, d, q) * (P, D, Q) as (0,0,0) * (0,1,0).

![picture2](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture2.png)

### The Best Combination of (p, d, q)
Based on the results, I perturbed the model with its p +/- 1, d +/- 1, and q +/- 1 to see whether models in its neighbourhood are better or not. First, the d value that represents stationary was determined. The ADF test result showed that d = 1 is an ideal value in the ARIMA model. Then, by trying different combinations of p and q, I finally got four more sets to compare with the original model in AIC, AICc, and BIC.

![picture3](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture3.png)

According to the summarization of all of the results, the optional model with the lowest AIC, AICc, and BIC is (0,1,1) as (p, d, q).

### The Best Combination of Seasonal (P, D, Q)
After determining the optimal (p, d, q), we also take seasonality into consideration and find the best combination of (P, D, Q). 

With P, D, and Q within the range (0, 2), we finally get 27 different combinations and calculated AIC, AICc, and BIC of all the models. The results are shown below:

![picture4](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture4.png)

By comparing the models, (0,2,0) is chosen as (P, D, Q). Therefore, the final ARIMA model with (0,1,1) for (p, d, q) and (0,2,0) for (P, D, Q).

### Predictions of Future Weather
After determining components of the model, I applied the ARIMA forecast model to fit historical data and the final summary of this best model is like:

![picture5](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture5.png)

The final model has a p with 0 (AR part) and q with 1 (MA part), which means that there are no autoregressive terms and 1 lagged forecast error. And I also made predictions of future 52 weeks’ temperature with 68%, 80%, 90% and 95% confidence bands. The final result appears as follows:

![picture6](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/ARIMA%20in%20R/Pics/picture6.png)




