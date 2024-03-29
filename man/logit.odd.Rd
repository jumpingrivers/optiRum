% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logit.odd.R
\name{logit.odd}
\alias{logit.odd}
\title{Convert a logit to odds}
\usage{
logit.odd(logit)
}
\arguments{
\item{logit}{The log(odds)}
}
\value{
odds Odds
}
\description{
Transform a logit response from a glm into odds
}
\examples{
logit.odd(0) # equals 1
}
\seealso{
\code{\link{logit.prob}}

Other creditrisk: 
\code{\link{giniChart}()},
\code{\link{giniCoef}()},
\code{\link{logit.prob}()},
\code{\link{odd.logit}()},
\code{\link{odd.prob}()},
\code{\link{prob.logit}()},
\code{\link{prob.odd}()},
\code{\link{scaledScore}()}
}
\concept{creditrisk}
\keyword{glm}
\keyword{logit}
\keyword{odds}
