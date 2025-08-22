
#' @title Package Requires
#' @name pkg_reqs
#' @param pk {character} to specify which package(s)' req you want to see.
#' @param .key_name {character} to specify the package col name.
#' @param .necessary {data.table} (user no need to set) a dataset include updatable packages.
#' @param .necess_select {data.table} (user no need to set) only select which cols from `.necessary`.
#' @return {data.table} a dataset includes required packages with their bys and updatabilitys.
#' 
pkg_reqs = \ (
		pk, 
		.key_name = 'pkg', 
		.necessary = data.table::as.data.table(utils::old.packages()) |> data.table::setnames('Package', .key_name), 
		.necess_select = base::colnames(.necessary) |> base::setdiff(.key_name)) pk |> 
	tools::package_dependencies(recursive = TRUE) |> 
	purrr::imap(\ (x, i) x |> base::append(i)) |> 
	purrr::imap(\ (x, i) data.table::data.table(pkg = x, reqby = i)) |> 
	data.table::rbindlist(fill = T) |> 
	data.table::setnames('pkg', .key_name) |> 
	data.table:::'[.data.table'(j = .(reqbys = paste(unique(reqby), collapse = ', ')), keyby = .(pkg)) |> 
	data.table:::'[.data.table'(
		i = .necessary[, new_versions := T], 
		j = (.necess_select) := base::mget(base::paste0('i', '.', .necess_select)), 
		on = .key_name) |> 
	data.table:::'[.data.table'(i = base::is.na(new_versions), j = new_versions := F) |> 
	base::identity()

#' @title Let the Package-Requires to Vector
#' @name pkgreqs_vec
#' @param reqs {data.table} a dataset returns by `pkg_reqs`.
#' @param only_news {logical} `TRUE` (as default) means only put out required packages which are updatable and `FALSE` means putout all.
#' @return {named character} required packages.
#' 
pkgreqs_vec = \ (reqs, only_news = T) reqs[new_versions | !only_news] |> 
	data.table:::'[.data.table'(j = {.x = pkg; names(.x) = reqbys; .x})


# Taste
pkg_reqs(c('tidyverse', 'dtplyr','data.table'))[new_versions == T]
pkg_reqs(c('tidyverse', 'dtplyr','data.table')) |> pkgreqs_vec(F)

