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
  NumericVector pv = size_d;
  //double pvof = 0;
  for (int i = 0; i < size_d; i++) {
    
    double rate_i = rate[i];
    double nper_i = nper[i];
    const double pvof = -pmt[i]/rate_i * (1 - 1/std::pow(1 + rate_i, nper_i));
    // round to the second decimal
    double pv_round = (int)(pvof * 100 + .5)/100.0;
    //std::setprecision(2);
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
pv_cpp(df$rate,df$nper,df$pmt)
*/
