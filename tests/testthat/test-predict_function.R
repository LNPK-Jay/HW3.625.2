library(testthat)
library(HW3.625.2)

test_that("predict.linear_regression works with valid input", {
  # Create a simple linear regression model with valid data
  X <- data.frame(x1 = c(1, 2, 3, 4), x2 = c(5, 6, 7, 9))
  y <- c(10, 20, 30, 40)
  model <- linear_regression(X, y)

  # New data for prediction
  newdata <- data.frame(x1 = c(7, 8), x2 = c(9, 10))

  # Call the predict function
  predictions <- predict.linear_regression(model, newdata)

  # Check weather predictions are numeric and compare size
  expect_type(predictions, "double")
  expect_length(predictions, nrow(newdata))
})
