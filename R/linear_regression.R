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
#' X <- matrix(c(1, 2, 3), ncol = 1)
#' y <- c(10, 20, 30)
#' model <- linear_regression(X, y)
#' print(model$coefficients)
#' @export


linear_regression <- function(X, y) {
  if (is.vector(X)) X <- data.frame(X)

  # Add an intercept column if not already present
  if (!any(colnames(X) == "Intercept")) X <- cbind(Intercept = 1, as.matrix(X))

  # Check that the number of rows in X matches the length of y
  if (nrow(X) != length(y)) stop("Number of rows in X must match the length of y")

  # Compute regression coefficients(Where compute_coefficient fucntion is defined in the compute_coefficients.cpp)
  betahat <- compute_coefficients(X, y)
  # Compute residuals(where compute_residuals function is defined in the compute-residuals.cpp)
  residuals <- compute_residuals(X, y, betahat)

  names(betahat) <- colnames(X)

  # Return a structured object with the class "linear_regression"
  structure(
    list(coefficients = as.vector(betahat), X = X, y = y, residuals = residuals),
    class = "linear_regression"
  )
}

