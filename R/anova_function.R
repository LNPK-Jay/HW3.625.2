
#' ANOVA for Linear Regression
#'
#' This file contains a function for performing an ANOVA (Analysis of Variance) for a linear regression model.
#'
#' @param object An object of class `linear_regression` created by the `linear_regression` function.
#' @return A summary table of the ANOVA analysis.
#' @examples
#' model <- linear_regression(X, y)
#' anova(model)
#'

anova.linear_regression <- function(object) {
  if (class(object) != "linear_regression") {
    stop("The object must be of class 'linear_regression'")
  }

  total_ss <- sum((object$y - mean(object$y))^2)
  residual_ss <- sum(object$residuals^2)
  regression_ss <- total_ss - residual_ss

  df_total <- length(object$y) - 1
  df_residual <- length(object$y) - length(object$coefficients)
  df_regression <- df_total - df_residual

  ms_regression <- regression_ss / df_regression
  ms_residual <- residual_ss / df_residual

  f_stat <- ms_regression / ms_residual
  p_value <- pf(f_stat, df_regression, df_residual, lower.tail = FALSE)

  anova_table <- data.frame(
    Source = c("Regression", "Residuals", "Total"),
    SS = c(regression_ss, residual_ss, total_ss),
    DF = c(df_regression, df_residual, df_total),
    MS = c(ms_regression, ms_residual, NA),
    F = c(f_stat, NA, NA),
    `P-Value` = c(p_value, NA, NA)
  )
  return(anova_table)
}
