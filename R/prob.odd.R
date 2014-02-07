#' Convert a probability into odds probability
#'
#' Transform probabilities into odds
#'
#' @param prob Probability
#' @return odds Odds
#'
#' 
#' @keywords odds probability 
#' 
#'
#' @export

prob.odd<-function(prob){
  prob/(1-prob)
}