# Example shiny app docker file
# https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/

ARG SHINY_TAG=4.3.1

# get shiny serveR and a version of R from the rocker project
FROM rocker/shiny:${SHINY_TAG}

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libudunits2-dev \
    libproj-dev \
    libgdal-dev

# install R packages required
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "shiny", \
              "shinydashboard", \
              "pacman", \
              "bsicons", \
              "bslib", \
              "charlatan", \
              "dplyr", \
              "leaflet", \
              "purrr", \
              "sf", \
              "shiny", \
              "shinyjs", \
              "spatstat", \
              "stringr", \
              "terra", \
              "R.utils", \
              "tibble", \
              "tidyr", \
              "jsonlite", \
              "units" \
            ), \
            repos="http://cran.rstudio.com/"\
          )'

# copy the app directory into the image
COPY ./src/* /srv/shiny-server/

# run app
CMD ["/usr/bin/shiny-server"]
