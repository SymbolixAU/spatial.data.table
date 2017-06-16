#' Simplify Polyline
#'
#' simplifies a polyline using a vector-clustering algorithm
#'
#' This method computes the haversine distance between sequential sets of coordiantes,
#' and if they fall within the \code{distancetolerance} value the coordinates are discarded
#'
#' @details
#' The 'simple' \code{type} uses simple vector clustering to simplify the polyline,
#' which tests sequential coordinates to see if they fall within the \code{distanceTolerance}.
#'
#' The 'complex' \code{type} uses the recursive Douglas Peucker algorithm to simplify the polyline.
#'
#'
#' @param polyline encoded string of a polyline
#' @param type the type of algorithm used to simplify the polyline. One of 'simple' or 'complex'. See Details
#' @param distanceTolerance in metres. For \code{simple}, sequential points within this
#' distance are dropped. For \code{complex}, it is the distance away from each line
#' segment that determins if a point is kept (outside the distance is kept)
#'
#' @examples
#' \dontrun{
#'
#' library(googleway)
#'
#' dt_melbourne <- copy(googleway::melbourne)
#' setDT(dt_melbourne)
#' dt_melbourne[, dpSimple := SimplifyPolyline(polyline, 100, type = "complex")]
#' dt_melbourne[, Simple := SimplifyPolyline(polyline, 15000, type = "simple")]
#'
#' object.size(dt_melbourne$polyline)
#' object.size(dt_melbourne$dpSimple)
#' object.size(dt_melbourne$Simple)
#'
#' }
#'
#'
#'
#'
#' @export
SimplifyPolyline <- function(polyline, distanceTolerance = 100, type = c("simple", "complex")){

  if(type == "simple"){
  	## the 'simple' method uses dtDist2gc, which requires another tolerance an earth radius
  	return(rcppSimplifyPolyline(polyline, distanceTolerance, 1e+9, earthsRadius()))
  }else{
		return(rcppDouglasPeucker(polyline, distanceTolerance))
  }

}
