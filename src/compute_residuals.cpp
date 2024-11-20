#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector compute_residuals(NumericMatrix X, NumericVector y, NumericVector betahat) {
  int n = X.nrow(); // Get the number of row
  NumericVector residuals(n); // initial the residual vector
  
  // calculate the residual for each row
  for (int i = 0; i < n; i++) {
    double predicted = 0.0;
    for (int j = 0; j < X.ncol(); j++) {
      predicted += X(i, j) * betahat[j];
    }
    residuals[i] = y[i] - predicted;
  }
  
  return residuals;
}
