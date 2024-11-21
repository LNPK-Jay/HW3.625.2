library(testthat)
library(HW3.625.2)

# Test summary function with valid input
test_that("summary.linear_regression works with valid input", {
  # Create a simple linear regression model
  X <- data.frame(x1 = c(1, 2, 3, 4, 5), x2 = c(2, 3, 4, 6, 8))
  y <- c(10, 12, 14, 18, 22)
  model <- linear_regression(X, y)

  # Get the summary output
  expect_output(summary.linear_regression(model), "Call:")
  expect_output(summary.linear_regression(model), "Residuals:")
  expect_output(summary.linear_regression(model), "Coefficients:")
  expect_output(summary.linear_regression(model), "Multiple R-squared:")
})
