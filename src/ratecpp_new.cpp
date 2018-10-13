#include <Rcpp.h>
#include <Rinternals.h>
using namespace Rcpp;

//'  Calculates compounded interest rate
//' 
//' @param nper Number of periods
//' @param pmt Instalment per period (should be negative)
//' @param pv Present value i.e. loan advance (should be positive)
//' @export
// [[Rcpp::export]]

NumericVector ratecpp_new(NumericVector nper, NumericVector pmt, NumericVector pv,
                          NumericVector fv = 0,
                          double guess1 = NA_REAL, double guess2 = NA_REAL, 
                          int max_iteration = 20, double tollerance = 1e-8) 
{
    // max lenght of pmt and initial vector
    int size_d = pmt.size();
    NumericVector rate(size_d);
    NumericVector regcashfactor(size_d);
    DoubleVector newguess1 = 0;
    DoubleVector newguess2 = 0;
    DoubleVector newrate = 0;
    DoubleVector pv1 = size_d;
    DoubleVector pv2 = size_d;
    //int n = 10;
    for(int j = 0; j < max_iteration; j++) {
      
      //Rcpp::Rcout << "j:" << j << std::endl;
      // Convert  guees1 in a logical vector to apply the if condition about the missing value.
      //LogicalVector guess_na1 = is_na(guess1);
      //LogicalVector guess_na2 = is_na(guess2);
      
      //Rprintf("1\n");
      if (DoubleVector::is_na(guess1)) {
        guess1 = -2 * (pv[j] + pmt[j] * nper[j]) / pv[j] / nper[j];
      }
      //Rprintf("2\n");
      //  Rcpp::Rcout << "guess1:" << guess1 << std::endl;
      //Rcpp::Rcout << pv[j] + pmt[j] << std::endl;
      if (DoubleVector::is_na(guess2)) {
        guess2 = 0;
      }
      //Rcpp::Rcout << "guess2:" << guess2 << std::endl;
      // ======= this is the function pv =========================================
      double nper_i = nper[j];
      //double guess1_i = guess1[j];
      if (guess1 == 0) {
        regcashfactor[j] = 1/ (1 / nper[j]);
      } else {
        regcashfactor[j] = 1/ (guess1 / (1 - 1 / std::pow(1 + guess1, nper_i)));
      }
      const double pvof1 = -pmt[j] * regcashfactor[j] - pv[j];
      double pv1_round = floor(pvof1 * 100 + .5)/100.0;
      pv1[j] = pv1_round;
      

      if (guess2 == 0) {
        regcashfactor[j] = 1/ (1 / nper[j]);
      } else {
        regcashfactor[j] = 1/ (guess2 / (1 - 1 / std::pow(1 + guess2, nper_i)));
      }
      const double pvof2 = -pmt[j] * regcashfactor[j] - pv[j];
      double pv2_round = floor(pvof2 * 100 + .5)/100.0;
      pv2[j] = pv2_round;
     // =====================================================================
      //Rcpp::Rcout << "pv1:" << pv1[j] << std::endl;
      //Rcpp::Rcout << "pv2:" << pv2[j] << std::endl;


      // Create logical vector for pv1 == pv2
      LogicalVector pv1eq2 = pv1 == pv2;
      LogicalVector pv1grpv2 = abs(pv1) > abs(pv2);
      LogicalVector pv1lspv2 = abs(pv1) < abs(pv2);
      //LogicalVector guess12 = (guess1 - guess2);
      
      if (pv1eq2 || std::abs(guess1 - guess2) < tollerance || max_iteration<=0){
        if(std::abs(guess1 - guess2) < tollerance) {
          //rate[j] = guess1;
          return guess1;
        } else {
        }
      } else {
        DoubleVector newrate = (pv1[j] * guess2 - pv2[j] * guess1)/(pv1[j] - pv2[j]);
        //Rcpp::Rcout << "newrate:" << newrate << std::endl;
        //Rcpp::print(newrate);
        if (pv1grpv2) {
          DoubleVector newguess1 = newrate;
          //Rcpp::Rcout << "newguess1:" << newguess1 << std::endl;
          //Rcpp::print(newguess1);
          DoubleVector newguess2 = guess2;
          } //rate[j] = floor(newguess1 * 100 + .5)/100.0;
        //return rate;
        //Rprintf("6\n");
        if (pv1lspv2) {
        {
          DoubleVector newguess1 = guess1;
          DoubleVector newguess2 = newrate;
        } //rate[j] = floor(newguess2 * 100 + .5)/100.0;
      }
      //Rprintf("7\n");
      
    }
    //return rate;
 }
return newrate;

}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,4000))
ratecpp_new(df$nper,df$pmt,df$pv) 
*/
