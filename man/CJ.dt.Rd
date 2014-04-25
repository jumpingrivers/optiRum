\name{CJ.dt}
\alias{CJ.dt}
\title{Cross join two data.tables}
\usage{
CJ.dt(X, Y)
}
\arguments{
  \item{X}{A data.table}

  \item{Y}{A data.table}
}
\value{
dt A data.table
}
\description{
The package data.table has a CJ() function which produces a
data.table out of two vectors. This function does the
Cartesian product of two data.tables instead.
}
\examples{
library(data.table)
a  <- data.table(a=1:2, b=letters[1:2])
b  <- data.table(c=3:4, d=letters[3:4])
ab <- CJ.dt(a,b)
}
\seealso{
Other helper: \code{\link{convertToXML}};
\code{\link{generatePDF}}; \code{\link{sanitise}}
}
\keyword{CJ}
\keyword{data.table}

