\name{RATE}
\alias{RATE}
\title{Calculates compounded interest rate}
\usage{
RATE(nper, pmt, pv)
}
\arguments{
  \item{nper}{Number of periods}

  \item{pmt}{Instalment per period (should be negative)}

  \item{pv}{Present value i.e. loan advance (should be
  positive)}
}
\value{
rate The corresponding compound interest rate required to
arrive at an FV of 0
}
\description{
Based on loan term, instalment, and the loan amount, this
function calculates the associated compound interest rate.
This function is designed to be equivalent to the Excel
function RATE.  It calculates a fixed interest rate.
}
\keyword{financial}
\keyword{pmt}
\keyword{pv}

