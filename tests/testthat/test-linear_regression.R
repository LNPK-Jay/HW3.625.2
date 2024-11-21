library(testthat)
library(HW3.625.2)

# Test the basic functions of linear regression
test_that("linear_regression returns expected structure for valid input", {
  # simple data input
  X <- matrix(c(1, 2, 3), ncol = 1)
  y <- c(2, 4, 6)

  # call the fucntions
  model <- linear_regression(X, y)

  # Check weather the object type is "linear_regression"
  expect_s3_class(model, "linear_regression")

  # Check weather returns the coefficients
  expect_true("coefficients" %in% names(model))
})

# Test weather the dimenstion of y and X is equal
test_that("linear_regression handles mismatched X and y lengths gracefully", {
  X <- matrix(c(1, 2, 3), ncol = 1)
  y <- c(1, 2)

  # Check if an error is thrown
  expect_error(
    linear_regression(X, y),
    "Number of rows in X must match the length of y"
  )
})
