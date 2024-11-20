#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector compute_coefficients(NumericMatrix X, NumericVector y) {
  Environment base = Environment::namespace_env("base");
  Function crossprod = base["crossprod"];
  Function solve = base["solve"];
  NumericMatrix XtX = crossprod(X);
  NumericVector XtY = crossprod(X, y);
  NumericVector coefficients = solve(XtX, XtY);
  return coefficients;
}
