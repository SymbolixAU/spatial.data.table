#' Encode Simple Feature
#'
#' Converts coordinates from feature objects (\code{sf}) into encoded polylines
#'
#' @export
EncodeSF <- function(sf){

	dataCols <- setdiff(names(sf), attr(sf, 'sf_column'))
	if(length(dataCols) == 0){
		dt <- data.table(id = 1:nrow(sf))
	}else{
		dt <- data.table::as.data.table(sf)[, dataCols, with = F]
		dt[, id := .I]
	}

	geom <- sf::st_geometry(sf)

	dt_geom <- EncodePolyline(geom)

	return(dt[ dt_geom, on = c(id = ".id"), nomatch = 0])

}


EncodePolyline <- function(geom) UseMethod("encodePolyline")


#' @export
encodePolyline.sfc_LINESTRING <- function(geom){

		pl <- sapply(1:length(geom), function(x){
			m <- unlist(geom[[x]])
			googleway::encode_pl(m[,2],m[,1])
		})

		return(data.table::data.table(.id = 1:length(geom),
																	polyline = pl))
}

#' @export
encodePolyline.sfc_MULTIPOLYGON <- function(geom){

	data.table::rbindlist(

		lapply(geom, function(x){

			data.table::rbindlist(
				lapply(1:length(x), function(y){

					data.table::data.table(
						lineId = y,
						polyline = googleway::encode_pl(x[[y]][[1]][,2],
																						x[[y]][[1]][,1]),
						hole = (y > 1)[c(T, F)]
					)
				})
			)
		}), idcol = T
	)
}

#' @export
encodePolyline.default <- function(geom){
	message(paste0("Many apologies, I don't know how to handle objects of class ", class(geom)))
}







