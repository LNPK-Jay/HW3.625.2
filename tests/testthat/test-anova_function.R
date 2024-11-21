library(testthat)
library(HW3.625.2)
# Test ANOVA function with a valid linear regression object
test_that("anova.linear_regression works with valid input", {
  # Common input data
  X <- matrix(c(1, 2, 3), ncol = 1)
  y <- c(2, 4, 6)

  # Create a linear regression model
  model <- linear_regression(X, y)

  # Use the ANOVA function
  result <- anova.linear_regression(model)

  # Check weather the result is a dataframe
  expect_s3_class(result, "data.frame")
})

# Test ANOVA function with invalid input
test_that("anova.linear_regression handles invalid input gracefully", {
  # Invalid input: Not a linear_regression object
  expect_error(
    anova.linear_regression(list()),
    "The object must be of class 'linear_regression'"
  )
})
