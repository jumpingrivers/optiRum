\name{APR}
\alias{APR}
\title{Calculates the compound interest rate for a loan}
\usage{
APR(nper, pmt, pv)
}
\arguments{
  \item{nper}{Number of periods - monthly}

  \item{pmt}{Instalment per period (should be negative)}

  \item{pv}{Present value i.e. loan advance (should be
  positive)}
}
\value{
rate The exffective interest rate per year
}
\description{
Based on period interest rate, number of periods, and loan
amount, this function calculates the compound annual
interest rate of the loan based on the monthly repayment.
It calculates based on a fixed interest rate, FV=0, and
charging is at the end of the period.
}
\keyword{apr}
\keyword{financial}
\keyword{pmt}
\keyword{pv}

