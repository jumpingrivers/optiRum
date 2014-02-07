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

logit.prob<-function(logit){
  odd.prob(logit.odd(logit))
}