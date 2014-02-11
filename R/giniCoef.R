#' Produce a gini coefficient
#'
#' This function calculates a Gini coefficient based on a Receiver Operator Curve.
#'
#' @param pred Logit/scores/probabilities to be compared against actuals
#' @param act This should be a column containing outcomes in a boolean form either as a factor or number
#' 
#' @return gini The coefficient
#' 
#' @keywords gini roc AUROC 
#' 
#' @seealso AUC roc giniChart
#'
#' @export
#' 

giniCoef<-function(pred,act){
stopifnot(
  is.numeric(pred),
  nlevels(factor(act))<=2
)
require("AUC")
act<-factor(act)
data<-roc(pred,act)

return(2*(auc(data)-.5))
}