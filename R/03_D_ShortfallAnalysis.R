
# libraries and funtions -----------------------------------------

library(sp)
source(here::here("R", "function_DarwinianShortfall.R"))

# editing insertion data --------------------------------------------------


insertion_odonata[which(insertion_odonata$obs == "Sem o genero na filogenia " |  
                          insertion_odonata$obs == "Sem o genero na filogenia"), "insertions"] <- "Family_insertion"
insertion_odonata[which(insertion_odonata$insertions == "Present_in_tree" |  
                          insertion_odonata$insertions == "Present_in_tree "), "insertions"] <- "Present_in_Tree"
insertion_odonata[which(insertion_odonata$insertions == "Congeneric_insertion "), "insertions"] <- "Congeneric_insertion"

insertion_all_spp <- insertion_odonata[, - c(5, 6) ]

shortfall_odonata_all <- lapply(multitree_odonata, function(x){
  PD_deficit(phylo = x, data = insertion_all_spp, level = c("Congeneric_insertion", "Family_insertion"))
})


