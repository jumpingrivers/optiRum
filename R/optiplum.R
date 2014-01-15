#' Loads 'optiplum' into memory for use
#'
#' Produces a hex colour code for use in charts etc.  Use scale_colour_identity() with ggplots
#'
#' 
#' @keywords colour
#' 
#' @export
#' 
#' @examples{optiplum()}
#' 

optiplum<-function(){
  assign(
    x="optiplum",
    value=rgb(red=129,green=61,blue=114, maxColorValue = 255),
    envir=.GlobalEnv)
  }