#' Calculates the present value
#'
#' Based on period interest rate, number of periods, and instalment, this function calculates 
#' the present value of the loan such that it would be paid off fully at the end of the loan.
#' This function is designed to be equivalent to the Excel function PV. 
#' It calculates based on a fixed interest rate, FV=0 and charging is 
#' at the end of the period. Response is rounded to 2dp
#'
#' @param rate The nominal interest rate per period (should be positive)
#' @param nper Number of periods
#' @param pmt Instalment per period (should be negative)
#' @return pv Present value i.e. loan advance (should be positive)
#'
#' @keywords financial pv pmt
#'
#' @export


PV<-function(rate, nper, pmt){
  stopifnot(rate>0,rate<1,nper>=1,pmt<0)
 return(round(-pmt / rate * (1 - 1 / (1 + rate) ^ nper),2))
}