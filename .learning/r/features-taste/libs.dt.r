
#' summarise syntax
#' 

data.table::as.data.table(dplyr::starwars)[
  T, 
  .(h = mean(height), m = sum(mass)), 
  by = .(species, homeworld)] -> a

dtplyr::lazy_dt(dplyr::starwars) |> 
  dplyr::group_by(species, homeworld) |> 
  dplyr::summarise(h = mean(height), m = sum(mass)) |> 
  data.table::as.data.table() -> b

a|>diffdf::diffdf(b, keys = base::c("species", "homeworld"))
# No issues were found!
