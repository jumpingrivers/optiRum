#' Calculates compounded interest rate
#'
#' Based on loan term, instalment, and the loan amount, this function calculates 
#' the associated compound interest rate.  This function is designed to be 
#' equivalent to the Excel function RATE.  It calculates a fixed interest rate.
#'
#' @param nper Number of periods
#' @param pmt Instalment per period (should be negative)
#' @param pv Present value i.e. loan advance (should be positive)
#' @return rate The corresponding compound interest rate required to arrive at an FV of 0
#'
#' 
#' @keywords financial pv pmt
#' 
#'
#' @export
#' 

RATE <- function(nper, pmt, pv) {
  stopifnot(nper>=1,pmt<0,pv>0)
  rate<-function(nper, pmt, pv) {
        rate1 <- 0.01
        rate2 <- 0.005
        for (i in 1:10) {
          
          pv1 <- PV(rate1, nper, pmt) - pv
          pv2 <- PV(rate2, nper, pmt) - pv
          
          if (pv1!=pv2){
            newrate <- (pv1 * rate2 - pv2 * rate1) / (pv1 - pv2)
          }
          
          if (abs(pv1) > abs(pv2)) {
            rate1 <- newrate
          } else {
            rate2 <- newrate
          }
        }
        rate1
  }
rate<-Vectorize(rate)
return(rate(nper, pmt, pv))
}