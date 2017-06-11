#' Simplify Polyline
#'
#' simplifies a polyline using a vector-clustering algorithm
#'
#' @param polyline encoded string of a polyline
#' @param distanceTolerance in metres
#' @export
SimplifyPolyline <- function(polyline, distanceTolerance = 1000){

	# if(!is.null(polyline) & (!is.null(lat) | !is.null(lon)))
	# 	stop("Please provide either an encoded polyline, or columns of lat/lon values")

	# isPolyline <- FALSE
	# if(!is.null(polyline)){
	# 	isPolyline <- TRUE
		df <- googleway::decode_pl(polyline)
	# }else{
	# 	df <- data.frame(lat = lat, lon = lon)
	# }

	df <- rcppSimplifyPolyline(df, distanceTolerance, 1e+9, earthsRadius())
	# if(isPolyline){
		return(googleway::encode_pl(df[, 'lat'], df[, 'lon']))
	# }else{
	# 	## put names back to what they were
	# 	df <- stats::setNames(df, c(lat, lon))
	# 	return(df)
	# }
}
