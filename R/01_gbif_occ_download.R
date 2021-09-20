library(dplyr)
library(purrr)
library(readr)  
library(magrittr) # for %>% pipe
library(rgbif) # for occ_download
library(taxize) # for get_gbifid_
library(countrycode)
library(CoordinateCleaner)
library(ggplot2)
library(sp)

# setting credentials -----------------------------------------------------

user <- "" # your gbif.org username 
pwd <- "" # your gbif.org password
email <- "" # your email 


# obtaining taxon keys ----------------------------------------------------

gbif_taxon_keys <-
  multitree_odonata$tree0$tip.label %>%
  gsub(pattern = "_", replacement = " ") %>% 
  taxize::get_gbifid_(method="backbone") %>% # match names to the GBIF backbone to get taxonkeys
  imap(~ .x %>% mutate(original_sciname = .y)) %>% # add original name back into data.frame
  bind_rows() %T>% # combine all data.frames into one
  filter(matchtype == "EXACT" & status == "ACCEPTED") %>% # get only accepted and matched names
  pull(usagekey) # get the gbif taxonkeys


# downloading occurrences  ------------------------------------------------

occ_download(
  pred_in("taxonKey", gbif_taxon_keys),
  format = "SIMPLE_CSV",
  user = user, pwd = pwd, email = email
)

