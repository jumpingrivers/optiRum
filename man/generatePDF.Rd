\name{generatePDF}
\alias{generatePDF}
\title{Convert an .Rnw file to a PDF}
\usage{
generatePDF(srcpath = getwd(), srcname, destpath = getwd(), destname,
  DATED = FALSE, CLEANUP = TRUE, ...)
}
\arguments{
  \item{srcpath}{Location of .Rnw file, default is current
  directory}

  \item{srcname}{Rnw file name without extension e.g.
  "Style"}

  \item{destpath}{Location of PDF file to be sent to,
  default is current directory}

  \item{destname}{PDF file name without extension e.g.
  "Style_output"}

  \item{DATED}{Boolean indicating whether PDF filename
  should include yyyymmdd added to it}

  \item{CLEANUP}{Boolean indicating whether ancilliary
  files should be removed after production}

  \item{...}{Allows additional parameters to be passed to
  the knit2pdf function}
}
\description{
This function is designed to handle the production task of
a 'standard' PDF process.  It is designed to build using
pdflatex an adequate number of times to enable full
typesetting to occur after taking into account items like
contents pages, glossaries, and figures.
}
\seealso{
knit2pdf which this function wraps
}
\keyword{PDF}
\keyword{Rnw}
\keyword{generate}
\keyword{knitr}
\keyword{pdflatex}

