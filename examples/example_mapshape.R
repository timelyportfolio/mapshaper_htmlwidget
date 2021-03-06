library('geojsonio')
library('sp')
library('mapshaperWidget')

###  straight from geojson
alabama <- paste0(
  readLines(
    "https://raw.githubusercontent.com/glynnbird/usstatesgeojson/master/alabama.geojson"
  )
  ,collapse = " "
)
mapshaper(alabama)

###  example from geojsonio vignette
poly1 <- Polygons(
  list(
    Polygon(cbind(c(-100,-90,-85,-100), c(40,50,45,40)))
  )
  , "1"
)
poly2 <- Polygons(
  list(
    Polygon(cbind(c(-90,-80,-75,-90),c(30,40,35,30)))
  )
  , "2"
)
sp_poly <- SpatialPolygons(list(poly1, poly2), 1:2)

mapshaper( sp_poly )


### how to provide multiple spatial to mapshaper
calif <- geojson_read(
  system.file("examples", "california.geojson", package = "geojsonio")
)
mapshaper( sp_poly, calif )
