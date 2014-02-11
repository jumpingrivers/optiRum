\name{theme_optimum}
\alias{theme_optimum}
\title{Produce an Optimum-standard base chart}
\usage{
theme_optimum(base_size = 14, base_family = "", ...)
}
\arguments{
  \item{base_size}{Anchor font size}

  \item{base_family}{Font family to use}

  \item{...}{Allows additional parameters to be passed to
  further themes}
}
\description{
This theme builds on the Stephen Few theme from ggthemes to
produce a good baseline for charting in R. Gets called as
would any typical theme.
}
\examples{
library("ggplot2")
ggplot(data.frame(x=1:10,y=1:10),aes(x,y))+theme_optimum()+geom_line()
}
\keyword{Few}
\keyword{ggplot2}
\keyword{theme}

