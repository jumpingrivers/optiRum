\name{thousands_format}
\alias{thousands}
\alias{thousands_format}
\title{Thousands formatter: format number with commas separating the number thousands and suffixed with a k.
Based heavily on the scales work by Hadley}
\usage{
thousands_format()

thousands(x)
}
\arguments{
  \item{x}{a numeric vector to format}
}
\value{
a function with single paramater x, a numeric vector, that
returns a character vector
}
\description{
Thousands formatter: format number with commas separating
the number thousands and suffixed with a k. Based heavily
on the scales work by Hadley
}
\examples{
thousands_format()(c(1, 1e3, 2000, 1e6))
thousands_format()(c(1, 1e3, 2000, 1e6))
thousands(c(1, 1e3, 2000, 1e6))
}

