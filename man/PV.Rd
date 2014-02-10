\name{PV}
\alias{PV}
\title{Calculates the present value}
\usage{
PV(rate, nper, pmt)
}
\arguments{
  \item{rate}{The nominal interest rate per period (should
  be positive)}

  \item{nper}{Number of periods}

  \item{pmt}{Instalment per period (should be negative)}
}
\value{
pv Present value i.e. loan advance (should be positive)
}
\description{
Based on period interest rate, number of periods, and
instalment, this function calculates the present value of
the loan such that it would be paid off fully at the end of
the loan. This function is designed to be equivalent to the
Excel function PV. It calculates based on a fixed interest
rate, FV=0 and charging is at the end of the period.
Response is rounded to 2dp
}
\keyword{financial}
\keyword{pmt}
\keyword{pv}

