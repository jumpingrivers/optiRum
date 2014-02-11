\name{giniCoef}
\alias{giniCoef}
\title{Produce a gini coefficient}
\usage{
giniCoef(pred, act)
}
\arguments{
  \item{pred}{Logit/scores/probabilities to be compared
  against actuals}

  \item{act}{This should be a column containing outcomes in
  a boolean form either as a factor or number}
}
\value{
gini The coefficient
}
\description{
This function calculates a Gini coefficient based on a
Receiver Operator Curve.
}
\seealso{
AUC roc giniChart
}
\keyword{AUROC}
\keyword{gini}
\keyword{roc}

