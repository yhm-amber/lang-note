basic = base::c(
	'tictoc',
	'glue',
	'tidyverse',
	'furrr',
	'diffdf',
	'freqtables',
	'forcats',
	'memoise',
	'devtools',
	'datasets',
	'magrittr')

more = base::c(
	'callr',
	'dtplyr',
	'dbplyr',
	'ggplot2',
	'rlang',
	'logger',
	'methods',
	'maybe')

full = base::c(more, basic)

pkg_requires = 
function (requires)
{
	.requires = base::data.frame(require = base::unique(requires))
	
	available_packages <- available.packages()
	
	ver_local = \ (.data, .path_field, .name_field) \ (N) if (.data[N, .path_field] != "") base::as.character(utils::packageVersion(.data[N, .name_field])) else NA_character_
	ver_repos = \ (.data, .fields, .name_field) \ (N) if (.data[N, .name_field] %in% row.names(available_packages)) available_packages[.data[N, .name_field], .fields] else NA_character_
	
	.requires$local_at = .requires$require |> vapply(\ (P) base::system.file(package = P), FUN.VALUE = "character")
	.requires$local_ver = seq(nrow(.requires)) |> vapply(ver_local (.requires, 'local_at', 'require'), FUN.VALUE = "character")
	.requires$repo_at = seq(nrow(.requires)) |> vapply(ver_repos (.requires, 'Repository', 'require'), FUN.VALUE = "character")
	.requires$repo_ver = seq(nrow(.requires)) |> vapply(ver_repos (.requires, 'Version', 'require'), FUN.VALUE = "character")
	
	rplz = \ (.if) \ (.d) \ (.x) base::replace(.x, .if(.x), .d)
	rplz.na = rplz (base::is.na)
	versionrplz.na = rplz.na ("0.0.0")
	
	.requires$required = base::package_version(versionrplz.na (.requires$repo_ver)) > base::package_version(versionrplz.na (.requires$local_ver))
	
	return(.requires)
}

full = pkg_requires(full)

utils::install.packages(full[full$required, 'require'])
