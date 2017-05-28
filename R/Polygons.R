## TODO:
## - does WindingNumber require clockwise / anti-clockwise path
## - the test using lat/lon coords sometimes gives 0, sometimes gives -1
## - when using lat/lon, which one is X and which is Y ?
## -- and does the geodecisity get accounted for?
## - does the WindingNumber 'for' loop go up to n or (n - 1) ?
## --- because the last point is the same as the first one?

## - some of the test-cases appear to struggle when the point is 'close' to the line
## -- however, I couldn't replicate this issue when using 'cppFunction()'

#' Winding Number
#'
#' Calculates the winding number for a point and polygon. Returns 0 when the point
#' is outside the polygon
#'
#' @param pointX x-coordinate of a point
#' @param pointY y-coordinate of a point
#' @param polyX x-coordinates of the polygon
#' @param polyY y-coordinates of thepolygon
#'
#' @export
WindingNumber <- function(pointX, pointY, polyX, polyY,
													debugIsClosed = FALSE, debugClosePoly = FALSE){
	rcppWindingNumber(pointX, pointY, polyX, polyY, debugIsClosed, debugClosePoly)

}

#' Test Close Polygon
#'
#' tests close polygon
#'
#' @param v
#' @export
#'
testClosePolygon <- function(v){
	rcppClosePolygon(v)
}

#' Test Is Closed
#'
#' Tests if polygon is closed
#'
#' @param v
#' @export
testIsClosed <- function(x1, x2, y1, y2){
	rcppIsPolygonClosed(x1, x2, y1, y2)
}
