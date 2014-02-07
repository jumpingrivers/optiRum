#' Convert a probability into a logit
#'
#' Transforming probabilities into logits (the response from binomial glms)
#'
#' @param prob Probability
#' @return logit Log(odds)
#'
#' 
#' @keywords probability odds logit glm 
#' 
#'
#' @export
prob.logit<-function(prob){
  odd.logit(prob.odd(prob))
}