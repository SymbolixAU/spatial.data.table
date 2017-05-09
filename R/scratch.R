
# working through
# http://www.movable-type.co.uk/scripts/latlong.html
#
#  dt <- data.table(lat1 = seq(-38, -37, by = 0.1),
#    lon1 = seq(144, 145, by = 0.1),
#    lat2 = seq(-35, -34, by = 0.1),
#    lon2 = seq(145, 146, by = 0.1))
#
#  dt[, distance := dt.haversine(lat1, lon1, lat2, lon2)]


# sp <- readOGR(dsn = "../../SVNStuff/Clients/HT0_HydroTasmania/MRBU_MRWF_BUS_surveys/Data/Received_BUSData/GIS",
#                layer = "Roads_line")
# #
# #
# spdf <- readOGR(dsn = "../../SVNStuff/Clients/HT0_HydroTasmania/MRBU_MRWF_BUS_surveys/Data/Received_BUSData/GIS",
# 								layer = "Mainlands_poly")
#
# spToDT(sp)
#
# spToDT(spdf)

# library(data.table)
# library(sp)
# library(googleway)
#
# tram_stops
#
# sp <- SpatialPointsDataFrame(coords = tram_stops[, c("stop_lon", "stop_lat")], data = tram_stops)
#
# spToDT(sp)
#
# sp <- SpatialPoints(coords = tram_stops[, c("stop_lon", "stop_lat")])
#
# spToDT(sp)
#
# library(data.table)
# dt_stops <- as.data.table(tram_stops)
# dt_route <- as.data.table(tram_route)
#
#
# dtNearestPoints(dt1 = copy(dt_route),
# 								dt2 = copy(dt_stops),
# 								dt1Coords = c("shape_pt_lat", "shape_pt_lon"),
# 								dt2Coords = c("stop_lat","stop_lon"))



# library(data.table)
#
# dt <- data.table(x = c(-1,1,1,-1,-1), y = c(-1,-1,1,1,-1), ptx = c(0.5), pty = c(0.5))
# plot(dt$x, dt$y,"l")
#
#
# ## x & y denote our polygon (V of points)
# ## ptx and pty denote our point (P point)
#
#
# dt[, vy_lte_py := y <= pty]
# dt[, vy1_gte_y := shift(y, type = "lead") > pty]
#
#
# dt[, vy1_lte_py := shift(y, type = "lead") <= pty]
#
# dt[, isLeft := isLeft(x, y, shift(x, type = "lead"), shift(y, type = "lead"), ptx, pty)]
#
#
# dt[vy_lte_py == TRUE & vy1_gte_y & isLeft > 0]
# ## wn +1
#
# dt[vy_lte_py == FALSE & vy1_lte_py == TRUE & isLeft < 0]
# ## wn -1
#
# ## else wn == 0
#
# isLeft <- function(p0x, p0y, p1x, p1y, p2x, p2y){
# 	return((p1x - p0x) * (p2y - p0y) - (p2x - p0x) * (p1y - p0y))
# }


# sf <- sf::read_sf("~/Documents/SVNStuff/Clients/HT0_HydroTasmania/MRBU_MRWF_BUS_surveys/Data/Received_BUSData/GIS/Roads_line.shp")
# spToDT(sf)
#
# map_key <- symbolix.utils::mapKey()
#
# google_map(key = map_key) %>%
# 	add_polylines(data = shp)
#
#
# library(spatial.data.table)
# library(sf)
# nc <- st_read(system.file("shape/nc.shp", package="sf"))
#
# geom <- sf::st_geometry(nc)
# class(geom)
#
# dt.nc <- spToDT(nc)
#
#
#
# str(nc)
# nc$geom
#
# class(nc$geom)
# str(nc$geom)
# nc$geom[[1]][[1]]
#
# geomCol <- attr(sf, "sf_column")
#
# class(sf[[geomCol]])
#
# as.data.frame(sf[[geomCol]])

# sf <- rbind(c(0,3),c(0,4),c(1,5),c(2,5))
# sf <- st_linestring(sf)
#
# spToDT(sf)
#
# geom <- st_geometry(sf)
#
# class(geom)
#
# length(geom)
#
# lst <- lapply(geom, function(x){
# 	m <- unlist(x)
# 	googleway::encode_pl(m[,2],m[,1])
# })
#
# lapply(lst, function(x){
# 	coords = data.frame(lat = x[,2],
# 											lon = x[,1])
# })
#
# #
# encoding polylines
# library(data.table)
# library(sp)
# library(googleway)
#
# dt_stops <- as.data.table(tram_stops)
# dt_stops[1:25, id := 1]
# dt_stops[26:51, id := 2]
#
# lst <- lapply(1:2, function(x){
# 	Lines(Line(dt_stops[id == x, .(stop_lon, stop_lat)]), ID = x)
# })
#
# sp <- SpatialLines(lst)
#
# sf_tramRoute <- sf::st_as_sf(sp)
#
# spdf <- SpatialLinesDataFrame(sp, data = dt_stops)
#
# dt <- EncodeSF(sf)
#
# mapKey <- read.dcf("~/Documents/.googleAPI", fields = "GOOGLE_MAP_KEY")
#
# google_map(key = mapKey) %>%
# 	add_polylines(data = dt, polyline = "polyline")


# library(sf)
# s1 <- rbind(c(0,3),c(0,4),c(1,5),c(2,5))
# ls <- st_linestring(s1)
#
# s2 <- rbind(c(0.2,3), c(0.2,4), c(1,4.8), c(2,4.8))
# s3 <- rbind(c(0,4.4), c(0.6,5))
# mls <- st_multilinestring(list(s1,s2,s3))



## encoding polygons with holes
# library(rgdal)
# library(sf)
# shp_postcode <- readOGR(dsn = path.expand("~/Documents/SVNStuff/Clients/CCC_CalvaryCommunityCare/DataStore/Received/1270055003_poa_2011_aust_shape"), layer = "POA_2011_AUST")
#
# sf <- st_as_sf(shp_postcode)
#
# dt <- spToDT(sf)
#
# dt_poly <- EncodeSF(sf)
#
# ## hole postcode
# ## 3168
#
# ## multiple rings
# ## 0822
#
# shp_tiwi <- shp_postcode[shp_postcode$POA_CODE == "0822", ]
#
# save(shp_tiwi, file = "~/Documents/github/spatial.data.table/shp_tiwi")
#
# sf_hole <- sf[sf$POA_CODE == "3168",]
# sf_multi <- sf[sf$POA_CODE == "0822",]
#
# shp_demo <- shp_postcode[shp_postcode$POA_CODE %in% c("3168","0822"),]
#
# geom_hole <- st_geometry(sf_hole)
# geom_multi <- st_geometry(sf_multi)
#
# dt[POA_CODE == "3168"]
#
# dt_poly <- EncodeSF(sf)
#
# # dt_plot <- unique(dt_poly[POA_CODE == "0822", .(POA_NAME, polyline)])
#
#

# map_key <- symbolix.utils::mapKey()
#
# dt_poly <- aggregate(polyline ~ .id, data = dt_poly, list)
# data.table::setDT(dt_poly)
#
# library(googleway)
# library(data.table)
# google_map(key = map_key, data = dt_poly[1:2]) %>%
# 	add_polygons(polyline = "polyline", info_window = ".id", mouse_over = ".id")
#
#
# library(leaflet)
#
# leaflet() %>%
# 	addTiles() %>%
# 	addPolygons(data = shp_postcode[1:1000, ])
#
# sf_tiwi <- st_as_sf(shp_tiwi)
#
# dt_tiwi <- EncodeSF(sf_tiwi)
#
# dt_tiwi <- aggregate(polyline ~ .id, data = dt_tiwi, list)
# data.table::setDT(dt_tiwi)
#
#
# google_map(key = map_key, data = dt_tiwi) %>%
# 	add_polygons(polyline = "polyline", info_window = ".id")





# exterior <- data.frame(lat = c(3, -3, -3, 3, 3),
# 											 lon = c(3, 3, -3, -3, 3))
#
# hole1 <- data.frame(lat = c(0, 0, 1, 1, 0),
# 										lon = c(0, 1, 1, 0, 0))
#
#
# exterior2 <- data.frame(lat = c(4, 5, 5, 4, 4),
# 												lon = c(0, 0, 1, 1, 0))
#
# df = data.frame(ID = c(1, 2))
# row.names(df) <- c(1,2)
#
# sp <- SpatialPolygonsDataFrame(
# 	SpatialPolygons(
# 		list(
# 			Polygons(list(
# 				Polygon(exterior, hole = FALSE),
# 				Polygon(hole1, hole = TRUE)),
# 				ID = 1
# 				),
# 			Polygons(list(
# 				Polygon(exterior2, hole = FALSE)
# 			),
# 			ID = 2
# 			)
# 			)
# 	),
# 	data = df
# )
#
#
# sf <- sf::st_as_sf(sp)
#
#
# nc <- st_read(system.file("shape/nc.shp", package = "sf"))
#
# class(nc)
#
#
# nc1 <- nc[1, ]
#
# geom <- st_geometry(nc)
# geom1 <- st_geometry(nc1)


## sfc_POINTS
# library(sf)
#
# sf_point <- readRDS("~/Downloads/melb_centroid.rds")
#
#
# spToDT(sf_point)
#
# library(data.table)
#
# geom <- st_geometry(sf_point)
#
#
#
# as.data.table(t(lst))



# polys <- st_as_sfc(c("POLYGON((0 0 , 0 1 , 1 1 , 1 0, 0 0))",
# 										 "POLYGON((0 0 , 0 2 , 2 2 , 2 0, 0 0 ))",
# 										 "POLYGON((0 0 , 0 -1 , -1 -1 , -1 0, 0 0))")) %>%
# 	st_sf()
#
# pts <- st_as_sfc(c("POINT(0.5 0.5)",
# 									 "POINT(0.6 0.6)",
# 									 "POINT(3 3)")) %>%
# 	st_sf()
#
# dt_polys <- spToDT(polys)
# dt_pts <- spToDT(pts)
#
# PointInPolygon(dt_polygons = dt_polys,
# 							 polyColumns = c("id", "lineId", "coords.V1", "coords.V2", "hole"),
# 							 dt_points = dt_pts,
# 							 pointColumns = c("id", "coords.V1", "coords.V2"))




