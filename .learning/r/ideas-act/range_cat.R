#' @examples
#' 
#' 74999:225001 |> range_cat(c(0, 75000, 125000, 175000, 225000))
#' 
range_cat = function (
		.seq, 
		.cats, 
		.fn_as = base::identity, 
		..cats = base::c(-Inf, base::sort(.cats), Inf) |> .fn_as(), 
		..cats_chr = ..cats |> base::format(scientific = F, trim = T), 
		..catts = base::paste(
			..cats_chr, 
			..cats_chr[base::seq(base::length(..cats_chr)) |> utils::tail(-1)] |> base::c(Inf), 
			sep = ' -> ')) .seq |> 
	tibble::tibble(src_term = _) |> 
	dplyr::mutate(cat_index = .fn_as(src_term) |> base::findInterval(..cats)) |> 
	dplyr::mutate(
		cat_range = ..catts[cat_index], 
		cat_until = ..cats[cat_index]) 

#| > 74999:225001 |> range_cat(c(0, 75000, 125000, 175000, 225000)) |> data.table::setDT() |> print()
#|         src_term cat_index        cat_range cat_until
#|            <int>     <int>           <char>     <num>
#|      1:    74999         1       0 -> 75000         0
#|      2:    75000         2  75000 -> 125000     75000
#|      3:    75001         2  75000 -> 125000     75000
#|      4:    75002         2  75000 -> 125000     75000
#|      5:    75003         2  75000 -> 125000     75000
#|     ---                                              
#| 149999:   224997         4 175000 -> 225000    175000
#| 150000:   224998         4 175000 -> 225000    175000
#| 150001:   224999         4 175000 -> 225000    175000
#| 150002:   225000         5    225000 -> Inf    225000
#| 150003:   225001         5    225000 -> Inf    225000
