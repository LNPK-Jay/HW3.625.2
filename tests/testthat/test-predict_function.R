library(testthat)
library(HW3.625.2)

# Test valid input
test_that("predict.linear_regression works with valid input", {
  # Create a simple linear regression model with valid data
  X <- data.frame(x1 = c(1, 2, 3, 4), x2 = c(5, 6, 7, 9))
  y <- c(10, 20, 30, 40)
  model <- linear_regression(X, y)

  # New data for prediction
  newdata <- data.frame(x1 = c(7, 8), x2 = c(9, 10))

  # Call the predict function
  predictions <- predict.linear_regression(model, newdata)

  # Check whether predictions are numeric and compare size
  expect_type(predictions, "double")
  expect_length(predictions, nrow(newdata))
})

# Test invalid object class
test_that("predict.linear_regression handles invalid object class", {
  # Invalid object
  invalid_object <- list()

  # Verify error message when object is not of class 'linear_regression'
  expect_error(
    predict.linear_regression(invalid_object, data.frame(x1 = c(1, 2), x2 = c(3, 4))),
    "Object must be of class 'linear_regression'"
  )
})

# Test missing or mismatched columns in newdata
test_that("predict.linear_regression handles missing or mismatched columns in newdata", {
  # Create a valid linear regression model
  X <- data.frame(x1 = c(1, 2, 3, 4), x2 = c(5, 6, 7, 9))
  y <- c(10, 20, 30, 40)
  model <- linear_regression(X, y)

  # Provide newdata with missing columns
  newdata <- data.frame(x1 = c(7, 8))  # Missing x2

  # Verify error message for missing columns
  expect_error(
    predict.linear_regression(model, newdata),
    "Column names of newdata must match the independent variables in the model."
  )
})

# Test edge case with empty newdata
test_that("predict.linear_regression handles empty newdata", {
  # Create a valid linear regression model
  X <- data.frame(x1 = c(1, 2, 3, 4), x2 = c(5, 6, 7, 9))
  y <- c(10, 20, 30, 40)
  model <- linear_regression(X, y)

  # Provide empty newdata
  newdata <- data.frame(x1 = numeric(0), x2 = numeric(0))

  # Verify predictions are empty
  predictions <- predict.linear_regression(model, newdata)
  expect_length(predictions, 0)
})
