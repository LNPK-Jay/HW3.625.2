#' Predict function for linear regression model
#'
#' This function calculates predictions for new data based on a linear regression model.
#'
#' @param object An object of class `linear_regression` created by the `linear_regression` function.
#' @param newdata A data frame of new input data. It should have the same column names
#' as the independent variables used in the model fitting, excluding the intercept.
#' @return A vector of predicted values.
#' @examples
#' X <- data.frame(x1 = c(1, 2, 3), x2 = c(2, 4, 6.1))
#' y <- c(10, 20, 30)
#' model <- linear_regression(X, y)
#' newdata <- data.frame(x1 = c(7, 8), x2 = c(9, 10))
#' predictions <- predict.linear_regression(model, newdata)
#' print(predictions)
#' @export
#'

predict.linear_regression <- function(object, newdata) {
  # check weather the input object is a 'linear regression'
  if (!inherits(object, "linear_regression")) stop("Object must be of class 'linear_regression'")

  # Ensure the new data has matching column names ( Exclude "Intercept")
  model_columns <- colnames(object$X)[-1]
  if (!all(model_columns %in% colnames(newdata))) {
    stop("Column names of newdata must match the independent variables in the model.")
  }

  # Reorder columns of new data to match the model's column order
  newdata <- newdata[model_columns]

  # Add intercept
  newdata <- cbind(Intercept = 1, as.matrix(newdata))

  # Ensure coefficients are a numeric matrix
  coefficients <- as.matrix(object$coefficients)

  # Compute predictions
  predicted_values <- newdata %*% coefficients

  return(as.vector(predicted_values))
}
