#' Summary for Linear Regression model
#'
#' This function computes and displays diagnostic statistics for a linear regression model
#' fitted using the `linear_regression` function. It provides information about the model's
#' residuals, coefficients, and goodness of fit.
#'
#' @param object An object of class `linear_regression` created by the `linear_regression` function.
#' @return A list containing:
#'   \item{Call}{The matched function call.}
#'   \item{Residuals}{Summary statistics of the residuals.}
#'   \item{Coefficients}{Estimated regression coefficients.}
#'   \item{t.value}{T statistic value}
#'   \item{pr...t..}{P value}
#'   \item{Residual standard error}{An estimate of the residual standard deviation.}
#'   \item{R-squared and Adjusted R-squared}{Measures of the goodness of fit of the model.}
#'
#' @examples
#' # Generate example data
#' set.seed(47)
#' X <- cbind(rnorm(100), rnorm(100))
#' y <- 2 * X[, 1] - X[, 2] + rnorm(100)
#' model <- linear_regression(X, y)
#' summary(model)
#' @export
#'
summary.linear_regression <- function(object) {

  # Get the components from the linear regression model object
  coefficients <- object$coefficients
  X <- object$X
  y <- object$y
  residuals <- object$residuals
  #fitted_values <- as.vector(X %*% coefficients)

  # Compute degrees of freedom
  n <- length(y)
  p <- length(coefficients)
  df <- n - p

  # Estimate residual variance
  sigma_squared <- sum(residuals^2) / df

  # Calculate standard errors, t-statistics, and p-values for coefficients
  XTX_inv <- solve(t(X) %*% X)
  se_betahat <- sqrt(diag(XTX_inv) * sigma_squared)
  t_statistic <- coefficients / se_betahat
  p_value <- 2 * (1 - pt(abs(t_statistic), df))

  # Calculate R^2 and adjusted R^2
  total_variance <- sum((y - mean(y))^2)
  explained_variance <- total_variance - sum(residuals^2)
  r_squared <- explained_variance / total_variance
  adj_r_squared <- 1 - (1 - r_squared) * (n - 1) / df

  #print the summary of the model
  cat("Call:\n")
  print(object$call)
  cat("\nResiduals:\n")
  print(summary(residuals))
  cat("\nCoefficients:\n")
  print(data.frame(
    Estimate = coefficients,
    Std.Error = se_betahat,
    t.value = t_statistic,
    Pr...t.. = p_value,
    row.names = names(coefficients)
  ))
  cat("\nResidual standard error:", sqrt(sigma_squared), "on", df, "degrees of freedom\n")
  cat("Multiple R-squared:", r_squared, ", Adjusted R-squared:", adj_r_squared, "\n")
}

