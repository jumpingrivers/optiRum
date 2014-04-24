\name{generatePDF}
\alias{generatePDF}
\title{Convert an .Rnw file to a PDF}
\usage{
generatePDF(srcpath = getwd(), srcname, destpath = getwd(),
  destname = srcname, DATED = FALSE, CLEANUP = TRUE, QUIET = FALSE,
  envir = new.env(parent = .GlobalEnv), ...)
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

  \item{QUIET}{Boolean indicating whether console output
  should be limited}

  \item{envir}{Set default environment for knitr to run in
  - prevents a data.table issue}

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
\examples{
\dontrun{
# simple call
generatePDF(srcname="basic")

# complex call
generatePDF(
srcname="basic",
destpath=getwd(),
destname="basic",
DATED=TRUE,
CLEANUP=FALSE,
QUIET=TRUE,
compiler="xelatex")
}
}
\seealso{
\code{knit2pdf}

Other helper: \code{\link{CJ.dt}};
\code{\link{convertToXML}}; \code{\link{sanitise}}
}
\keyword{PDF}
\keyword{Rnw}
\keyword{generate}
\keyword{knitr}
\keyword{pdflatex}

