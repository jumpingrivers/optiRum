#include <Rcpp.h>
using namespace Rcpp;

//'
//' @param rate The nominal interest rate per period (should be positive)
//' @param nper Number of periods
//' @param pmt Instalment per period (should be negative)
//' @param fv      Future value i.e. redemption amount
//' @export
// [[Rcpp::export]]
NumericVector pv_cpp(NumericVector rate, NumericVector nper, NumericVector pmt) {
  
  int size_d = pmt.size();
  NumericVector regcashfactor(size_d);
  NumericVector pv = size_d;
  //double pvof;
  for (int i = 0; i < size_d; i++) {
    
    double rate_i = rate[i];
    double nper_i = nper[i];
    
    //return ifelse(rate == 0, 1 / nper, rate / (1 - 1 / std::pow(1 + rate_i, nper_i)));
    if (rate[i] == 0) {
      regcashfactor[i] = 1/ (1 / nper[i]);
    } else {
      regcashfactor[i] = 1/ (rate[i] / (1 - 1 / std::pow(1 + rate_i, nper_i)));
    }
    const double pvof = -pmt[i] * regcashfactor[i]; 
    double pv_round = floor(pvof * 100 + .5)/100.0;
    pv[i] = pv_round;
  }
  
  return pv;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(rate=c(.1,.1),nper=c(12,24),pmt=c(-10,-15))
pv_cpp_new(df$rate,df$nper,df$pmt)
  */
