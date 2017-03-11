#' dt haversine
#' Calculates the Haversine distance between two points
#'
#'
#' @param latFrom latitude
#' @param lonFrom longitude
#' @param latTo latitude
#' @param lonTo latitude
#' @param r radius of earth
#' @return distance in metres
#' @examples
#' dt <- data.table(lat1 = seq(-38, -37, by = 0.1),
#'   lon1 = seq(144, 145, by = 0.1),
#'   lat2 = seq(-35, -34, by = 0.1),
#'   lon2 = seq(145, 146, by = 0.1))
#'
#' dt[, distance := dt.haversine(lat1, lon1, lat2, lon2)]
#'
#' @export
dtHaversine <- function(latFrom, lonFrom, latTo, lonTo, r = earthsRadius()){
	latTo <- toRadians(latTo)
	latFrom <- toRadians(latFrom)
	lonTo <- toRadians(lonTo)
	lonFrom <- toRadians(lonFrom)
	dLat <- (latTo - latFrom)
	dLon <- (lonTo - lonFrom)
	a <- (sin(dLat/2)^2) + (cos(latFrom) * cos(latTo)) * (sin(dLon/2)^2)
	return(2 * atan2(sqrt(a), sqrt(1 - a)) * r)
}


#' dt bearing
#'
#' Calculates the initial bearing between two pairs of latitude / longitude coordinates
#'
#' @note The initial bearing is sometimes called the 'forward azimuth', which if followed in a straight line along a great-circle arc will take you from teh start point to the end point
#' @param latFrom latitude from
#' @param lonFrom longitude from
#' @param latTo latitude to
#' @param lonTo longitude to
#' @param compassBearing logical indicating whether to return the value in the range 0 - 360
#' @return bearing in degrees
#' @examples
#' dtBearing(0,0,0,52)
#'
#' dtBearing(25, 0, 35, 0)
#'
#' dtBearing(25, 0, -25, 0)
#'
#' dtBearing(0, 0, 0, -1)
#' dtBearing(0, 0, 0, -1, compassBearing = TRUE)
#'
#' dtBearing(0, 0, 1, -1)
#'
#' dtBearing(0, 0, 0, 1)
#'
#' dtBearing(0, 0, 1, -0.001)
#' dtBearing(0, 0, 1, -0.001, compassBearing = TRUE)
#'
#' dtBearing(-37,144,-38,145)
#'
#' @export
dtBearing <- function(latFrom, lonFrom, latTo, lonTo, compassBearing = FALSE){
	latTo <- toRadians(latTo)
	latFrom <- toRadians(latFrom)
	lonTo <- toRadians(lonTo)
	lonFrom <- toRadians(lonFrom)

	Y <- sin(lonTo - lonFrom) * cos(latTo)
	X <- ( cos(latFrom) * sin(latTo) ) - ( sin(latFrom) * cos(latTo) * cos(lonTo - lonFrom) )

	return(ifelse(compassBearing, (toDegrees(atan2(Y, X)) + 360) %% 360, toDegrees(atan2(Y, X))))
}

#' dt midpoint
#'
#' Finds the half-way point along the great circle path between two points
#'
#' @param latFrom latitude from
#' @param lonFrom longitude from
#' @param latTo latitude to
#' @param lonTo longitude to
#' @return list of the latitude & longitude coordinates at the midpoint along the line
#' @examples
#' dtMidpoint(0,0,0,52)
#'
#' dtMidpoint(25, 0, -25, 0)
#'
#' dtMidpoint(-37,144,-38,145)
#'
#' dtMidpoint(25, 0, 35, 0)
#' dt <- data.table::data.table(lat = 25, lon = 0, lat2 = 35, lon2 = 0)
#' dt[, c("latMid", "lonMid") := dtMidpoint(lat, lon, lat2, lon2)]
#'
#'
#' @export
dtMidpoint <- function(latFrom, lonFrom, latTo, lonTo){
	latTo <- toRadians(latTo)
	latFrom <- toRadians(latFrom)
	lonTo <- toRadians(lonTo)
	lonFrom <- toRadians(lonFrom)

	Bx <- cos(latTo) * cos(lonTo - lonFrom)
	By <- cos(latTo) * sin(lonTo - lonFrom)

	theta <- atan2(sin(latFrom) + sin(latTo), sqrt( ( (cos(latFrom) + Bx)^2 + By^2 ) ) )
	lambda <- lonFrom + atan2(By, cos(latFrom) + Bx)

	return(list(toDegrees(theta), toDegrees(lambda)))
}


#' dt destination
#'
#' Calculates the destination coordinates from a starting point, initial bearing and distance travelling along a (shortest distance) great circle arc
#'
#' @param latFrom latitude from (in degrees)
#' @param lonFrom longitude from (in degrees)
#' @param distance distance in metres
#' @param bearing from north (in degrees)
#' @param r radius of earth in metres
#' @return list of latitude and longitude coordinates at the destination
#' @examples
#'
#' dtDestination(0, 0, earthsRadius(), 90)
#'
#' dt <- data.table::data.table(lat = 0, lon = 0)
#' dt[, c("destinationLat", "destinationLon") := dtDestination(lat, lon, earthsRadius(), 90)]
#'
#' @export
dtDestination <- function(latFrom, lonFrom, distance, bearing, r = earthsRadius()){
	latFrom <- toRadians(latFrom)
	lonFrom <- toRadians(lonFrom)
	bearing <- toRadians(bearing)
	phi <- ( distance / r )

	latTo <- asin( ( sin(latFrom) * cos(phi) ) + ( cos(latFrom) * sin(phi) * cos(bearing) ) )
	lonTo <- lonFrom + ( atan2( sin(bearing) * sin(phi) * cos(latFrom), cos(phi) - ( sin(latFrom) * sin(latTo) ) ) )

	return(list(toDegrees(latTo), toDegrees(lonTo)))
}







#' Earths Radius
#'
#' Returns the radius of the earth
#' @export
earthsRadius <- function() return(6378137)


toRadians <- function(x) return(x * (pi / 180))
toDegrees <- function(x) return(x / (pi / 180))

