generateLocations <- function(numLocations) {
  if (numLocations == 1) {
    ch_position(n = numLocations, bbox = c(-140.99778, 41.6751050889, -52.6480987209, 83.23324)) |>
      enframe() |>
      pivot_wider(id_cols = everything(), names_glue = "{c('x', 'y')}") |>
      mutate(counts = floor(runif(numLocations, min = 0, max = 100)))
  } else {
    ch_position(n = numLocations, bbox = c(-140.99778, 41.6751050889, -52.6480987209, 83.23324)) |>
      map(
        \(x) x |>
          enframe() |>
          pivot_wider(id_cols = everything(), names_glue = "{c('x', 'y')}")
      ) |>
      list_c() |>
      mutate(counts = floor(runif(numLocations, min = 0, max = 100)))
  }
}

# Create a colour palette that reacts to the generated counts
marker_pal <- colorNumeric(
  palette = heat.colors(n = 5),
  domain = 1:100,
  na.color = "transparent",
  reverse = TRUE
)

notify <- function(msg, id = NULL) {
  showNotification(
    msg,
    id = id,
    duration = NULL,
    closeButton = FALSE,
    type = "message"
  )
}
