
# read data and packages --------------------------------------------------

library(FishPhyloMaker)
library(here)
library(ape)
library(rnaturalearth)
library(sf)
library(rgdal)

tree_odonata <- read.tree(file = here::here("data",
                                            "odonata_insertedFINAL.new")) # phylo tree

multitree_odonata <- read.nexus(file = here::here("data", 
                                               "raw",
                                               "multiphylo.txt") # multiphylo
                                           )
shapefile_basin_sf <- sf::st_read(dsn = here::here("data", "spatialData")) # basins

occ_odonata <- read.csv(file = here::here("data", "raw", "occ_odonata_neotrop.csv"), sep = ";")



