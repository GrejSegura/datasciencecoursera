set.seed(4324)
library(ggplot2)
library(datasets)
library(gridExtra)
library(corrplot)
library(car)
library(lmtest)

str(mtcars)

## convert to categorical
mtcars[, c("cyl", "vs", "am", "gear", "carb")] <- lapply(mtcars[, c("cyl", "vs", "am", "gear", "carb")], as.factor)

summary(mtcars)

## Exploratory Analysis

## 1. mpg ~ am
plot.1 <- ggplot(mtcars, aes(x = mpg, fill = am)) + geom_histogram(bins = 32)
plot.1

## 2. mpg ~ categorical vars

plot.cyl <- ggplot(mtcars, aes(x = mpg, fill = cyl)) + geom_histogram(bins = 32)
plot.vs <- ggplot(mtcars, aes(x = mpg, fill = vs)) + geom_histogram(bins = 32)
plot.gear <- ggplot(mtcars, aes(x = mpg, fill = gear)) + geom_histogram(bins = 32)
plot.carb <- ggplot(mtcars, aes(x = mpg, fill = carb)) + geom_histogram(bins = 32)
grid.arrange(plot.cyl, plot.vs, plot.gear, plot.carb, ncol = 2)

## 3. mpg ~ numerical vars
cor <- cor(mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")])
corrplot(cor, method = "number")


## Inferential Analysis

## 1. mpg ~ am
model.1 <- t.test(mpg ~ am, mtcars)
model.1
model.1$conf.int
model.1.1 <- lm(mpg ~ am, mtcars)
summary(model.1.1)

## 2. mpg vs all variables
model.2 <- lm(mpg ~ . , mtcars)
summary(model.2)
vif(model.2)
AIC(model.2)

## 3. mpg vs all vars --- convert to numerical
mtcars[, c("cyl", "gear", "carb")] <- lapply(mtcars[, c("cyl", "gear", "carb")], as.numeric)
model.3 <- lm(mpg ~ drat + vs + am, mtcars)
summary(model.3)
vif(model.3)
aic.3 <- AIC(model.3)

model.4 <- lm(mpg ~ vs + am, mtcars)
summary(model.4)
vif(model.4)
aic.4 <- AIC(model.4)

## compare AICs
aic <- rbind(aic.3, aic.4)
aic

lrtest(model.3, model.2)

plot(model.3)
plot(model.4)
dwtest(model.4)