#' Encode Simple Feature
#'
#' Converts coordinates from feature objects (\code{sf}) into encoded polylines
#'
#' @export
EncodeSF <- function(sf){

	dataCols <- setdiff(names(sf), attr(sf, 'sf_column'))
	if(length(dataCols) == 0){
		dt <- data.table::data.table(id = 1:nrow(sf))
	}else{
		dt <- data.table::as.data.table(sf)[, dataCols, with = F]
		## TODO:
		## accept an ID column
		dt[, id := .I]
	}

	geom <- sf::st_geometry(sf)

	dt_geom <- EncodePolyline(geom)

	return(dt_geom)
	#return(dt[ dt_geom, on = c(id = ".id"), nomatch = 0])

}


EncodePolyline <- function(geom) UseMethod("encodePolyline")


#' @export
encodePolyline.sfc_LINESTRING <- function(geom){

		pl <- sapply(1:length(geom), function(x){
			m <- unlist(geom[[x]])
			encode_pl(m[,2],m[,1])
		})

		return(data.table::data.table(.id = 1:length(geom),
																	polyline = pl))
}

encodePolyline.sfc_POLYGON <- function(geom){

	data.table::rbindlist(
		lapply(geom, function(x){
				data.table::data.table(
					polyline = sapply(x, function(y){
						encode_pl(y[,2],y[,1])
						})
				)
		}), idcol = T
	)
}

#' @export
encodePolyline.sfc_MULTIPOLYGON <- function(geom){

	data.table::rbindlist(

		lapply(geom, function(x){

			data.table::rbindlist(

				lapply(x, function(y){
					pl <- sapply(y, function(z){
						encode_pl(z[,2], z[,1])
					})
					lineId <- seq_along(pl)
					hole = lineId > 1
					data.table::data.table(lineId = lineId, polyline = pl, hole = hole)
				})
			)
		}), idcol = T
	)
}

#' @export
encodePolyline.default <- function(geom){
	message(paste0("Many apologies, I don't know how to handle objects of class ", class(geom)))
}







