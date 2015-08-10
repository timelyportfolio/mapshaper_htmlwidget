## convert images in mapshaper.js to base64
##   the relative url will not work since added in JavaScript

library(base64enc)

close_png <- base64enc::dataURI(
  file="inst/htmlwidgets/lib/mapshaper/images/close.png"
  ,mime = "image/png"
)


slider_png <- base64enc::dataURI(
  file="inst/htmlwidgets/lib/mapshaper/images/slider_handle_v1.png"
  ,mime = "image/png"
)

mapshape_js <- readLines( "inst/htmlwidgets/lib/mapshaper/mapshaper.js" )

mapshape_js <- gsub(
  x = mapshape_js
  , pattern = "(images/close.png)"
  , replacement = close_png
)

cat(mapshape_js,file="inst/htmlwidgets/lib/mapshaper/mapshaper.js",sep="\n")

####  remove position relative in css for the main page
page_css <- readLines( "inst/htmlwidgets/lib/mapshaper/page.css" )

page_mshp_line <- which(grepl(
  x = page_css
  , pattern = "(#mshp-main-page \\{)"
))

page_css[page_mshp_line+1] <- "/*position:relative*/"

cat(page_css,file = "inst/htmlwidgets/lib/mapshaper/page.css",sep="\n")
