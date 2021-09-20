
# read data and packages --------------------------------------------------

library(here)
library(ape)
library(sf)
library(readr)

multitree_odonata <- ape::read.nexus(file = here::here("data", 
                                               "raw",
                                               "multiphylo.txt") # multiphylo
                                           )
shapefile_basin_sf <- sf::read_sf(here::here("data", "spatialData"),
                                  as_tibble = T) # basins

insertion_odonata <- read.csv(file = here::here("data", 
                                                "raw",
                                                "insertions_odonata.csv"), 
                              sep = ";")

occ_gbif_odonata <- readr::read_delim(file = here::here("data", "raw", "occ_gbif_odonata.csv"))

