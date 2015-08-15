library(shiny)
library(leaflet)
library(geojsonio)
library(mapshaperWidget)

calif <- geojson_read(
  system.file("examples/california.geojson",package="geojsonio")
)

ui <- list(
  mapshaperOutput("mapshaper1",height = 500, width = 500)
  ,  tags$div( style = "width:100%; height: 500px;",
    textOutput("message", container = h3)
  )
)

server <- function(input, output, session) {
  v <- reactiveValues(msg = "")

  output$mapshaper1 <- renderMapshaper({
    mapshaper( calif )
  })

  observeEvent(input$mapshaper1_export, {
    v$msg <- paste("Exported", input$mapshaper1_export$content)
  })

  output$message <- renderText(v$msg)
}

shinyApp(ui, server)
