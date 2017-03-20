#' spToDT
#'
#' Converts Spatial objects (from packages \code{sp} and \code{sf}) into a \code{data.table}
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
spToDT.sf <- function(sf){

	dataCols <- setdiff(names(sf), attr(sf, 'sf_column'))
	dt <- data.table::as.data.table(sf)[, dataCols, with = F]

	dt[, id := .I]

	geom <- sf::st_geometry(sf)

	dt_geom <- GeomToDT(geom)

	return(dt[ dt_geom, on = c(id = ".id"), nomatch = 0])
}

#' @export
GeomToDT <- function(geom) UseMethod("GeomToDT")

#' @export
GeomToDT.sfc_LINESTRING <- function(geom){

	data.table::rbindlist(
		lapply(geom, function(x){
			data.table::as.data.table(unlist(x))
			}), idcol = TRUE)
}

#' @export
GeomToDT.sfc_MULTIPOLYGON <- function(geom){

	data.table::rbindlist(

		lapply(geom, function(x){

			data.table::rbindlist(
				lapply(1:length(x), function(y){

					data.table::data.table(
						lineId = y,
						lat = x[[y]][[1]][,2],
						lon = x[[y]][[1]][,1],
						hole = (y > 1)[c(T, F)]
						)
					})
				)
		}), idcol = T
	)
}

#' @export
GeomToDT.default <- function(geom){
	message(paste0("Many apologies, I don't know how to handle objects of class ", class(geom)))
}


#' @export
spToDT.default <- function(sp){
	stop(paste0("I don't know how to convert objects of class ", paste0(class(sp), collapse = " ,")))
}

spToDTMessage <- function(sp){
	message(paste0("dropping projection attribute: ", slot(slot(sp, "proj4string"), "projargs")))
}

