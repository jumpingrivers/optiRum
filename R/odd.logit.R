#' Convert an odd into a logit
#'
#' Transforming odds into logits (the response from binomial glms)
#'
#' @param odds Odds
#' @return logit Log(odds)
#'
#' 
#' @keywords odds logit glm 
#' 
#'
#' @export

odd.logit<-function(odds){
  log(odds)
}