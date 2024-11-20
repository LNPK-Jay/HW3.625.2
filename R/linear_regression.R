#' Linear Regression
#'
#' This function fits a linear regression model using the input independent variables
#' to predict the dependent variable.
#'
#' @param X A numerical vector or matrix, representing the independent variable(s).
#' @param y A numerical vector, representing the dependent variable.
#' @return A list containing:
#'   \item{coefficients}{Estimated regression coefficients.}
#'   \item{class}{The object is assigned the class \code{"linear_regression"}, allowing for customized methods (e.g., \code{print}, \code{summary}, or \code{predict}) tailored to this class.}
#'
#' @examples
#' # Example usage
#' X <- matrix(c(1, 2, 3, 4, 5, 6), ncol = 2)
#' y <- c(10, 20, 30)
#' model <- linear_regression(X, y)
#' model$coefficients
#' @export



linear_regression <- function(X, y) {
  if (is.vector(X)) X <- data.frame(X)
  if (!any(colnames(X) == "Intercept")) X <- cbind(Intercept = 1, as.matrix(X))

  if (nrow(X) != length(y)) stop("Number of rows in X must match the length of y")

  betahat <- compute_coefficients(X, y)
  names(betahat) <- colnames(X)

  structure(
    list(coefficients = as.vector(betahat), X = X, y = y),
    class = "linear_regression"
  )
}

