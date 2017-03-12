#
# library(rgdal)
# library(spatial.data.table)
# library(data.table)
# library(googleway)


# shp <- readOGR("../../Data/Shapefiles/1259030001_sla11aaust_shape",
# 							 layer = "SLA11aAust")
#
# # shp_vic <- subset(shp, shp@data$STATE_CODE == 2)
# # plot(shp_vic)
#
# shp_fis <- subset(shp, shp@data$SLA_CODE11 == 255208529)
# plot(shp_fis)
#
# ## polygons with many lines
# mapKey <- read.dcf("~/Documents/.googleAPI", fields = "GOOGLE_MAP_KEY")
#
# dt_polygons <- spToDT(shp_fis)
# dt_points <- data.table(id = 1:3,
# 												lat = c(-38.402, -38.3, -38.4),
# 												lon = c(145.23, 145.3, 145.275))
#


# spatial.data.table:::PointInPolygon(dt_polygons,c("id", "coords.V2", "coords.V1", "hole"),
# 																		dt_points,c("id", "lat", "lon"))
#
#
# point.in.polygon(1:10,1:10,c(3,5,5,3),c(3,3,5,5))
# point.in.polygon(1:10,rep(4,10),c(3,5,5,3,3),c(3,3,5,5,3))
#




#
# google_map(key = mapKey) %>%
# 	add_polylines(data = dt_polygons[lineId %in% c(2,3)], lat = "coords.V2", lon = "coords.V1", id = "lineId") %>%
# 	add_markers(data = dt_points, info_window = "id")






