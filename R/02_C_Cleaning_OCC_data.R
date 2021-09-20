# Cleaning and checking spatial data 


# reading libraries -------------------------------------------------------

library(dplyr)
library(sf)
library(CoordinateCleaner)
library(magrittr)

# Selecting columns of interest -------------------------------------------

occ_gbif_odonata <- occ_gbif_odonata %>%
  dplyr::select(species, decimalLongitude, decimalLatitude, countryCode, individualCount,
                gbifID, family, taxonRank, coordinateUncertaintyInMeters, year,
                basisOfRecord, institutionCode)



# removing records without coordinates ------------------------------------

occ_gbif_odonata <- occ_gbif_odonata %>%
  filter(!is.na(decimalLongitude))%>%
  filter(!is.na(decimalLatitude))

# renaming latitude and longitude
names(occ_gbif_odonata)[2:3] <- c("decimallongitude", "decimallatitude")

# cleaning data with CoordinateCleaner ------------------------------------

clean_occ_gbif <- occ_gbif_odonata%>%
  cc_val()%>%
  cc_gbif()%>%
  cc_inst()%>%
  cc_sea()%>%
  cc_zero()

# alternative method
#flags <- clean_coordinates(x = dat,
#                           lon = "decimalLongitude",
#                           lat = "decimalLatitude",
#                           countries = "countryCode",
#                           species = "species",
#                           tests = c("capitals", "centroids", "equal","gbif", "institutions",
#                                     "zeros", "countries")) # most test are on by default

# obtaining occurrence of species per basin -------------------------------------------------------

sf_gbif_occ <- sf::st_as_sf(x = clean_occ_gbif,                         
                            coords = c("decimallongitude", "decimallatitude"))

# setting the same projection as basin shapefile
sf_gbif_occ <- sf::st_set_crs(x = sf_gbif_occ, 
                              value = "+proj=longlat +datum=WGS84")

# joining polygons and occurrence points
sf::sf_use_s2(FALSE)
abund_in_basin_odonata <- sf::st_join(sf_gbif_occ, 
                                      shapefile_basin_sf, 
                                      join = st_within)


# saving objects ----------------------------------------------------------

saveRDS(file = here::here("data", "processed", "abund_in_basin.rds"), object = abund_in_basin_odonata)
