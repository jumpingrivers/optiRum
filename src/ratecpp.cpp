#include <Rcpp.h>
using namespace Rcpp;

//'  Calculates compounded interest rate
//' 
//' @param nper Number of periods
//' @param pmt Instalment per period (should be negative)
//' @param pv Present value i.e. loan advance (should be positive)
//' @export
// [[Rcpp::export]]
NumericVector ratecpp(int nper,int pmt, int pv) {
  double rate1 = 0.01;
  double rate2 = 0.005;
  NumericVector newrate = 0;
  int n = 10;
  
  for(int i = 0; i < n; i++) {
    double pv1 = -pmt/rate1*(1 - 1/(pow(1 + rate1, nper)))  - pv;
    double pv2 = -pmt/rate2*(1 - 1/(pow(1 + rate2, nper)))  - pv;
      
    if (pv1 != pv2) {
      NumericVector newrate = (pv1 * rate2 - pv2 * rate1)/(pv1 - pv2);
    }
      
    if (std::abs(pv1) > std::abs(pv2)) {
      NumericVector rate1 = newrate;
    } 
    else {
      NumericVector rate2 = newrate;
    }
  }
  return rate1;
}
  //return ratecpp(nper, pmt, pv, fv);



// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,3000))
ratecpp(df$nper, df$pmt, df$pv)
*/
