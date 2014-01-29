#' Convert a logit to odds
#'
#' Transform a logit response from a glm into odds
#'
#' @param logit The log(odds)
#' @return odds Odds
#' 
#' @keywords logit odds glm 
#' 
#' @seealso glm
#'
#' @export

logit.odds<-function(logit){
  exp(logit)
}