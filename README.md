
# HW3.625.2

<!-- badges: start -->
<!-- badges: end -->

The goal of HW3.625.2 package is to provide a implementation of linear regression. This package  includes functions for model fitting, prediction, analysis of variance, and visualization.It is designed to streamline the workflow for linear regression, offering tools to fit models and assess model performance.

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
library(sas7bdat)
data <- read.sas7bdat(here("data", "completedata-1.sas7bdat"))

# Data preparation
Y <- data$Depression
X <- data[, c("Fatalism", "Spirituality")]

# Fit the linear regression model
fit <- linear_regression(X, Y)                  
print(fit$coefficients)

# Use summary to show the diagnosis imformation
summary.linear_regression(fit)

# New data
newdata <- data.frame(
  Fatalism = c(3.5, 4.2),  
  Spirituality = c(2.1, 3.8)
)

# Predict response values use the new data
predictions <- predict.linear_regression(fit, newdata)
print(predictions)

# Perform ANOVA on the fitted model
anova_results <- anova.linear_regression(fit)
print(anova_results)

```

