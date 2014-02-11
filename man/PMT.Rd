\name{PMT}
\alias{PMT}
\title{Calculates the repayment for a loan}
\usage{
PMT(rate, nper, pv)
}
\arguments{
  \item{rate}{The nominal interest rate per period (should
  be positive)}

  \item{nper}{Number of periods}

  \item{pv}{Present value i.e. loan advance (should be
  positive)}
}
\value{
pmt Instalment per period (should be negative)
}
\description{
Based on period interest rate, number of periods, and loan
amount, this function calculates the repayment of the loan
such that it would be paid off fully at the end of the
loan. This function is designed to be equivalent to the
Excel function PMT. It calculates based on a fixed interest
rate, FV=0, and charging is at the end of the period.
Response is rounded to 2dp
}
\examples{
PMT(0.1,12,3000) # =-440.29 taken from excel

df<-data.frame(rate=c(.1,.2),nper=c(12,24),pv=c(3000,1000))
PMT(df$rate,df$nper,df$pv) # =-440.29,-202.55 taken from excel
}
\seealso{
\code{\link{PV}} \code{\link{RATE}}

Other finance: \code{\link{APR}}; \code{\link{PV}};
\code{\link{RATE}}
}
\keyword{financial}
\keyword{pmt}
\keyword{pv}

