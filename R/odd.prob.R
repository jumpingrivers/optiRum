#' Convert an odds to probability
#'
#' Transform odds into a probability
#'
#' @param odds Odds
#' @return prob Probability
#' 
#' @keywords odds probability 
#' 
#'
#' @export

odd.prob<-function(odds){
  odds/(1+odds)
}