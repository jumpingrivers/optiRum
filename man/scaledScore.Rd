\name{scaledScore}
\alias{scaledScore}
\title{Produce a scaled score based on a logit}
\usage{
scaledScore(logit, offset = 300, scale = 50)
}
\arguments{
  \item{logit}{Logit to be scaled}

  \item{offset}{Midrange, default is 300}

  \item{scale}{Value in which odds are double, default is
  50}
}
\value{
score scaled score
}
\description{
This function takes a logit and scales based on an
intercept and doubling of odds ratio
}
\keyword{glm}
\keyword{logit}
\keyword{score}

