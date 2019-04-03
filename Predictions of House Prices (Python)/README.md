# Housing Price Predictions (Model Building and User Interface)

As is known to all, machine learning is a very powerful tool to help data analysts or data scientist find important business insights. However, does machine learning fit for any kinds of data? This report will approve that for time series data, machine learning may not be a good choice and some other methods (e.g. ARIMA) can perform better. What’s more, just as the subtitle shows, the report aims at providing instruction for users on how to use the notebook gain basic housing price historical information and future predictions of every state and every city. 

## Build up prediction model – ML vs ARIMA
Whenever the problem refers to predictions, it is usually connected with machine learning. People tend to think that machine learning can be the better way to use original datasets training models and then make accurate predictions for the future. However, when the data belongs to the time series, such as housing price data, machine learning seems not to work very well. Because the features ML will use in the models are actually time variables, which are totally the same kind of independent features. Only when the features can describe one target from different dimensions, ML may work efficiently. Therefore, the best way to solve time series issues is using the ARIMA model. 
ARIMA model in Python can get rid of seasonality and trend of your historical housing prices. Then, it provides more accurate predictions. In the Zillow housing price predictions, ML can only provide 0.4% accuracy while ARIMA provides almost 100% accuracy.

![Picture 1](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Pics/time%20series%20picture1.jpg)

## User interface
This notebook’s main goal is to help users get insights and predictions of the specific state or city. What the notebook has done is that whenever you input the state or city’s name, you can get housing price trend from 1996 to 2018 or you can get predictions in the next few years. The following shows the steps that will show housing price predictions of every state or city in the next five years. Showing historical information (trend) is using the same steps.
### 1. Input the state or city’s name
![Picture 2](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Pics/time%20series%20picture2.jpg)
### 2. Press ‘return’ to get the result
![Picture3](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Pics/time%20series%20picture3.jpg)

## Conclusions
After checking most of states and cities housing price predictions, one of the most important conclusions is housing price will continue increasing regardless of locations. What’s more, the houses in California is expensive, which can be shown by a geographical heatmap. Part of the reasons is better climate and location of California.

![Picture 4](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Pics/time%20series%20picture4.jpg)


* [Feel free to check Python codes](https://github.com/Zhenyu0521/Time-Series-Analysis/blob/master/Predictions%20of%20House%20Prices%20(Python)/Predictions%20of%20House%20Prices.ipynb) 
