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
\examples{
sampledata<- data.frame(val= rnorm(100) , outcome=rbinom(100,1,.8))
  giniCoef(sampledata$val,sampledata$outcome)
}
\seealso{
\code{AUC} \code{roc} \code{\link{giniChart}}

Other creditrisk: \code{\link{giniChart}};
\code{\link{logit.odd}}; \code{\link{logit.prob}};
\code{\link{odd.logit}}; \code{\link{odd.prob}};
\code{\link{prob.logit}}; \code{\link{prob.odd}};
\code{\link{scaledScore}}
}
\keyword{AUROC}
\keyword{gini}
\keyword{roc}

