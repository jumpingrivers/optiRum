#' Produce a string with one word per line
#' 
#' Designed for splitting strings to fit better on axis on charts
#' 
#' @param x string
#' @param ... Allows additional parameters to be passed to gsub
#' 
#' @keywords ggplot
#' @family helper 
#' 
#' @export
#' 
#' @examples
#' library('ggplot2')
#' names <- wordwrap(c("This is a name","Single"))
#' ggplot(data.frame(x=names,y=1:10),aes(x,y))+theme_optimum()+geom_line()
#' 
wordwrap <- function(x, ...) {
    gsub(pattern = "\\s", replacement = "\n", x, ...)
} 
