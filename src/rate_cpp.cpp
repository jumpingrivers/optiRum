#include <Rcpp.h>
using namespace Rcpp;

//'  Calculates compounded interest rate
//' 
//' @param nper Number of periods
//' @param pmt Instalment per period (should be negative)
//' @param pv Present value i.e. loan advance (should be positive)
//' @export
// [[Rcpp::export]]
NumericVector ratecpp(const NumericVector nper, const NumericVector pmt, const NumericVector pv) 
{
    // max lenght of pmt and initial vector
    int size_d = pmt.size();
    NumericVector rate = size_d;
    int n = 10;
    for(int j = 0; j < size_d ; j++) {
      double rate1 = 0.01;
      double rate2 = 0.005;
      for(int i = 0; i < n; i++) {
      
        double nper_i = nper[j];
        
        const double pv1 = -pmt[j]/rate1 * (1 - 1/(std::pow(1 + rate1, nper_i))) - pv[j];
        const double pv2 = -pmt[j]/rate2 * (1 - 1/(std::pow(1 + rate2, nper_i))) - pv[j];
        
        if (std::abs(pv1) > std::abs(pv2)) {
          rate1 = (pv1 * rate2 - pv2 * rate1)/(pv1 - pv2);
        } else {
          rate2 = (pv1 * rate2 - pv2 * rate1)/(pv1 - pv2);
          }
      }
      rate[j] = rate1;
    }
    return rate;
}



// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,3000))
ratecpp(df$nper,df$pmt,df$pv)
*/
