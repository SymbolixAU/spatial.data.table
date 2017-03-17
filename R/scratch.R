
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
#
# geom <- st_geometry(sf)
#
# class(geom)
#
# length(geom)
#
# lst <- lapply(geom, function(x){
# 	unlist(x)
# })
#
# lapply(lst, function(x){
# 	coords = data.frame(lat = x[,2],
# 											lon = x[,1])
# })







