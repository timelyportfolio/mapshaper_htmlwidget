#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
mapshaper <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
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
