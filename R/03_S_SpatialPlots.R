
# reading packages and additional data --------------------------------------------------------

library(rnaturalearth)
library(sf)
library(ggplot2)

sf_brazil <- ne_countries(type = "countries", 
                          country = "Brazil", 
                          returnclass = "sf") # downloading brazil polygon


# plotting maps -----------------------------------------------------------

ggplot(sf_brazil) +
  geom_sf() +
  coord_sf(crs = "+proj=longlat +ellps=aust_SA +no_defs") +
  geom_sf(data = shapefile_basin_sf) +
  geom_point(data = dplyr::filter(occ_odonata, país == "Brasil" & Estado == "AM"), 
             aes(x = Longitude, y = Latitude, color = factor(SPP))) +
  theme(legend.position = "none")

ggplot(sf_brazil) +
  geom_sf() +
  coord_sf(crs = "+proj=longlat +ellps=aust_SA +no_defs") +
  geom_sf(data = shapefile_basin_sf) +
  geom_point(data = dplyr::filter(occ_odonata, país == "Brasil"), 
             aes(x = Longitude, y = Latitude)) +
  theme(legend.position = "none")

