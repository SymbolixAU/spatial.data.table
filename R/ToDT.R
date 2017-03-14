#' spToDT
#'
#' Converts Spatial objects (from package \code{sp}) into a \code{data.table}
#'
#' @param sp Spatial Object
#' @export
spToDT <- function(sp) UseMethod("spToDT")

#' @export
spToDT.Line <- function(sp){
	return(data.table::data.table(coords = slot(sp, "coords")))
}

#' @export
spToDT.Lines <- function(sp){

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::data.table(
			id = slot(sp, "ID"),
			coords = slot(sp@Lines[[x]], "coords")
		)

	})))
}

#' @export
spToDT.SpatialLines <- function(sp){
	spToDTMessage(sp)

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::data.table(
			id = slot(sp@lines[[x]], "ID"),
			coords = slot(slot(sp@lines[[x]], "Lines")[[1]], "coords")
		)

	})))
}



#' @export
spToDT.SpatialLinesDataFrame <- function(sp){

	spToDTMessage(sp)

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::data.table(
			id = slot(sp@lines[[x]], "ID"),
			coords = slot(slot(sp@lines[[x]], "Lines")[[1]], "coords"),
			data = slot(sp, "data")[x, ])
	})))
}


#' @export
spToDT.SpatialPoints <- function(sp){

	spToDTMessage(sp)

	return(data.table::data.table(coords = slot(sp, "coords")))
}

#' @export
spToDT.SpatialPointsDataFrame <- function(sp){

	spToDTMessage(sp)

		return(data.table::data.table(
			coords = slot(sp, "coords"),
			data = slot(sp, "data")
		))

}



#' @export
spToDT.Polygon <- function(sp){
	return(data.table::data.table(coords = slot(sp, "coords")))
}

#' @export
spToDT.Polygons <- function(sp){

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::data.table(
			id = slot(sp, "ID"),
			coords = slot(sp@Polygons[[x]], "coords")
		)
	})))
}

#' @export
spToDT.SpatialPolygons <- function(sp){
	spToDTMessage(sp)

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::rbindlist(lapply(1:length(sp@polygons[[x]]@Polygons), function(y){

			data.table::data.table(
				id = slot(sp@polygons[[x]], "ID"),
				lineId = y,
				coords = slot(sp@polygons[[x]]@Polygons[[y]], "coords"),
				ringDir = slot(sp@polygons[[x]]@Polygons[[y]], "ringDir"),
				hole = slot(sp@polygons[[x]]@Polygons[[y]], "hole")
			)
		}))
	})))
}



#' @export
spToDT.SpatialPolygonsDataFrame <- function(sp){

	spToDTMessage(sp)

	return(data.table::rbindlist(lapply(1:length(sp), function(x){

		data.table::rbindlist(lapply(1:length(sp@polygons[[x]]@Polygons), function(y){

			data.table::data.table(
				id = slot(sp@polygons[[x]], "ID"),
				lineId = y,
				coords = slot(sp@polygons[[x]]@Polygons[[y]], "coords"),
				ringDir = slot(sp@polygons[[x]]@Polygons[[y]], "ringDir"),
				hole = slot(sp@polygons[[x]]@Polygons[[y]], "hole"),
				data = slot(sp, "data")[x, ]
				)

		}))
	})))

}

#' @export
spToDT.sf <- function(sp){

	message("TODO : simple features")
	# dataCols <- setdiff(names(sp), "geometry")
	# ## the first polygon is an exterior ring, the following ones are holes
	#
	# dt <- data.table::as.data.table(sp)
	# lapply(1:nrow(dt), function(x){
	#
	# 	lapply(dt[x, geometry], function(y){
	# 		data.table::data.table(
	#
	# 		)
	# 	})
	#
	# })
}


#' @export
spToDT.default <- function(sp){
	stop(paste0("I don't know how to convert objects of class ", paste0(class(sp), collapse = " ,")))
}

spToDTMessage <- function(sp){
	message(paste0("dropping projection attribute: ", slot(slot(sp, "proj4string"), "projargs")))
}

