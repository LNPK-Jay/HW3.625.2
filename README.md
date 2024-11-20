
# HW3.625.2: A Linear Regression R Package

<!-- badges: start -->
<!-- badges: end -->

The **HW3.625.2** package provides a high-performance implementation of linear regression using R and Rcpp. This package includes functionality for:

- **Model fitting:** Fit linear regression models efficiently with Rcpp-powered computations.
- **Prediction:** Generate predictions for new data using fitted models.
- **Model diagnostics:** Summarize regression results with diagnostic information.
- **Analysis of Variance (ANOVA):** Perform ANOVA to assess model quality.
- **Visualization:** Streamlined tools for interpreting results.

The package aims to make linear regression analysis more efficient and user-friendly, leveraging Rcpp for computational speed.

---

## Installation

You can install the development version of **HW3.625.2** from [GitHub](https://github.com/) with:

```r
# Install the package using pak
pak::pak("LNPK-Jay/HW3.625.2")
```

Ensure you have Rcpp installed since the package uses it for matrix computations.

---

## Features

The **HW3.625.2** package includes the following key functions:

1. `linear_regression()`: Fits a linear regression model using Rcpp for matrix computations.
2. `predict.linear_regression()`: Generates predictions for new data based on the fitted model.
3. `summary.linear_regression()`: Provides diagnostic information about the fitted model, including residuals and coefficients.
4. `anova.linear_regression()`: Performs an ANOVA to assess the quality of the fitted model.

---

## Example Usage

Here’s an example workflow demonstrating the main functionalities of the package. 

```r
library(HW3.625.2)
library(sas7bdat)
library(here)

# Load the dataset
data <- read.sas7bdat(here("data", "completedata-1.sas7bdat"))

# Data preparation
Y <- data$Depression
X <- data[, c("Fatalism", "Spirituality")]

# Step 1: Fit the linear regression model
fit <- linear_regression(X, Y)
print(fit$coefficients)

# Step 2: Display model summary
summary.linear_regression(fit)

# Step 3: Make predictions on new data
newdata <- data.frame(
  Fatalism = c(3.5, 4.2),  
  Spirituality = c(2.1, 3.8)
)
predictions <- predict.linear_regression(fit, newdata)
print(predictions)

# Step 4: Perform ANOVA on the fitted model
anova_results <- anova.linear_regression(fit)
print(anova_results)
```

---

## Benchmarking and Efficiency

The **HW3.625.2** package uses Rcpp for core matrix computations, such as solving normal equations. This ensures faster performance compared to R’s built-in `lm()` function for large datasets. Below is a benchmarking example comparing the two methods:

```r
library(bench)
data <- mtcars
Y <- data$mpg
X <- as.matrix(data[, c("wt", "hp")])

# Benchmarking
bench::mark(
  custom = linear_regression(X, Y),
  base = lm(mpg ~ wt + hp, data = data)
)
```

This demonstrates the efficiency and correctness of the package, ensuring consistent results with significant speed gains.

---

## Behind the Scenes

### Core Computation
The core matrix computations for model fitting are handled using the following Rcpp function (`compute_coefficients()`):

```cpp
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector compute_coefficients(NumericMatrix X, NumericVector y) {
  Environment base = Environment::namespace_env("base");
  Function crossprod = base["crossprod"];
  Function solve = base["solve"];
  NumericMatrix XtX = crossprod(X);
  NumericVector XtY = crossprod(X, y);
  NumericVector coefficients = solve(XtX, XtY);
  return coefficients;
}
```

This function efficiently computes regression coefficients by solving the normal equations \( X'X \beta = X'y \).

---

## Vignette

For a detailed walkthrough and additional examples, refer to the vignette included in this package:

```r
vignette("HW3.625.2")
```

The vignette covers:
- Comparison with base R’s `lm()` function.
- Real-world data applications.
- Advanced use cases like ANOVA and prediction.

---

## Future Enhancements

Planned updates include:
- Support for logistic regression and other generalized linear models.
- Improved visualization tools for regression diagnostics.
- Additional benchmarking with larger datasets.

We welcome contributions and feedback via the [GitHub repository](https://github.com/LNPK-Jay/HW3.625.2).

---