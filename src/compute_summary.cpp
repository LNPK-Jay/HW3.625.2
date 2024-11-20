#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector calculateSEBetaHat(NumericMatrix X, double sigma_squared) {
  Environment base = Environment::namespace_env("base");
  Function crossprod = base["crossprod"];
  Function solve = base["solve"];

  NumericMatrix XTX = crossprod(X);
  NumericMatrix XTX_inv = solve(XTX);

  NumericVector variances = XTX_inv.attr("diag");

  return sqrt(variances * sigma_squared);
}

// [[Rcpp::export]]
double calculateSigmaSquared(NumericVector residuals, int df) {
  double rss = sum(pow(residuals, 2));
  return rss / df;
}

// [[Rcpp::export]]
List calculateRSquared(NumericVector y, NumericVector residuals) {
  double total_variance = sum(pow(y - mean(y), 2));
  double rss = sum(pow(residuals, 2));
  double explained_variance = total_variance - rss;
  double r_squared = explained_variance / total_variance;
  double adj_r_squared = 1 - (1 - r_squared) * (y.size() - 1) / (y.size() - residuals.size());
  return List::create(
    _["r_squared"] = r_squared,
    _["adj_r_squared"] = adj_r_squared
  );
}

// [[Rcpp::export]]
NumericMatrix calculateCoefficientsStats(NumericVector coefficients, NumericVector se_betahat, int df) {
  NumericVector t_statistic = coefficients / se_betahat;
  NumericVector p_value = 2 * (1 - pt(abs(t_statistic), df));
  return cbind(coefficients, se_betahat, t_statistic, p_value);
}
