# Forecasting Temperature with HoltWinters

## Data Exploration
The given time series dataset contains 130 weekly records of temperature from 2015 to 2017. After decomposing the time series data, I could plot the data series, trend and seasonal components as follows. As you can see from the plots, the data does not show an obvious trend but has an apparent seasonality.

![Picture1](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/Pics/Picture1.png)

## Build up Univariate Time Series Model
To predict future temperatures based on previously observed values, Holt-Winters is chosen, which is one of the many methods or algorithms that can be used to forecast data points in a series. The Holt-Winters seasonal method comprises the forecast equation and three smoothing equations — one for the level, one for the trend, and one for the seasonal component, with corresponding smoothing parameters alpha, beta and gamma.

By trying different combinations of beta (TRUE/FALSE) and gamma (TRUE/FALSE), I finally got four different sets of SSE, AIC, AICc, and BIC.

![Picture2](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/Pics/Picture2.png)

For different size of samples, different criterions should be chosen to evaluate various models. Generally speaking, AIC should be chosen if the samples are small while selecting BIC if the samples are larger enough. According to the summarization of all of the results, two optional models with lowest BIC or AIC have been determined - one without trend and seasonality components and another with seasonality. However, according to exploratory data analysis, the first model could be ignored because the seasonality does exist. In conclusion, the last model with false beta and true gamma is determined.

With retained model, I could get present data series and its seasonality component. It is shown as follows:

![Picture3](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/Pics/Picture3.png)

## Predictions of Future Temperature
After determining the trend and seasonal components of the data, Holt-Winters forecast model is applied to make predictions of future 26 weeks’ temperature with 80% and 95% confidence bands. The result appears as follows:

![Picture4](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/Pics/Picture4.png)

Based on forecast, you can easily find that in the next 26 weeks, the temperature will fall down sharply. What’s more, the forecast also shows seasonality, which means the model can predict temperature with high accuracy. 

* [Feel free to check the R code](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/HoltWinters%20in%20R/HoltWinters.R)

