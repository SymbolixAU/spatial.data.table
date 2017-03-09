#' Nearest Points
#'
#' Finds the nearest points between two data tables.
#'
#' @note \code{dt1} and \code{dt2} get updated by reference within the function call, which modifies the original \code{data.table} objects.
#' To avoid this behaviour you can use a \code{data.table::copy()} of the objects as the arguments for \code{dt1} and \code{dt2}. See Examples
#'
#' @param dt1 \code{data.table} containing the points to be matched onto
#' @param dt2 \code{data.table} containing the points for which you want to find a match in \code{dt1}
#' @param dt1Coords vector containing the names of the columns of \code{dt1} containing the latitude and longitude (in that order) coordinates. If NULL, a 'best-guess' will be made
#' @param dt1Coords vector containing the names of the columns of \code{dt2} containing the latitude and longitude (in that order) coordinates. If NULL, a 'best-guess' will be made
#' @param dt2Id string specifying the column of \code{dt2} containing a unique id for each point. If NULL, a value of the point's row index will be assigned
#' @param distanceCalculation distance measure
#'
#' @examples
#' library(googleway) ## for the tram stops and routes data
#' library(data.table)
#'
#' dt_stops <- as.data.table(tram_stops)
#' dt_route <- as.data.table(tram_route)
#' dtNearestPoints(dt1 = copy(dt_route),
#'   dt2 = copy(dt_stops),
#'   dt1Coords = c("shape_pt_lat", "shape_pt_lon"),
#'   dt2Coords = c("stop_lat","stop_lon"))
#'
#' @export
dtNearestPoints <- function(dt1, dt2,
														dt1Coords = NULL, dt2Coords = NULL,
														dt2Id = NULL,
														distanceCalculation = c("haversine")){


	if(is.null(dt1Coords)){
		dt1Coords <- c(find_lat_column(names(dt1), "dtNearestPoints - dt1"),
									 find_lon_column(names(dt1), "dtNearestPoints - dt1"))
	}else{
		check_for_columns(dt1, dt1Coords, "dt2")
	}

	if(is.null(dt2Coords)){
		dt2Coords <- c(find_lat_column(names(dt2), "dtNearestPoints - dt2"),
									 find_lon_column(names(dt2), "dtNearestPoints - dt2"))
	}else{
		check_for_columns(dt2, dt2Coords, "dt2")
	}

	if(is.null(dt2Id)){
		dt2[, idx := .I][]
	}

	## append .x and .y to column names
	data.table::setnames(dt1, dt1Coords, paste0(dt1Coords, ".x"))
	data.table::setnames(dt2, dt2Coords, paste0(dt2Coords, ".y"))

	dt1Coords <- paste0(dt1Coords, ".x")
	dt2Coords <- paste0(dt2Coords, ".y")

	dt1[, key.x := 1][]
	dt2[, key.y := 1][]

	dt <- dt1[ dt2, on = c(key.x = "key.y"), allow.cartesian = T]
	dt[, distance := dtHaversine(get(dt1Coords[1]), get(dt1Coords[2]), get(dt2Coords[1]), get(dt2Coords[2]))][]

	return(dt[ dt[, .I[which.min(distance)], by = idx]$V1 ])

}






