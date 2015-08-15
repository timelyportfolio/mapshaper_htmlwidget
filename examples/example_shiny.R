library(shiny)
library(leaflet)
library(geojsonio)
library(mapshaperWidget)

calif <- geojson_read(
  system.file("examples/california.geojson",package="geojsonio")
)

ui <- fluidPage(
  fluidRow(
    column( 8, mapshaperOutput("mapshaper1", height = 600) )
    ,column( 4, leafletOutput( "leafmap", height = 600 ))
  )
  ,fluidRow(
    textOutput("message", container = p)
  )
)

server <- function(input, output, session) {
  v <- reactiveValues(msg = "")

  output$mapshaper1 <- renderMapshaper({
    mapshaper( calif )
  })

  output$leafmap <- renderLeaflet({
    leaflet( ) %>%
      addGeoJSON( calif ) %>%
      fitBounds( -124, 32, -113, 43 )
  })

  observeEvent(input$mapshaper1_export, {
    v$msg <- paste("Exported", input$mapshaper1_export$content)
    output$leafmap <- renderLeaflet(
      leaflet( ) %>%
        addGeoJSON( input$mapshaper1_export$content ) %>%
        fitBounds( -124, 32, -113, 43 )
    )
  })

  output$message <- renderText(v$msg)
}

shinyApp(ui, server)
