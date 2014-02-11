\name{sanitise}
\alias{sanitise}
\title{A cleaning function for special characters}
\usage{
sanitise(str)
}
\arguments{
  \item{str}{The text to be sanitised}
}
\description{
This function is a helper for cleaning xtable outputs in
preperation for PDF production
}
\examples{
sanitise("[&\%#<>\\\\")
}
\seealso{
Other helper: \code{\link{generatePDF}}
}
\keyword{PDF}
\keyword{Rnw}
\keyword{generate}
\keyword{knitr}
\keyword{pdflatex}

