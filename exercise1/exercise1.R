
library(tidyverse)
library(ggplot2)
library(rsample)
library(caret)
library(modelr)
library(parallel)
library(foreach)
gasprices = read.csv('ECO395M/data/GasPrices.csv')
bikeshare = read.csv('ECO395M/data/bikeshare.csv')
ABIA = read.csv('ECO395M/data/ABIA.csv')
sclass = read.csv('ECO395M/data/sclass.csv')

ggplot(data=gasprices) + geom_boxplot(aes(x=factor(Competitors), y=Price)) + labs(
  x = "Local Competition",
  y = "Price",
  color = "Cylinders"
)

ggsave("ECO395M/exercise1/1-1.png")

ggplot(data = gasprices) + 
  geom_point(mapping = aes(x = Income, y = Price)) + labs(
    x = "Local Median Household Income",
    y = "Price",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/1-2.png")

gasprices1 = gasprices %>%
  group_by(Brand) %>%
  summarize(Price = mean(Price))
ggplot(data = gasprices1) + 
  geom_col(mapping = aes(x= Brand, y= Price)) + labs(
    x = "Brand",
    y = "Price",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/1-3.png")

ggplot(data=gasprices) + 
  geom_histogram(aes(x=Price, after_stat(density))) + 
  facet_wrap(~Stoplight)

ggsave("ECO395M/exercise1/1-4.png")

ggplot(data=gasprices) + 
  geom_boxplot(aes(x=factor(Highway), y=Price)) + labs(
    x = "Direct Highway Access",
    y = "Price",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/1-5.png")

bikeshare1 = bikeshare %>%
  group_by(hr) %>%
  summarize(Total = mean(total))
ggplot(bikeshare1) + 
  geom_line(aes(x=hr, y=Total)) + labs(
    x = "Hour in the Day",
    y = "Average Bike Rentals",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/2-1.png")

bikeshare2 = bikeshare %>%
  group_by(hr, workingday) %>%
  summarize(Total = mean(total))
ggplot(bikeshare2) + 
  geom_line(aes(x=hr, y=Total)) +
  facet_wrap(~workingday)  + labs(
    x = "Hour in the Day",
    y = "Average Bike Rentals",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/2-2.png")

bikeshare3 = filter(bikeshare, hr==8) %>%
  group_by(weathersit, workingday) %>%
  summarize(Total = mean(total))
ggplot(bikeshare3) + 
  geom_col(mapping = aes(x=weathersit, y=Total)) +
  facet_wrap(~workingday) + labs(
    x = "Weather Situation Code",
    y = "Average Bike Rentals",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/2-3.png")

ABIA1 = ABIA %>%
  filter(ArrDelay < 500) %>%
  mutate(ArriveInAUS = ifelse(Dest == 'AUS', 'yes', 'no'))

ggplot(data=ABIA1) + 
  geom_histogram(aes(x=ArrDelay, after_stat(density)), binwidth = 5) + 
  facet_wrap(~ArriveInAUS) + labs(
    x = "Arrival Delay",
    y = "Density",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/3-1.png")

ggplot(ABIA) + 
  geom_point(aes(x=Distance, y=ArrDelay)) + labs(
    x = "Flight Distance",
    y = "Arrival Delay",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/3-2.png")

ABIA2 = ABIA %>%
  filter(ArrDelay > 0 & ArrDelay < 500) %>%
  group_by(UniqueCarrier) %>%
  summarize(ArrDelayM = mean(ArrDelay))
ggplot(data=ABIA2) + 
  geom_col(mapping = aes(x= UniqueCarrier, y= ArrDelayM)) + labs(
    x = "Airline",
    y = "Arrival Delay",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/3-3.png")

sclass1 = sclass %>% select(trim, mileage, price)
sclass350 = filter(sclass1, trim == 350)
sclass63 = filter(sclass1, trim == '63 AMG')

sclass350_split =  initial_split(sclass350, prop=0.9)
sclass350_train = training(sclass350_split)
sclass350_test  = testing(sclass350_split)

K_folds = 5
k_grid = c(1:100)

sclass350_folds = crossv_kfold(sclass350_train, k=K_folds)
sclass350_grid = foreach(k = k_grid, .combine='rbind') %dopar% {
  models = map(sclass350_folds$train, ~ knnreg(price ~ mileage, k=k, data = ., use.all=FALSE))
  errs = map2_dbl(models, sclass350_folds$test, modelr::rmse)
  c(k=k, err = mean(errs), std_err = sd(errs)/sqrt(K_folds))
} %>% as.data.frame
k_350 = sclass350_grid[which.min(sclass350_grid$err),1]
RMSE_350 = sclass350_grid[which.min(sclass350_grid$err),2]

ggplot(sclass350_grid) + 
  geom_point(aes(x=k, y=err)) + 
  geom_errorbar(aes(x=k, ymin = err-std_err, ymax = err+std_err))  + labs(
    x = "K",
    y = "RMSE",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/4-1.png")

knn_350 = knnreg(price ~ mileage, data=sclass350_train, k=k_350)
sclass350_test = sclass350_test %>%
  mutate(price_pred = predict(knn_350, sclass350_test))

ggplot(data = sclass350_test) + 
  geom_point(mapping = aes(x = mileage, y = price), alpha=0.2) +
  geom_line(aes(x = mileage, y = price_pred), color='red', size=1.5)+ labs(
    x = "Mileage",
    y = "Price",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/4-2.png")

sclass63_split =  initial_split(sclass63, prop=0.9)
sclass63_train = training(sclass63_split)
sclass63_test  = testing(sclass63_split)

sclass63_folds = crossv_kfold(sclass63_train, k=K_folds)
sclass63_grid = foreach(k = k_grid, .combine='rbind') %dopar% {
  models = map(sclass63_folds$train, ~ knnreg(price ~ mileage, k=k, data = ., use.all=FALSE))
  errs = map2_dbl(models, sclass63_folds$test, modelr::rmse)
  c(k=k, err = mean(errs), std_err = sd(errs)/sqrt(K_folds))
} %>% as.data.frame

k_63 = sclass63_grid[which.min(sclass63_grid$err),1]
RMSE_63 = sclass63_grid[which.min(sclass63_grid$err),2]

ggplot(sclass63_grid) + 
  geom_point(aes(x=k, y=err)) + 
  geom_errorbar(aes(x=k, ymin = err-std_err, ymax = err+std_err))  + labs(
    x = "K",
    y = "RMSE",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/4-3.png")

knn_63 = knnreg(price ~ mileage, data=sclass63_train, k=k_63)
sclass63_test = sclass63_test %>%
  mutate(price_pred = predict(knn_63, sclass63_test))

ggplot(data = sclass63_test) + 
  geom_point(mapping = aes(x = mileage, y = price), alpha=0.2) +
  geom_line(aes(x = mileage, y = price_pred), color='red', size=1.5) + labs(
    x = "Mileage",
    y = "Price",
    color = "Cylinders"
  )

ggsave("ECO395M/exercise1/ECO395M/exercise1/4-4.png")







