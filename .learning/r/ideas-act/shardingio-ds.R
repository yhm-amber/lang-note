

#' @name read_shardingds
#' @title Read multiple RDS datasets from a directory and combine them into a single data.table
#' @description This function reads multiple RDS files from a specified directory, each representing a shard of a dataset, and combines them into a single data.table.
#' @param ds_name The base name of the dataset (without shard identifier and file extension).
#' @param shards A vector of shard identifiers to read.
#' @param dir_path The directory path where the RDS files are located.
#' @param .filename_pattern A glue pattern for the RDS file names.
#' @param .reader A function to read the Dataset files (default is `base::readRDS`).
#' @param .max_workers Maximum number of parallel workers to use (default is the number of available CPU cores).
#' @param .supenv_insert Logical flag indicating whether to insert things in `.shardingds_env` into the `parent.frame` environment (default is FALSE).
#' @param ... Additional arguments to pass to the .reader function.
#' @return An invisible data.table containing the combined data from all specified shards.
#' And things also in `.shardingds_env` list.
#' @examples \dontrun{
#' combined_data = "your_dataset" |> read_shardingds(0:4)
#' 
#' data.table::setDT(storms_ds <- dplyr::storms)
#' storms_ds |> save_shardingds('month')
#' #> • Saving dataset storms_ds for sharding: 6, 7, 8, 9, 10, 11, 5, 12, 4, 1
#' 
#' df = 'storms_ds' |> read_shardingds(base::c(6, 7, 8, 9, 10, 11, 5, 12, 4, 1))
#' dplyr::arrange_all(df) |> diffdf::diffdf(dplyr::arrange_all(storms_ds))
#' #> No issues were found!
#' }
#' @export
#' 
read_shardingds = function (
		ds_name, 
		shards, 
		dir_path = here::here(ds_name), 
		.filename_pattern = "{ds_name}.{shard}.rds", 
		.reader = base::readRDS, 
		.max_workers = parallel::detectCores(), 
		.supenv_insert = F, 
		...) 
{
	{
		mc.cores.0 = base::getOption('mc.cores')
		base::options(mc.cores = base::length(shards) |> base::pmax(.max_workers))
	}
	
	{
		.shardingds_env <<- base::list()
		.shardingds_env[[ds_name]] <<- dir_path |> withr::with_dir({
			shards |> parallel::mclapply(\ (shard) {
				glue::glue(.filename_pattern) |> 
					magrittr::'%T>%'({ usethis::ui_info(
						"Reading {usethis::ui_field(.)} in dir {usethis::ui_value(fs::path_wd())}") }) |> 
					.reader(...) |> data.table::setDT()
			})
		}) |> data.table::rbindlist(fill = T)
	}
	
	{
		base::options(mc.cores = mc.cores.0)
		if (base::isTRUE(.supenv_insert)) .shardingds_env |> base::list2env(base::parent.frame())
	}
	
	base::return(base::invisible(.shardingds_env[[ds_name]]))
}



#' @name save_shardingds
#' @title Save a data.table into multiple RDS files, each representing a shard of the dataset
#' @description This function saves a data.table into multiple RDS files in a specified directory, partitioned by a specified column.
#' @param df The data.table to be saved.
#' @param by The column name used to partition the dataset into shards (default is '.shard').
#' @param ds_name The base name of the dataset (default is the name of the data.table).
#' @param shards A vector of shard identifiers to save (default is the unique values in the `by` column).
#' @param dir_path The directory path where the RDS files will be saved.
#' @param .filename_pattern A glue pattern for the RDS file names.
#' @param .writer A function to write the Dataset files (default is `base::saveRDS`).
#' @param .max_workers Maximum number of parallel workers to use (default is the number of available CPU cores).
#' @param ... Additional arguments to pass to the .writer function.
#' @return An invisible list of results from the write operations.
#' @examples \dontrun{
#' data.table::setDT(storms_ds <- dplyr::storms)
#' storms_ds |> save_shardingds('month')
#' #> • Saving dataset storms_ds for sharding: 6, 7, 8, 9, 10, 11, 5, 12, 4, 1
#' 
#' #| > data.table::setDT(fs::dir_info(here::here('storms_ds')))[, .(path = fs::path_rel(path), size)]
#' #|                           path       size
#' #|                      <fs_path> <fs_bytes>
#' #|  1:  storms_ds/storms_ds.1.rds      1.17K
#' #|  2: storms_ds/storms_ds.10.rds     23.47K
#' #|  3: storms_ds/storms_ds.11.rds      9.51K
#' #|  4: storms_ds/storms_ds.12.rds      2.17K
#' #|  5:  storms_ds/storms_ds.4.rds      1.02K
#' #|  6:  storms_ds/storms_ds.5.rds      2.22K
#' #|  7:  storms_ds/storms_ds.6.rds      6.58K
#' #|  8:  storms_ds/storms_ds.7.rds     12.59K
#' #|  9:  storms_ds/storms_ds.8.rds     31.03K
#' #| 10:  storms_ds/storms_ds.9.rds     53.05K
#' }
#' @export
#' 
save_shardingds = function (
		df, 
		by = '.shard', 
		ds_name = base::deparse(base::substitute(df)), 
		shards = base::unique(df[[by]]), 
		dir_path = here::here(ds_name), 
		.filename_pattern = "{ds_name}.{shard}.rds", 
		.writer = base::saveRDS, 
		.max_workers = parallel::detectCores(), 
		...) 
{
	{
		mc.cores.0 = base::getOption('mc.cores')
		base::options(mc.cores = base::length(shards) |> base::pmax(.max_workers))
	}
	
	{
		usethis::ui_todo("Saving dataset {usethis::ui_field(ds_name)} for sharding: {usethis::ui_value(shards)}")
		.res.ls = dir_path |> 
			magrittr::'%T>%'(fs::dir_create(.)) |> 
			withr::with_dir({
				shards |> parallel::mclapply(\ (shard) {
					data.table::setDT(df)[base::get(by) == shard] |> .writer(
						glue::glue(.filename_pattern) |> 
							magrittr::'%T>%'({ usethis::ui_info(
								"Writing {usethis::ui_field(.)} in dir {usethis::ui_value(fs::path_wd())}") }), 
						...)
				})
			})
	}
	
	{
		base::options(mc.cores = mc.cores.0)
	}
	
	base::return(base::invisible(.res.ls))
}


