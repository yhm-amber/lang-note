#' Multi Thread
#' - https://stackoverflow.com/questions/61750943/is-there-an-newer-version-or-alternative-for-data-table-in-r



#' summarise syntax
#' 
#' see: 
#' - https://stackoverflow.com/questions/36526141/summarize-data-table-by-group
#' 
#' 

data.table::as.data.table(dplyr::starwars)[
	i = T, 
	j = .(h = mean(height), m = sum(mass)), 
	by = .(species, homeworld)] -> a

dtplyr::lazy_dt(dplyr::starwars, immutable = F) |> 
	dplyr::group_by(species, homeworld) |> 
	dplyr::summarise(h = mean(height), m = sum(mass)) |> 
	data.table::as.data.table() -> b

a |> diffdf::diffdf(b, keys = base::c("species", "homeworld")) # No issues were found!


#' left join
#' 
#' more join see: 
#' - https://stackoverflow.com/questions/1299871/how-to-join-merge-data-frames-inner-outer-left-right
#' - https://stackoverflow.com/questions/34598139/left-join-using-data-table
#' 
#' 

tibble::tribble(
	~ species_x,  	~ homeworld, 	~ choosing, 
	  "Human",    	  "Naboo",   	  F, 
	  "Gungan",   	  "Naboo",   	  T, 
	  "Human",    	  "Stewjon", 	  T, 
	  "Iktotchi", 	  "Naboo",   	  T) -> x

data.table::copy(b) [i = x, on = base::c("species"="species_x", "homeworld"), j = choosing := choosing] -> a.j0
data.table::as.data.table(x) [i = b, on = base::c("species_x"="species", "homeworld")] |> data.table::setnames(old = "species_x", new = "species") -> a.j1
data.table::merge.data.table(x = b, y = x, by.x = base::c("species", "homeworld"), by.y = base::c("species_x", "homeworld"), all.x = T) -> a.j2

a.j0 |> diffdf::diffdf(a.j2, keys = base::c("species", "homeworld")) # No issues were found!
a.j1 |> diffdf::diffdf(a.j2, keys = base::c("species", "homeworld")) # No issues were found!

dtplyr::lazy_dt(b, immutable = T) |> dplyr::left_join(x, by = base::c("species"="species_x", "homeworld")) |> data.table::as.data.table() -> b.j

b.j |> diffdf::diffdf(a.j2, keys = base::c("species", "homeworld")) # No issues were found!


