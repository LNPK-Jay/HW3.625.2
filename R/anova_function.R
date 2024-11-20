#' ANOVA for Linear Regression
#'
#' This function performs an ANOVA (Analysis of Variance) for a linear regression model.
#'
#' @param object An object of class `linear_regression` created by the `linear_regression` function.
#' @return A summary table of the ANOVA analysis.
#' @examples
#' model <- linear_regression(X, y)
#' anova(model)
#'

anova.linear_regression <- function(object) {
  # Check type of the object
  if (!inherits(object, "linear_regression")) {
    stop("The object must be of class 'linear_regression'")
  }

  # Get the components from the linear regression model object
  y <- object$y
  X <- as.matrix(object$X)
  coefficients <- object$coefficients
  residuals <- object$residuals

  # Calculate total SSY and Sigam^2
  total_ss <- sum((y - mean(y))^2)
  residual_ss <- sum(residuals^2)

  # Initialize regression SS and degrees of freedom
  regression_ss <- numeric(ncol(X) - 1)
  df_regression <- numeric(ncol(X) - 1)

  # Loop over predictors to calculate contribution of each variable
  for (i in 2:ncol(X)) {  #
    X_partial <- X[, c(1, i)]
    betahat_partial <- solve(t(X_partial) %*% X_partial) %*% t(X_partial) %*% y
    y_hat_partial <- X_partial %*% betahat_partial
    regression_ss[i - 1] <- sum((y_hat_partial - mean(y))^2)
    df_regression[i - 1] <- 1
  }

  # Compute residual degrees of freedom and mean square
  df_residual <- length(y) - ncol(X)
  ms_residual <- residual_ss / df_residual

  # # Calculate MS, F-statistics, and p-values
  ms_regression <- if (length(regression_ss) > 0) regression_ss / df_regression else numeric(0)
  f_stat <- if (length(ms_regression) > 0) ms_regression / ms_residual else numeric(0)
  p_values <- if (length(f_stat) > 0) {
    pf(f_stat, df_regression, df_residual, lower.tail = FALSE)
  } else {
    rep(NA, length(ms_regression))
  }


  # Create the ANOVA table
  anova_table <- data.frame(
    Source = c(colnames(X)[-1], "Residuals", "Total"),
    DF = c(df_regression, df_residual, sum(df_regression) + df_residual),
    SS = c(regression_ss, residual_ss, total_ss),
    MS = c(ms_regression, ms_residual, NA),
    F = c(f_stat, NA, NA),
    `P-Value` = c(p_values, NA, NA),
    stringsAsFactors = FALSE
  )


  return(anova_table)
}
