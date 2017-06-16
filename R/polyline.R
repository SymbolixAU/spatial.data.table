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
#' @param distanceTolerance in metres
#' @export
SimplifyPolyline <- function(polyline, distanceTolerance = 1000, type = c("simple", "complex")){

	# if(!is.null(polyline) & (!is.null(lat) | !is.null(lon)))
	# 	stop("Please provide either an encoded polyline, or columns of lat/lon values")

	## df <- googleway::decode_pl(polyline)

	# if(type == "simple"){
	# 	df <- rcppSimplifyPolyline(df, distanceTolerance, 1e+9, earthsRadius())
	# }else if(type == "complex"){
	# 	df <- rcppDouglasPeucker(df[, 'lat'], df[, 'lon'], 1, nrow(df), distanceTolerance)
	# }

	rcppDouglasPeucker(polyline, distanceTolerance)

	##return(googleway::encode_pl(df[, 'lat'], df[, 'lon']))

}
