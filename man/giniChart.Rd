\name{giniChart}
\alias{giniChart}
\title{Produce a ROC curve with gini coefficient title}
\usage{
giniChart(pred, act, gini = "")
}
\arguments{
  \item{pred}{Logit/scores/probabilities to be compared
  against actuals}

  \item{act}{This should be a column containing outcomes in
  a boolean form either as a factor or number}

  \item{gini}{If provided with a name, the function will
  output the gini value to a variable}
}
\description{
This function uses ggplot to produce a themed Receiver
Operator Curve and calculates a Gini coefficient based on
it.
}
\seealso{
AUC roc
}
\keyword{AUROC}
\keyword{gini}
\keyword{roc}

