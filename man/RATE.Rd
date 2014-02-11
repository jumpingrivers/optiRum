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
\examples{
RATE(12,-500,3000) # 0.126947 Taken from excel

df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,3000))
RATE(df$nper,df$pmt,df$pv)  # c(0.126947,0.080927) Taken from excel
}
\seealso{
\code{\link{PMT}} \code{\link{PV}}

Other finance: \code{\link{APR}}; \code{\link{PMT}};
\code{\link{PV}}
}
\keyword{financial}
\keyword{pmt}
\keyword{pv}
\keyword{rate}

