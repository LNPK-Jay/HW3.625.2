
# HW3.625.2

<!-- badges: start -->
<!-- badges: end -->

The goal of HW3.625.2 package is to provide a implementation of linear regression. This package  includes functions for model fitting, prediction, analysis of variance, and visualization.It is designed to streamline the workflow for linear regression, offering tools to fit models, assess model performance, and visualize results.

## Installation

You can install the development version of HW3.625.2 from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("LNPK-Jay/HW3.625.2")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(HW3.625.2)

set.seed(47)
X <- matrix(rnorm(100), ncol=2)  
y <- rnorm(50)                  

fit <- linear_regression(X, y)
print(fit$coefficients)
summary(fit)


# New data for prediction
new_X <- matrix(rnorm(10), ncol=2)

# Predict response values
predictions <- predict(fit, new_X)
print(predictions)

# Perform ANOVA on the fitted model
anova_results <- anova_function(fit)
print(anova_results)

#plot all the figures
plot(model)

#Generate residual plot only 
plot(model, type = "residual")

#Generate QQ plot only
plot(model, type = "qq")

#Generate standardized residual plot only
plot(model, type = "standardized")


```

