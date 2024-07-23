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
	
	available_packages <- utils::available.packages()
	
	ver_local = \ (.data, .path_field, .name_field) \ (N) if (.data[N, .path_field] != "") base::as.character(utils::packageVersion(.data[N, .name_field])) else NA_character_
	ver_repos = \ (.data, .fields, .name_field) \ (N) if (.data[N, .name_field] %in% row.names(available_packages)) available_packages[.data[N, .name_field], .fields] else NA_character_
	
	.requires$local_at = .requires$require |> vapply(\ (P) base::system.file(package = P), FUN.VALUE = "character")
	.requires$local_ver = seq(nrow(.requires)) |> vapply(ver_local (.requires, 'local_at', 'require'), FUN.VALUE = "character")
	.requires$repo_at = seq(nrow(.requires)) |> vapply(ver_repos (.requires, 'Repository', 'require'), FUN.VALUE = "character")
	.requires$repo_ver = seq(nrow(.requires)) |> vapply(ver_repos (.requires, 'Version', 'require'), FUN.VALUE = "character")
	
	rplz = \ (.if) \ (.d) \ (.x) base::replace(.x, .if(.x), .d)
	rplz.na = rplz (base::is.na)
	versionplz.na = rplz.na ("0.0.0")
	
	.requires$required = base::package_version(versionplz.na (.requires$repo_ver)) > base::package_version(versionplz.na (.requires$local_ver))
	
	return(.requires)
}

full = pkg_requires(full)

utils::install.packages(full[full$required, 'require'])

##: see: https://shinylive.io/r/editor/#code=NobwRAdghgtgpmAXGADgawOYCc4EcB0ASmADRgDGA9hAC5y1JgBGUAzgJbkAEAvFy6ziJE5ABQAdCOJoByGpxqVyMkpOkyMAGwCucFWtnyAJgE8AbnCyD9U2QDNtWJzfVH2du0bsv7OXDSgmTThWHxk7SixyKBpQ1VsZeBhKdmt41zgzRUpNOIMZIxi2OFiwmChsdhoaLBkASjUIZJxefmLhMXzozU1a9NkjGhRNEz78oyZh0bCMDGHKGgAmMKxNKAgMMM1KWcsykoALSiM8hPKTJj0GqQgHHtaBIRFRZrgSNo5ya8l0DAB9Pzadg4VitSQOCDkeTULiiQHAkLXEAGfDwkEPdqIQoBfB2LCwOBwvBAlp8R7CbQQdi4XREmkI1h1b40AxQMxQdhrIJwP4oKDkNAVEJcAA8AFouGyOVzgvg+QKhaxRMyDBYsH9tt0weJYfhsVB3nKYgc-nZ2HBNEZDdB4KbzZa6lxxDrRAA5R3uXX64Cuw18mgms0WowAXS4AEI+OIwNHHeTEGx8OQDlB8VDLKJtPJcsJ5YKMHAAGqWDjUUR6oo+60Eu3BkNMrgWwRcV0AQT+ydT-Lo6tVlgBcBQlFBUZdFYChqDltY1dtU6MjudsPdXE95e9vq4+BtPPnYYApOwIPuuFhKAB3bcEpVSzmBYK8-n5xGO28ynl5xXAcdQKtbne1paIaTvaJxhk2cAtu2nZpj2fwGCiaIhAAJJqUCaH8MStKixIMshSFcAAPgAfFw7IoFMEgugACnGmKsCYrB0DAuKcoSn4Fq0tHvAAYgAqq6+CFq2AAyfEAKJghQKawZYsaIbhIKoUo6F-GqrSCLgogQGe57lkhjKOiRZFQBRIyiGqGoqZouoGe8MhoRhMQqFwMhIfUvECUJokSVJMHdnJYDMjh9JKTgQ6YTQGl4Npun6YpL5EaR5GUZZ4XDrZCUzq5hCDsOVSRCYLluQlHlcPxgnCWJklRtJXbplg8m2CFJIoelamWNFWk6Re8WhYlxkpeZaV5aCfWtdlMjFlY7DUMV7l1J5lU+TVTp1bJjVBQhthYMMABe2q6u4i5jguTpjgAHnRgjCOFazkIS+AXYa7jlldhoLgYu2aHtV6tN9B2iPGqRXsyaqljp+1-XwAN-RIYAAAz4EjCNNdICn9aw+EJUYGI3YgHE8uDs0QBZJYk7D0CZZj2MRWqDakfGhMdTNZbE9QlNQNTE3Kd0LNMtt0g4DQjiky1DLXAAvo0dw2XwvwDpjoiy98EBZpyrDCEeTHoZoRoKgWSqy8AsvY-1Vque59aSGAkshkAA


