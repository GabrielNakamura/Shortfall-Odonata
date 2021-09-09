
library(FishPhyloMaker)
data("neotropical_comm")
comm_ex <- neotropical_comm[, -c(1, 2)]
teste <- FishPhyloMaker::FishTaxaMaker(data = comm_ex, allow.manual.insert = TRUE)
Characidae
Characiformes
Characidae
Characiformes
Characidae
Characiformes
Loricariidae
Siluriformes
Cichlidae
Cichliformes
Crenuchidae
Characiformes
Gymnotidae
Gymnotiformes
Loricariidae
Siluriformes
Loricariidae
Siluriformes
Loricariidae
Siluriformes
Loricariidae
Siluriformes
Heptapteridae
Siluriformes
Characidae
Characiformes
Loricariidae
Siluriformes
Characidae
Characiformes

phylo_insert <- FishPhyloMaker(data = teste$Taxon_data_FishPhyloMaker, 
                               insert.base.node = TRUE,
                               return.insertions = TRUE,
                               progress.bar = TRUE)


shortfall_odonata <- lapply(multitree_odonata, function(x){
  FishPhyloMaker::PD_defict(phylo = x, data = insertion_odonata[, - 4])
})

match(multitree_odonata$tree3$tip.label, insertion_odonata$s)
length(multitree_odonata$tree3$tip.label) # mais especies que na inserção
length(insertion_odonata$s) # tem que conter todas as especies
