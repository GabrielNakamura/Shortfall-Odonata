function(phylo, data, level = "Congeneric_insertion"){
  if(is.null(phylo) == TRUE){
    stop("/n A phylogenetic tree must be provided")
  }
  if(class(phylo) != "phylo"){
    stop("/n A phylo object must be provided")
  }
  names_exclude <- phylo$tip.label[na.omit(match(data[which(data$insertions == "Present_in_Tree"), "s"], 
                                                 phylo$tip.label))]
  
  if(all(!is.na(match( phylo$tip.label, names_exclude))) == TRUE){
    PD_present <- sum(phylo$edge.length)
    Darwinian_defict <- 0
    comm_total <- matrix(data = rep(1, length(phylo$tip.label)),
                         ncol = length(phylo$tip.label),
                         nrow = 1, dimnames = list("comm1", phylo$tip.label))
    PD_total <- picante::pd(samp = comm_total, tree = phylo)$PD
    PD_level <- 0
    
  } else{
    exclude <- ape::drop.tip(phylo, tip = names_exclude)$tip.label
    phylo_present <- ape::drop.tip(phylo, tip = exclude)
    comm_present <- matrix(data = rep(1, length(phylo_present$tip.label)), nrow = 1, 
                           ncol = length(phylo_present$tip.label), 
                           dimnames = list("comm1", phylo_present$tip.label))
    PD_present <- picante::pd(samp = comm_present, tree = phylo_present)$PD
    # PD_present <- sum(phylo_present$edge.length)
    if(length(level) == 1){
      level_exclude <- ape::drop.tip(phylo, tip = phylo$tip.label[na.omit(match(data[which(data$insertions == level), "s"], 
                                                                                phylo$tip.label))])$tip.label
    }
    if(length(level) > 1){
      level_exclude <- ape::drop.tip(phylo, data[!is.na(match(data$insertions, level)), "s"])$tip.label 
    }
    phylo_level <- ape::drop.tip(phylo, level_exclude)
    comm_level <- matrix(data = rep(1, length(phylo_level$tip.label)), nrow = 1, 
                         ncol = length(phylo_level$tip.label), 
                         dimnames = list("comm1", phylo_level$tip.label))
    PD_level <- picante::pd(samp = comm_level, tree = phylo_level)$PD
    # PD_level <- sum(phylo_level$edge.length)
    comm_total <- matrix(data = rep(1, length(phylo$tip.label)),
                         ncol = length(phylo$tip.label),
                         nrow = 1, dimnames = list("comm1", phylo$tip.label))
    PD_total <- picante::pd(samp = comm_total, tree = phylo)$PD
    #PD_total <- sum(PD_present, PD_level)
    Darwinian_deficit <- PD_level/PD_total
    res <- c(PD_present, PD_level, PD_total, Darwinian_deficit)
    names(res) <- c("PDintree", "PDdeficit", "PDtotal", "Darwinian_deficit")
    return(res)
  }
}