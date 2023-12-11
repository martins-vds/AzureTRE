# Setup ------------------------------------------------------------------------
# Load pacman for easier package management
library(pacman)

# Load all other packages, installing if necessary
p_load(
  bsicons,
  bslib,
  charlatan,
  dplyr,
  leaflet,
  purrr,
  sf,
  shiny,
  shinyjs,
  spatstat,
  stringr,
  terra,
  R.utils,
  tibble,
  tidyr,
  units
)

# Create a proj4 string for the lamber conformal conic projection
proj_lcc <- paste(
  "+proj=lcc",
  "+lat_0=40",
  "+lon_0=-96",
  "+lat_1=50",
  "+lat_2=70",
  "+x_0=0",
  "+y_0=0",
  "+datum=NAD83",
  "+units=m",
  "+no_defs",
  "+type=crs"
)

# Load helper functions
source("utils.R")

# User interface ---------------------------------------------------------------
ui <- page_sidebar(
  shinyjs::useShinyjs(),
  theme = bs_theme(version = 5),
  title = "Test Shiny App",
  sidebar = sidebar(
    accordion(
      accordion_panel(
        title = "Data Parameters",
        icon = bs_icon("sliders"),
        numericInput(
          "numLocations",
          span(
            "Number of Locations",
            tooltip(
              bs_icon("info-circle"),
              "The number of randomly generated locations to display.",
              placement = "right"
            )
          ),
          value = 10,
          min = 1,
          max = 100
        ),
        div(
          style = "padding-top: 2em; text-align: center;",
          actionButton("showLocations", "Show Locations") |>
            tooltip(
              "Click to show randomly generated locations.",
              placement = "right"
            )
        )
      ),
      accordion_panel(
        "Model Parameters",
        icon = bsicons::bs_icon("gear"),
        numericInput(
          "bufferDistance",
          span(
            "Buffer Distance",
            tooltip(
              bs_icon("info-circle"),
              "The radius, in kilometers, of the circular buffer to surround each destination.",
              placement = "right"
            )
          ),
          value = 100,
          min = 1,
          max = 1000,
        ),
        numericInput(
          "gridSize",
          span(
            "Grid Size",
            tooltip(
              bs_icon("info-circle"),
              "The size, in kilomteres, of the individual raster grid cells.",
              placement = "right"
            )
          ),
          value = 50000,
          min = 1000,
          max = 50000,
        ),
        div(
          style = "padding-top: 2em; text-align: center;",
          actionButton("runModel", "Run Model") |>
            tooltip(
              "The radius, in kilometers, of the circular buffer to surround each destination.",
              placement = "right"
            )
        )
      ),
      open = TRUE
    ),
    width = "20%"
  ),
  card(
    leafletOutput("interactiveMap")
  )
)

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  # Start the app with a base interactive map
  output$interactiveMap <- renderLeaflet({
    leaflet() |>
      addTiles() |>
      addMeasure(primaryLengthUnit = "kilometers", primaryAreaUnit = "sqmeters")
  })

  # Make the `Run Model` button disabled by default
  map(c("bufferDistance", "gridSize", "runModel"), disable)

  # When the user clicks `Show Locations`, invalidate all inputs
  bindEvent(
    observe(map(c("numLocations", "showLocations", "bufferDistance", "gridSize", "runModel"), disable)),
    input$showLocations
  )

  # When the user clicks `Show Locations`, generate a number of points as
  # specified by numLocations and provide a transient notification
  locations <- bindEvent(
    reactive({
      id <- notify("Showing locations...")
      on.exit(removeNotification(id), add = TRUE)

      generateLocations(numLocations = input$numLocations)
    }),
    input$showLocations
  )

  # Once new locations are generated and mapped, enable all the buttons. This
  # feature makes a) all inputs invalid during a process, indicating to the user
  # that the system is busy (which is good UI) and b) enables the model parameters
  # only after locations are generated and plotted.
  bindEvent(
    observe(map(c("numLocations", "showLocations", "bufferDistance", "gridSize", "runModel"), enable)),
    locations()
  )
  # Convert the generated locations to an sf object each time they are generated
  locations_sf <- reactive({
    locations() |>
      st_as_sf(coords = c("x", "y"), crs = 4326) |>
      st_transform(proj_lcc)
  })

  # Whenever `Show Locations` is clicked and new locations are generated, remove
  # all existing map layers, refit the map, and plot the new points. Use the
  # locations tibble object, instead of sf object, for easier labels.
  # them
  observe({
    leafletProxy("interactiveMap", data = locations()) |>
      clearMarkers() |>
      clearShapes() |>
      clearImages() |>
      fitBounds(~ min(x), ~ min(y), ~ max(x), ~ max(y)) |>
      addCircleMarkers(
        lng = ~x,
        lat = ~y,
        color = ~ marker_pal(counts),
        label = ~ map(
          str_glue(
            "<b>Coordinates:</b> {round(y, 4)}, {round(x, 4)}",
            "<b>Count:</b> {counts}",
            .sep = "<br>"
          ),
          htmltools::HTML
        ),
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto",
          closeButton = TRUE
        )
      )
  })


  # When the user clicks `Run Model`, invalidate all inputs
  bindEvent(
    observe(map(c("numLocations", "showLocations", "bufferDistance", "gridSize", "runModel"), disable)),
    input$runModel
  )

  # When the use clicks `Run Model`, compute the buffer
  buffered_data <- bindEvent(
    reactive({
      id <- notify("Creating buffers...")
      on.exit(removeNotification(id), add = TRUE)

      my_buffer <- st_buffer(
        locations_sf(),
        set_units(input$bufferDistance, "km")
      )

      notify("Creating observation window...", id = id)
      my_owin <- as.owin(my_buffer)


      notify("Creating point pattern object...", id = id)

      # Create a point pattern object
      my_ppp <- ppp(
        x = st_coordinates(locations_sf())[, "X"],
        y = st_coordinates(locations_sf())[, "Y"],
        marks = locations_sf()$counts,
        window = my_owin
      )

      notify("Computing kernel density estimates...", id = id)
      # Compute kernel density intensity
      my_kdi <- withTimeout(
        density(
          my_ppp,
          sigma = 1000,
          eps = input$gridSize,
          weights = marks(my_ppp),
          edge = TRUE,
          kernel = "gaussian"
        ),
        timeout = 5
      )

      notify("Converting spatial image to raster...", id = id)

      myRaster <- terra::rast(my_kdi)

      terra::crs(myRaster) <- proj_lcc

      myRaster <- leaflet::projectRasterForLeaflet(myRaster, method = "bilinear")
    }),
    input$runModel
  )

  # When the model is finished, enable all inputs
  bindEvent(
    observe(map(c("numLocations", "showLocations", "bufferDistance", "gridSize", "runModel"), enable)),
    buffered_data()
  )

  # Create a colour palette that reacts to the generated counts
  raster_pal <- reactive({
    colorNumeric(
      palette = heat.colors(n = 5),
      domain = values(buffered_data(), dataframe = TRUE),
      na.color = "transparent",
      reverse = TRUE
    )
  })

  # Update the interactive map with the polygons created by the user
  observe({
    leafletProxy("interactiveMap", data = isolate(locations())) |>
      clearShapes() |>
      clearImages() |>
      # addPolygons(data = st_transform(buffered_data(), 4326))
      addRasterImage(buffered_data(), colors = raster_pal())
  })
}

shinyApp(ui, server)
