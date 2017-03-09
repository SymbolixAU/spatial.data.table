
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

