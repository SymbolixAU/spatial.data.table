## ----nearestPoints-------------------------------------------------------


library(googleway)
library(data.table)

dt_stops <- as.data.table(tram_stops)
dt_route <- as.data.table(tram_route)

dt_nearest <- dtNearestPoints(dt1 = copy(dt_route),
															dt2 = copy(dt_stops),
															dt1Coords = c("shape_pt_lat", "shape_pt_lon"),
															dt2Coords = c("stop_lat","stop_lon"))


## create a polyline between the joined pairs of coordinates
# 
# dt_nearest[, polyline := gepaf::encodePolyline(data.frame(c(dt_nearest[, shape_pt_lat.x], dt_nearest[, stop_lat.y]),
# 																													c(dt_nearest[, shape_pt_lon.x], dt_nearest[, stop_lon.y])))]


pl <- sapply(1:nrow(dt_nearest), function(x){
	lats <- dt_nearest[x, c(shape_pt_lat.x, stop_lat.y)]
	lons <- dt_nearest[x, c(shape_pt_lon.x, stop_lon.y)]
	polyline = gepaf::encodePolyline(data.frame(lat = lats,lon = lons))
})


dt_nearest[, polyline := pl ]


mapKey <- symbolix.utils::mapKey()

google_map(key = mapKey) %>%
	#add_circles(data = dt_route, lat = "shape_pt_lat", lon = "shape_pt_lon", fill_colour = "#FF00FF", stroke_weight = 0) %>%
	add_markers(data = dt_stops, lat = "stop_lat", lon = "stop_lon") %>%
	add_polylines(data = dt_route, lat = "shape_pt_lat", lon = "shape_pt_lon") %>%
	add_circles(data = dt_nearest, lat = "shape_pt_lat.x", lon = "shape_pt_lon.x", stroke_weight = 0, radius = 20) %>%
	add_polylines(data = dt_nearest, polyline = "polyline", stroke_colour = "#000000")
	#add_circles(data = dt_stops, lat = "stop_lat", lon = "stop_lon", fill_colour = "#00FF00", stroke_weight = 0) 



