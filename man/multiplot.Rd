\name{multiplot}
\alias{multiplot}
\title{Multiple plot function}
\usage{
multiplot(..., plotlist = NULL, cols = 1, layout = NULL)
}
\arguments{
  \item{plotlist}{a list of ggplot objects}

  \item{cols}{Number of columns in layout}

  \item{layout}{A matrix specifying the layout. If present,
  'cols' is ignored}

  \item{...}{ggplot objects can be passed in ...}
}
\description{
Multiplot allows the laying out of multiple charts in a
custom layout
}
\details{
If the layout is something like matrix(c(1,2,3,3), nrow=2,
byrow=TRUE), then plot 1 will go in the upper left, 2 will
go in the upper right, and 3 will go all the way across the
bottom.

Code is taken as-is from
\url{http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/}
and no tests are maintained for it at present
}

