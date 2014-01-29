#' Convert a logit to probability
#'
#' Transform a logit response from a glm into probability
#'
#' @param logit The log(odds)
#' @return prob Probability
#' 
#' @keywords logit probability glm 
#' 
#' @seealso glm
#'
#' @export

logit.probs<-function(logit){
  odds.prob(logit.odds(logit))
}