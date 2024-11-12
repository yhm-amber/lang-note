#' @examples
#' 
#' 74999:225001 |> range_cat(c(0, 75000, 125000, 175000, 225000))
#' 
range_cat = function (
		.seq, 
		.cats, 
		..catts = base::paste(
			.cats, 
			.cats[base::seq(base::length(.cats)) |> utils::tail(-1)] |> base::c(Inf), 
			sep = ' -> ')) .seq |> 
	tibble::tibble(src_term = _) |> 
	dplyr::mutate(cat_index = base::findInterval(src_term, .cats)) |> 
	dplyr::mutate(
		cat_range = ..catts[cat_index], 
		cat_until = .cats[cat_index]) 

#| > 74999:225001 |> range_cat(c(0, 75000, 125000, 175000, 225000)) |> data.table::setDT() |> print()
