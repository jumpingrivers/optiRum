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
  // if (isnumber(nper) && isnumber(pmt))
  // {
  //   printf ("Error opening file");
  // }
  
  // else 
  // {
    pow(pmt, nper);
    double rate1 = 0.01;
    double rate2 = 0.005;
    NumericVector x = 1 + rate1;
    NumericVector y = 1 + rate2;
    NumericVector newrate = 0;
    int n = 10;
    
    std::vector<double> res(x.size());
    NumericVector power2 = pow(y, nper);
    std::transform(x, x.begin(), x.end(), nper.begin(), res.begin(), ::pow);
    for(int i = 0; i < n; i++) {
      
    NumericVector pv1 = -pmt/rate1 * (1 - 1/(power1)) - pv;
    NumericVector pv2 = -pmt/rate2 * (1 - 1/(power2)) - pv;
    
    
      // Convert the elemnt of the double vector to a double
     //  double pv1_0 = pv1[0];
     //  Rcpp::Rcout << pv1_0;
     // //Rf_PrintValue(pv1_0);
     //  //double pv1_1 = pv1[1];
     //  double pv2_0 = pv2[0];
     //  Rcpp::Rcout << pv2_0;
     //  //double pv2_1 = pv2[1];
     
     LogicalVector pv12 = pv1 != pv2;
      if (pv12) {
        //double newrate = (pv1 * rate2 - pv2 * rate1)/(pv1 - pv2);
      //NumericVector newrate = NumericVector::create((pv1 * rate2 - pv2 * rate1)/(pv1 - pv2));
      NumericVector newrate = (pv1 * rate2 - pv2 * rate1)/(pv1 - pv2);
      std::cout <<  newrate << std::endl;
      return newrate;
      }
      
      // Create a Logical vector to compare abs of pv1 and pv2.
      LogicalVector pv12_abs = abs(pv1) > abs(pv2);
      if (pv12_abs) {
        NumericVector rate1 = newrate;
        return rate1;
      } else {
        NumericVector rate2 = newrate;
        return rate2;
      }
    }
    return rate1;
    //return newrate;
  // }
  //return ratecpp(nper, pmt, pv);
}



// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,3000))
ratecpp(df$nper,df$pmt,df$pv)
*/
