
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

#
# sp <- Line(dt_route[, .(shape_pt_lon, shape_pt_lat)])

# spToDT(sp)

# sp <- Lines(sp, ID = "id")

# spToDT(sp)

# sp <- SpatialLines(list(sp))
#
# class(sp)

# spToDT(sp)


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
# filename <- system.file("gpkg/nc.gpkg", package="sf")
# nc <- sf::st_read(filename, "nc.gpkg", crs = 4267)
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
#
## encoding polylines
# library(data.table)
# library(sp)
#
# dt_route <- as.data.table(tram_route)
# dt_route[1:25, id := 1]
# dt_route[26:55, id := 2]
#
# lst <- lapply(1:2, function(x){
# 	Lines(Line(dt_route[id == x, .(shape_pt_lon, shape_pt_lat)]), ID = x)
# })
#
# sp <- SpatialLines(lst)
#
# sf <- sf::st_as_sf(sp)
#
# dt <- EncodeSF(sf)
#
# mapKey <- read.dcf("~/Documents/.googleAPI", fields = "GOOGLE_MAP_KEY")
#
# google_map(key = mapKey) %>%
# 	add_polylines(data = dt, polyline = "polyline")
#

# library(sf)
# s1 <- rbind(c(0,3),c(0,4),c(1,5),c(2,5))
# ls <- st_linestring(s1)
#
# s2 <- rbind(c(0.2,3), c(0.2,4), c(1,4.8), c(2,4.8))
# s3 <- rbind(c(0,4.4), c(0.6,5))
# mls <- st_multilinestring(list(s1,s2,s3))


#
# ## encoding polygons with holes
# library(rgdal)
# library(sf)
# shp_postcode <- readOGR(dsn = path.expand("~/Documents/SVNStuff/Clients/CCC_CalvaryCommunityCare/DataStore/Received/1270055003_poa_2011_aust_shape"), layer = "POA_2011_AUST")
#
# sf <- st_as_sf(shp_postcode)
#
# dt <- spToDT(sf)
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
# google_map(key = map_key, data = dt_poly) %>%
# 	add_polygons(polyline = "polyline")
#
#
#
#
#
#
# I have an `sp` SpatialPolygonsDataFrame object located on my github page https://github.com/SymbolixAU/spatial.data.table/blob/master/data/shp_tiwi.rds
#
# ```
# library(sp)
# library(sf)
#
# shp_tiwi <- readRDS("~/Downloads/shp_tiwi.rds")
#
# class(shp_tiwi)
#
# # [1] "SpatialPolygonsDataFrame"
# # attr(,"package")
# # [1] "sp"
#
# ```
#
# The shape file consists of 141 polygons, where polygons 2:5 are holes
# ```
# length(shp_tiwi@polygons[[1]]@Polygons)
# # [1] 141
#
# str(shp_tiwi@polygons[[1]]@Polygons[[1]])
# str(shp_tiwi@polygons[[1]]@Polygons[[2]])
# str(shp_tiwi@polygons[[1]]@Polygons[[3]])
#
# sapply(shp_tiwi@polygons[[1]]@Polygons, function(x) x@hole)
#
# # [1] FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# # [29] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# # [57] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# # [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# # [113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# # [141] FALSE
#
# ```
#
# ```
# sf_tiwi <- sf::st_as_sf(shp_tiwi)
# geom <- st_geometry(sf_tiwi)
# ```
#
# length(geom[[1]][[1]])
#
# length(geom[[1]][[137]])
#
#
# sf <- sf_tiwi





