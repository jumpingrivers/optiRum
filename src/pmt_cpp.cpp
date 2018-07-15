#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
//' @param rate The nominal interest rate per period (should be positive)
//' @param nper Number of periods
//' @param pv Present value i.e. loan advance (should be positive)
//' @export 
// [[Rcpp::export]]
NumericVector pmt_cpp(NumericVector rate, NumericVector nper, NumericVector pv) {
  int size_d = nper.size();
  NumericVector pmt = size_d;
  
  for (int i = 0; i < size_d; i++) {
    double rate_i = rate[i];
    double nper_i = nper[i];
    const double pmt_r = -pv[i] * rate_i/(1 - 1/std::pow(1 + rate_i, nper_i));
    // round to the second decimal
    double pvmt_round = floor(pmt_r * 100.0 + .5)/100.0;
    pmt[i] = pvmt_round;
  }
  return pmt;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(rate=c(.1,.2),nper=c(12,24),pv=c(3000,1000))
pmt_cpp(df$rate,df$nper,df$pv)
*/
