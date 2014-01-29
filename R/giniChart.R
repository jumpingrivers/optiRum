#' Produce a ROC curve with gini coefficient title
#'
#' This function uses ggplot to produce a themed Receiver Operator Curve and
#' calculates a Gini coefficient based on it.
#'
#' @param pred Logit/scores/probabilities to be compared against actuals
#' @param act This should be a column containing outcomes in a boolean form either as a factor or number
#' @param gini If provided with a name, the function will output the gini value to a variable
#' 
#' @keywords gini roc AUROC 
#' 
#' @seealso AUC roc
#'
#' @export

giniChart<-function(pred,act,gini=""){
  stopifnot(
    is.numeric(pred),
    is.numeric(act)|is.factor(act),
    is.character(gini)
  )
  optiplum()
  
  act<-factor(act)
  data<-roc(pred,act)
  
  coef<-2*(auc(data)-.5)
  if (gini!="") {assign(gini,2*(auc(data)-.5),.GlobalEnv)}
  
  ginidata<-data.frame(fpr=data$fpr,tpr=data$tpr)
    
  ggplot(ginidata,aes(x=fpr,y=tpr,colour=optiplum))+
    theme_optimum()+geom_line()+
    scale_colour_identity()+
    geom_line(aes(x=fpr,y=fpr,colour="grey"))+
    scale_x_continuous(labels= percent)+scale_y_continuous(labels= percent)+
    labs(x="1-Specificity",y="Sensitivity",title=paste0("Gini = ",percent(coef)))
  
}