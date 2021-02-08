`{r, setup, include=FALSE} knitr::opts_chunk$set(echo = TRUE, wwarning = FALSE)`

`{r, include=FALSE} library(tidyverse) library(ggplot2) library(rsample) library(caret) library(modelr) library(parallel) library(foreach) gasprices = read.csv('data/GasPrices.csv') bikeshare = read.csv('data/bikeshare.csv') ABIA = read.csv('data/ABIA.csv') sclass = read.csv('data/sclass.csv')`

1) Data visualization: gas prices
---------------------------------

#### A) Gas stations charge more if they lack direct competition in sight.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ggplot(data=gasprices) + geom_boxplot(aes(x=factor(Competitors), y=Price)) + labs(     x = "Local Competition",     y = "Price",     color = "Cylinders"   )`

#### The boxplot shows that the gas price in the gas station tends to be higher when it lacks direct competition in sight.

#### B) The richer the area, the higher the gas price.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ggplot(data = gasprices) +    geom_point(mapping = aes(x = Income, y = Price)) + labs(     x = "Local Median Household Income",     y = "Price",     color = "Cylinders"   )`

#### The scatter plot shows that the gas price in richer areas tends to be higher, but the trend is not significant.

### C) Shell charges more than other brands.

`{r, echo=FALSE, message = FALSE, warning = FALSE} gasprices1 = gasprices %>%   group_by(Brand) %>%   summarize(Price = mean(Price)) ggplot(data = gasprices1) +    geom_col(mapping = aes(x= Brand, y= Price)) + labs(     x = "Brand",     y = "Price",     color = "Cylinders"   )`

#### We cannot claim that Shell charges more than other brands from the bar plot.

#### D) Gas stations at stoplights charge more.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ggplot(data=gasprices) +    geom_histogram(aes(x=Price, after_stat(density))) +    facet_wrap(~Stoplight)`

#### We cannot tell that gas stations at stoplights charge more from the histogram plot.

#### E) Gas stations with direct highway access charge more.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ggplot(data=gasprices) +    geom_boxplot(aes(x=factor(Highway), y=Price)) + labs(     x = "Direct Highway Access",     y = "Price",     color = "Cylinders"   )`

#### As shown in the boxplot, the gas stations with direct highway access charge more.

2) Data visualization: a bike share network
-------------------------------------------

#### A) Plot A: a line graph showing average bike rentals (total) versus hour of the day (hr).

`{r, echo=FALSE, message = FALSE, warning = FALSE} bikeshare1 = bikeshare %>%   group_by(hr) %>%   summarize(Total = mean(total)) ggplot(bikeshare1) +    geom_line(aes(x=hr, y=Total)) + labs(     x = "Hour in the Day",     y = "Average Bike Rentals",     color = "Cylinders"   )`

#### This figure directly depicits the overall ridership pattern. Generally, the average bike rentals begin rising after 5 a.m., flunctuate till 18:00 p.m. and decline since then.

#### B) Plot B: a faceted line graph showing average bike rentals versus hour of the day, faceted according to whether it is a working day.

`{r, echo=FALSE, message = FALSE, warning = FALSE} bikeshare2 = bikeshare %>%   group_by(hr, workingday) %>%   summarize(Total = mean(total)) ggplot(bikeshare2) +    geom_line(aes(x=hr, y=Total)) +   facet_wrap(~workingday)  + labs(     x = "Hour in the Day",     y = "Average Bike Rentals",     color = "Cylinders"   )`

#### The ridership patterns in working days and innon-working days are significantly different. During working days, the rentals reach peaks at 8 a.m. and 17 p.m., which exactly corridence the normal working time. Compared to that, the curve of daily rental pattern in non-working days are much more smooth.

#### C) Plot C: a faceted bar plot showing average ridership during the 8 AM hour by weather situation code, faceted according to whether it is a working day or not.

`{r, echo=FALSE, message = FALSE, warning = FALSE} bikeshare3 = filter(bikeshare, hr==8) %>%   group_by(weathersit, workingday) %>%   summarize(Total = mean(total)) ggplot(bikeshare3) +    geom_col(mapping = aes(x=weathersit, y=Total)) +   facet_wrap(~workingday) + labs(     x = "Weather Situation Code",     y = "Average Bike Rentals",     color = "Cylinders"   )`

#### As shown and analyzed in B), the average ridership during the 8 AM in working days is significantly higher than it in non-working days. In addition, weather tends to have sigfinifant impacts on the ridership. Specifically, people are less likely to ride when it is rainy or snowny in both working and non-working days.

3) Data visualization: flights at ABIA
--------------------------------------

\`\`\`{r, echo=FALSE, message = FALSE, warning = FALSE} ABIA1 = ABIA
%&gt;% filter(ArrDelay &lt; 500) %&gt;% mutate(ArriveInAUS = ifelse(Dest
== ‘AUS’, ‘yes’, ‘no’))

ggplot(data=ABIA1) + geom\_histogram(aes(x=ArrDelay,
after\_stat(density)), binwidth = 5) + facet\_wrap(~ArriveInAUS) + labs(
x = “Arrival Delay”, y = “Density”, color = “Cylinders” ) \`\`\`

#### We first take a look on the difference between the arrival and departure flights in ABIA. From the above histograms, we cannot tell significant difference in the delays between arrival flights and departure flights, which may indicates that the operation of ABIA is not worse than the average level of airports across the country.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ggplot(ABIA) +    geom_point(aes(x=Distance, y=ArrDelay)) + labs(     x = "Flight Distance",     y = "Arrival Delay",     color = "Cylinders"   )`

#### Second, we aim to figure out the relaship between arrival delay and flight distance. Suprisingly, we don’t find any evidence indicating that the arrival delay is highly related to the flight distance. It is also worth to observe that flights distances are very discrete in x axis, especially when they are less than 500 miles or 1500 miles because flights with those distances are less than those with medium distances.

`{r, echo=FALSE, message = FALSE, warning = FALSE} ABIA2 = ABIA %>%   filter(ArrDelay > 0 & ArrDelay < 500) %>%   group_by(UniqueCarrier) %>%   summarize(ArrDelayM = mean(ArrDelay)) ggplot(data=ABIA2) +    geom_col(mapping = aes(x= UniqueCarrier, y= ArrDelayM)) + labs(     x = "Airline",     y = "Arrival Delay",     color = "Cylinders"   )`

#### At last, we draw a bar plot to show the relationship between arrival delay and airlines. We find that US Airways has the best performance on arrival delays, while JetBlue has the poorest performance. However, we need to be clear that the arrival delay is not the only standard to justify the service quality of airlines.

4) K-nearest neighbors
----------------------

#### We first fliter the data with trim 350 and then split it into a training and a testing set. We use a 5-fold cross validation to train KNN models for different K on the training set and plot means and std errors versus K.

\`\`\`{r, echo=FALSE, message = FALSE, warning = FALSE} sclass1 = sclass
%&gt;% select(trim, mileage, price) sclass350 = filter(sclass1, trim ==
350) sclass63 = filter(sclass1, trim == ‘63 AMG’)

sclass350\_split = initial\_split(sclass350, prop=0.9) sclass350\_train
= training(sclass350\_split) sclass350\_test = testing(sclass350\_split)

K\_folds = 5 k\_grid = c(1:100)

sclass350\_folds = crossv\_kfold(sclass350\_train, k=K\_folds)
sclass350\_grid = foreach(k = k\_grid, .combine=‘rbind’) %dopar% {
models =
map(sclass350\_folds*t**r**a**i**n*, *k**n**n**r**e**g*(*p**r**i**c**e* *m**i**l**e**a**g**e*, *k* = *k*, *d**a**t**a* = ., *u**s**e*.*a**l**l* = *F**A**L**S**E*))*e**r**r**s* = *m**a**p*2<sub>*d*</sub>*b**l*(*m**o**d**e**l**s*, *s**c**l**a**s**s*350<sub>*f*</sub>*o**l**d**s*test,
modelr::rmse) c(k=k, err = mean(errs), std\_err =
sd(errs)/sqrt(K\_folds)) } %&gt;% as.data.frame k\_350 =
sclass350\_grid\[which.min(sclass350\_grid$err),1\] RMSE\_350 =
sclass350\_grid\[which.min(sclass350\_grid$err),2\]

ggplot(sclass350\_grid) + geom\_point(aes(x=k, y=err)) +
geom\_errorbar(aes(x=k, ymin = err-std\_err, ymax = err+std\_err)) +
labs( x = “K”, y = “RMSE”, color = “Cylinders” ) \`\`\`

#### The optimal K = `r k_350` with an average RMSE of `r RMSE_350`, and the price predictions for trim 350 is shown as follows.

\`\`\`{r, echo=FALSE, message = FALSE, warning = FALSE} knn\_350 =
knnreg(price ~ mileage, data=sclass350\_train, k=k\_350) sclass350\_test
= sclass350\_test %&gt;% mutate(price\_pred = predict(knn\_350,
sclass350\_test))

ggplot(data = sclass350\_test) + geom\_point(mapping = aes(x = mileage,
y = price), alpha=0.2) + geom\_line(aes(x = mileage, y = price\_pred),
color=‘red’, size=1.5)+ labs( x = “Mileage”, y = “Price”, color =
“Cylinders” ) \`\`\`

#### We can repeat the process for trim 63 AMG.

\`\`\`{r, echo=FALSE, message = FALSE, warning = FALSE} sclass63\_split
= initial\_split(sclass63, prop=0.9) sclass63\_train =
training(sclass63\_split) sclass63\_test = testing(sclass63\_split)

sclass63\_folds = crossv\_kfold(sclass63\_train, k=K\_folds)
sclass63\_grid = foreach(k = k\_grid, .combine=‘rbind’) %dopar% { models
=
map(sclass63\_folds*t**r**a**i**n*, *k**n**n**r**e**g*(*p**r**i**c**e* *m**i**l**e**a**g**e*, *k* = *k*, *d**a**t**a* = ., *u**s**e*.*a**l**l* = *F**A**L**S**E*))*e**r**r**s* = *m**a**p*2<sub>*d*</sub>*b**l*(*m**o**d**e**l**s*, *s**c**l**a**s**s*63<sub>*f*</sub>*o**l**d**s*test,
modelr::rmse) c(k=k, err = mean(errs), std\_err =
sd(errs)/sqrt(K\_folds)) } %&gt;% as.data.frame

k\_63 = sclass63\_grid\[which.min(sclass63\_grid$err),1\] RMSE\_63 =
sclass63\_grid\[which.min(sclass63\_grid$err),2\]

ggplot(sclass63\_grid) + geom\_point(aes(x=k, y=err)) +
geom\_errorbar(aes(x=k, ymin = err-std\_err, ymax = err+std\_err)) +
labs( x = “K”, y = “RMSE”, color = “Cylinders” ) \`\`\`

#### The optimal K = `r k_63` with an average RMSE of `r RMSE_63`, and the price predictions for trim 63 AMG is shown as follows.

\`\`\`{r, echo=FALSE, message = FALSE, warning = FALSE} knn\_63 =
knnreg(price ~ mileage, data=sclass63\_train, k=k\_63) sclass63\_test =
sclass63\_test %&gt;% mutate(price\_pred = predict(knn\_63,
sclass63\_test))

ggplot(data = sclass63\_test) + geom\_point(mapping = aes(x = mileage, y
= price), alpha=0.2) + geom\_line(aes(x = mileage, y = price\_pred),
color=‘red’, size=1.5) + labs( x = “Mileage”, y = “Price”, color =
“Cylinders” ) \`\`\`

#### Trim 63 AMG yields a larger optimal value of K because it has more samples in the dataset.
