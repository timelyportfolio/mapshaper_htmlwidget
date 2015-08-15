#' Mapshaper in R
#'
#' Use \href{www.mapshaper.org}{mapshaper} within R to analyze and simplify
#' your spatial objects.
#'
#' @param ... One or many input lists, data.frame, or spatial class.  If \code{input}
#'   is not \code{json}, then automatic conversion will be attempted
#'   with \code{\link[geojsonio]{geojson_json}}.
#'
#' @example examples/example_mapshape.R
#'
#' @import htmlwidgets geojsonio
#'
#' @export
mapshaper <- function( ..., width = "100%", height = "100%") {
  input <- lazyeval::auto_name(lazyeval::lazy_dots(...))

  if(!is.null(input)){
    files <- lapply(
      names(input)
      ,function(name){
        x <- lazyeval::lazy_eval(input[[name]])

        x <- x

        if(!inherits(x,c("character","json","list"))) {
          # attempt conversion with geojsonio
          x <- geojson_json( x )
        }

        if(inherits(x,"json")){
          x <- as.character(x)
        }

        list(
          name = name
          ,geojson = x
        )
      }
    )
  }

  # forward options using x
  x = list(
    files = files
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'mapshaper',
    x,
    width = width,
    height = height,
    package = 'mapshaperWidget'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
mapshaperOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'mapshaper', width, height, package = 'mapshaperWidget')
}

#' Widget render function for use in Shiny
#'
#' @export
renderMapshaper <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, mapshaperOutput, env, quoted = TRUE)
}


# custom mapshaper html
mapshaper_html <- function(name, package, id, style, class, ...){
  htmltools::tags$div(id = id, style = style, style = "position:relative;", class = class, ...
  ,
htmltools::HTML('
<div class="hidden">
	<svg version="1.1" id="home-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
y="0px" width="14px" height="18px" viewBox="0 0 14 16">
<g>
<polygon points="13,7 13,6 12,6 12,5 11,5 11,4 10,4 10,3 9,3 9,2 8,2 8,1 6,1 6,2 5,2 5,3 4,3 4,4 3,4 3,5 2,5
2,6 1,6 1,7 0,7 0,9 2,9 2,14 6,14 6,10 8,10 8,14 12,14 12,9 14,9 14,7"/>
</g>
</svg>
<svg version="1.1" id="zoom-in-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
y="0px" width="14px" height="20px" viewBox="0 0 14 14">
<g>
<polygon points="13,5 9,5 9,1 5,1 5,5 1,5 1,9 5,9 5,13 9,13 9,9 13,9"/>
</g>
</svg>
<svg version="1.1" id="zoom-out-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
y="0px" width="14px" height="16px" viewBox="0 0 14 10">
<g>
<polygon points="1,1 13,1 13,5 1,5 1,1" />
</g>
</svg>
<svg version="1.1" id="info-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
y="0px" width="14px" height="15px" viewBox="-511 393 14 15">
<g id="Layer_2">
<path d="M-501.58,399.54c-0.01,0.07-0.05,0.19-0.13,0.34c-0.08,0.16-0.17,0.34-0.28,0.54l-2.24,4.88
c-0.08,0.15-0.15,0.31-0.21,0.48c-0.06,0.17-0.1,0.31-0.12,0.41c-0.02,0.11,0.02,0.22,0.11,0.3c0.09,0.09,0.18,0.14,0.27,0.15
c0.15,0.02,0.26,0.03,0.35,0.02c0.09-0.01,0.26-0.03,0.53-0.07l0.18,0.53c0.03,0.14,0.05,0.25,0.03,0.33
c-0.01,0.1-0.12,0.19-0.32,0.27c-0.2,0.08-0.44,0.15-0.73,0.2c-0.29,0.05-0.6,0.09-0.94,0.1c-0.34,0.02-0.66,0-0.95-0.04
c-0.79-0.12-1.33-0.36-1.61-0.72c-0.28-0.36-0.4-0.73-0.34-1.1c0.02-0.11,0.06-0.28,0.13-0.5c0.07-0.22,0.19-0.49,0.34-0.81
l1.39-2.97c0.05-0.08,0.1-0.21,0.16-0.39c0.06-0.18,0.09-0.31,0.1-0.38c0.03-0.17-0.02-0.29-0.13-0.37
c-0.11-0.07-0.29-0.17-0.54-0.28c-0.05-0.02-0.11-0.06-0.18-0.11c-0.07-0.05-0.09-0.13-0.08-0.23c0.01-0.07,0.04-0.15,0.08-0.23
c0.04-0.08,0.07-0.14,0.1-0.18l0.22-0.36c0.8,0.03,1.53,0.04,2.18,0.01c0.65-0.02,1.16-0.06,1.52-0.11
c0.27-0.03,0.44-0.06,0.53-0.07c0.09-0.02,0.18-0.02,0.27,0C-501.66,399.22-501.55,399.33-501.58,399.54z"/>
<path d="M-499.68,395.47c-0.09,0.61-0.39,1.1-0.88,1.47c-0.49,0.36-1.03,0.5-1.63,0.42c-0.6-0.08-1.08-0.37-1.44-0.85
c-0.36-0.48-0.49-1.03-0.39-1.64c0.09-0.59,0.38-1.07,0.87-1.44c0.49-0.37,1.03-0.51,1.63-0.42c0.6,0.08,1.08,0.37,1.44,0.85
S-499.59,394.88-499.68,395.47z"/></g></svg>
</div>

<div id="mshp-version" class="colored-text"></div>
<a href="https://github.com/mbloch/mapshaper"><div id="fork-me"></div></a>
<div class="page-header">
<div class="mapshaper-logo">map<span class="logo-highlight">shaper</span></div>

<div id="layer-control-btn"><span class="btn mode-btn layer-name"></span></div>

<div id="simplify-control-wrapper"><div id="simplify-control"><span class="label">Simplify</span>
<div class="slider">
<div class="handle"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAA4CAYAAACohjseAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDpBNzU1MTAwNkExMDVFMTExOTlEMEZERTY2RkYxQTc3RSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpGMTc5NDA2MzhGMTkxMUUyQjhEREI3RjFGQ0M4NjMxMiIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpGMTc5NDA2MjhGMTkxMUUyQjhEREI3RjFGQ0M4NjMxMiIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1LjEgV2luZG93cyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjVCOTg1QzBCNUQwQ0UxMTE4Qzc4Q0ZCMDE3OEU0QjA5IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkE3NTUxMDA2QTEwNUUxMTE5OUQwRkRFNjZGRjFBNzdFIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+iUan1wAABSlJREFUeNrsmn9IG1ccwO9ySeSyxp8Z6tTBjBrpHwOVkgpFaWFDGNv+Dt0fJRbHKBTG3Fy3sT8GjrlZxgb9YzLD/piEMShsYzBwtMgGNmyJWrBqdK5U21qnJZofFxNzt+87zvG8XC4xXpJ7ZQ++vKeXvPt+7vvrvXehBUGgnuRGH3eCUj8gmqb/BywEoBnkBUkcIE+DnARhpescyB2Qf0BWQH4BmQRJaA1IaQEoSfX+/v556K+DhIWjN/Sd69Ic1di8qlLwxvM8C0p9AH0IRNBIQjDnFTQ3CKUmhQRjksnkRegfaggml4fSPZh8AfNy4Fgs1lpWVuaFYVeRcol/b2/PBfdcll9gGEZbQLjRqzDptzA8UeSEGUmlUq/BvX/A/2k0GrUDTCQSrxsMhmvowZWoKqTALS+BDl9pDhiPx89Llit5kyw5gcYmk+n4gNFo1AkT3cTqWKkbB8nnLOjkM5vNxwPc2dlpZFn2FgwbdLbMvM9x3OmKiop1tQ8Z1C5OTk4aIXN9DwW1IdfCW0RpQLohHfO1IA3l4F0I6I/1vFuApPOexWL5BC2qjgS4vr7+TE1NzVIJysGRy8f29rajsbHxwVFclK6qqhokAA61E5KudM4WXF1dtdXV1f1NCKBoxY2Njeeam5u35BeUApQG17wAQUwKnGhFpDP0V+WxqGRBQzgc/gP2WZ0kHU2AQQJWq/UUyjtqgPTc3JwNTL1J4vnL5uZms91uv4tbMc1F6+vr+0g9iAILnoHurloM0rB4PUUqINIduolMFqQlX3aQCoh0x1gERQtCs5MKiHTH4TKViVqCD4Nrs9VBmrD6l1YP5ZXBqHQMSHBLZF3JAGCEoCWaXPdoVkDYfjyCYCUV8HFWwFQq9RfDMHYSAZHuuQAGYZP7IqGAwWyAQjwe/zPbUZxuM0wiEZDvJtI2vIuLi7/q8PwlJ1lbW/tNbcNLS2KED94CN+0gyXqQHGeamppOw3BfsmLaUk04WOZwHPedxWIhChDpjLmnkMlFRfLZ2dkJeCJRUlwT6Yp0xi2XccMrQTMrKyufmc3my4Qkly9bWlreRolU2tGrWxDJwsLCFyRYEemIdMV1z3Ymc2BFI2TUd1iW/Ujnsfdhe3v7p1Jy4eWAmV6DiRk1Eon4e3p6+mDpVq/XzDk8PPwGxF9SCS6TBQ/FotfrfdbpdP4OkLU6W3c+8vl8Z1wu1z2l2MsGeBCfIuTU1JQTagz6qYduXp9Bre7r7e31YXB8JktRam4quTETCARclZWVHj3QhUIhd2dnp1eCSykll1wAcVcVk87MzMzF8vLyz6kSvsLe3d19s6Oj42ssqfCZ4HIBPBSPSKanp1+22WweiMmnir2Z3dracnd3d/+EWU4VTnGxrTS3NJE4KbrB/Px8N2Sw20XMlrfRPeVwsBgRcrFOzqdymCUNXV1dprGxsQtWq/X9QmVYlCnD4fDwwMDAN36/P4k9aH55eVmEa21t1QxQHpOiDA0NWSFVX4IFwVtauS1yRyjgV6FEXRsZGQljsSZKMBj8z3JtbW2aAuLZ9RDo6OhoNaTtl2AX8orJZDqbR0lBv5y4GYvFfoSy9PPg4OBjORhix+EKBYh/7wAQB6bdbjfb399/Dtz3HMMwbbC3rAF5Xh5XINvomAHc8Mb4+PgNj8fDYTHPy8bU0tJSWsw5HI6CAMqtiVuVVpBsSUwuPP63ElixAJVAKRkopdALCr2ArUYEteKdj6tRGoKq9UrWU+spvQHmO/+T/dP/QrZ/BRgAuUpsiCdkKvMAAAAASUVORK5CYII=" /></div>
<div class="track"></div>
</div>
<input type="text" value="label" class="clicktext" />
</div></div>
<div id="mode-buttons">
<span id="simplify-btn" class="mode-btn btn">Simplify</span><span class="separator"></span><span id="console-btn" class="mode-btn btn">Console</span><span class="separator"></span><span id="export-btn" class="mode-btn btn">Export</span>
</div>
</div>

<div id="mshp-not-supported" class="main-area">
<div class="info-box">
<h3>Unfortunately, mapshaper can\'t run in <span class="unsupported-browser">this web browser</span></h3>
  <div>For best results, try <a href="https://www.google.com/chrome/browser/desktop/">Google Chrome</a> or <a href="http://www.mozilla.org/en-US/firefox/new/">Mozilla Firefox</a>.</div>
  </div>
  </div>

  <div id="layer-control" class="main-area popup-dialog">
  <div class="info-box">
  <div id="layer-menu">
  <h3>Layers</h3>
  <div class="layer-list"></div>
  <div><div id="add-file-btn" class="dialog-btn btn">Add a file</div></div>
  </div>
  </div>
  </div>

  <div id="export-options" class="main-area popup-dialog">
  <div class="info-box">
  <h3>Export</h3>
  <div class="option-menu">
  <div style="height:3px"></div>
  <div><input type="text" class="advanced-options" placeholder="command line options" /><div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Enter options from the command line
interface. Examples: "bbox" "no-quantization"
"precision=0.001"</div></div></div></div>
  </div>
  <div>
  <div id="shapefile-btn" class="btn dialog-btn">Shapefile</div>
  <div id="geojson-btn" class="btn dialog-btn">GeoJSON</div>
  <div id="topojson-btn" class="btn dialog-btn">TopoJSON</div>
  <div id="csv-btn" class="btn dialog-btn">CSV</div>
  </div>
  </div>
  </div>

  <div id="simplify-options" class="main-area popup-dialog">
  <div class="info-box">
  <h3>Simplification options</h3>
  <div class="option-menu">
  <div><label for="import-retain-opt"><input type="checkbox" class="checkbox" id="import-retain-opt"/>prevent shape removal</label>
  <div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Prevent small polygon features from
disappearing at high simplification. Keeps
the largest ring of multi-ring features.
</div></div></div></div>
  </div>

  <h4>Method</h4>
  <div class="option-menu">

  <div><label><input type="radio" name="method" value="dp" class="radio">Douglas-Peucker</label><div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Simplified lines remain within a set
distance of original lines. Good for
thinning dense points, but spikes
tend to form at high simplification.</div></div></div>
  </div>

  <div><label><input type="radio" name="method" value="visvalingam" class="radio">Visvalingam / effective area</label><div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Lines are simplified by iteratively
removing the point that forms
the least-area triangle with two
adjacent points.</div></div></div>
  </div>

  <div><label><input type="radio" name="method" value="mapshaper" checked class="radio">Visvalingam / weighted area</label><div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Points located at the vertex
of more acute angles are
preferentially removed, for
a smoother appearance.</div></div></div></div>

  </div> <!-- option menu -->

  <div>
  <div class="cancel-btn btn dialog-btn">Cancel</div>
  <div class="submit-btn btn dialog-btn">Next</div>
  </div>
  </div> <!-- simplification menu -->

  </div>

  <div id="import-options" class="main-area popup-dialog">
  <div class="info-box">

  <div id="import-intro">
  <h3>R htmlwidget</h3>
  <p><span class="inline-btn btn" id="r-selection-btn"><span class="label-text">Retrieve</span>
  <h3>Edit a file</h3>
  <p>Drag and drop or  <span class="inline-btn btn" id="file-selection-btn"><span class="label-text">select</span></span> a file to import.
Shapefile, GeoJSON and TopoJSON files
and Zip archives are supported.
</p>
  </div>
  <h3>Import options</h3>
  <div class="option-menu">

  <div><label for="repair-intersections-opt"><input type="checkbox" checked class="checkbox" id="repair-intersections-opt"/>detect line intersections</label>
  <div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Detect line intersections, including
self-intersections, to help identify
topological errors in a dataset.</div></div></div></div>

  <div><label for="snap-points-opt"><input type="checkbox" class="checkbox" id="snap-points-opt" unchecked />snap vertices</span></label>
  <div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Fix topology errors by snapping
together points with nearly identical
coordinates. This option does not
apply to TopoJSON files.</div></div></div></div>
  <div style="height:3px"></div>
  <div><input type="text" class="advanced-options" placeholder="command line options" /><div class="tip-button">?<div class="tip-anchor">
  <div class="tip">Enter options from the command line
interface. Examples: "no-topology"
"encoding=big5"</div></div></div></div>

  </div>

  <div id="dropped-file-list">
  <h3>Files</h3>
  <div class="file-list"></div>
  </div>

  <div id="import-buttons" class="hidden">
  <div class="cancel-btn btn dialog-btn">Cancel</div>
  <div class="add-btn btn dialog-btn">Add file</div>
  <div class="submit-btn btn dialog-btn">Import</div>
  </div>

  </div> <!-- .info-box -->
  </div> <!-- import-options -->

  <!-- TODO: remove #mshp-main-page without causing the map to jitter when resized -->
<div id="mshp-main-page">
  <div id="console" class="main-area">
  <div id="console-window"><div id="console-buffer"></div></div>
  </div>
  <div id="mshp-main-map" class="main-area">
  <div id="intersection-display">
  <div id="intersection-count">0 line intersections</div>
  <div id="repair-btn" class="text-btn colored-text">Repair</div>
  </div>
  <div id="map-layers"></div>
  </div>
  </div>
'
)
  )
}
