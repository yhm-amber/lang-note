#' @name rdses_diff
#' @description
#' Diff two folder that only have rds files
#' 
#' @param path_same same in path
#' @param diff_path_base subpath base
#' @param diff_path_comp subpath comp
#' @param .func_sort sort function to let you make sort rule for datasets (default: `dplyr::arrange_all`)
#' @param .future_plan the parallel mode for future parallel functions (default: `future::multisession`)
#' 
#' @examples
#' 
#'   future::plan(future::sequential)
#'   rdses_diff(
#'     path_same = "path/to/some/path",
#'     diff_path_base = 'dir/somedir_a/dir_maybe',
#'     diff_path_comp = 'dir/somedir_b/dir_maybe', 
#'     .future_plan = future::multisession) -> report
#'   future::plan(future::sequential)
#'   
#'   report$diff_reports |> base::Filter(x = _, f = diffdf::diffdf_has_issues)
#' 
rdses_diff = function (
		path_same, 
		diff_path_base, 
		diff_path_comp, 
		.pathes = base::list(
			base = path_same |> base::file.path(diff_path_base),
			comp = path_same |> base::file.path(diff_path_comp)), 
		.files = .pathes |> base::lapply(base::list.files), 
		.future_plan = future::multisession, 
		.func_sort = dplyr::arrange_all) 
{
	.files_base_lack = .files$comp |> base::setdiff(.files$base)
	.files_comp_lack = .files$base |> base::setdiff(.files$comp)
	
	if (base::length(.files_base_lack) > 0) usethis::ui_warn("Lack in BASE: {usethis::ui_value(.files_base_lack)}")
	if (base::length(.files_comp_lack) > 0) usethis::ui_warn("Lack in COMP: {usethis::ui_value(.files_comp_lack)}")
	
	files_intersect = .files |> base::Reduce(x = _, f = base::intersect)
	base::names(files_intersect) = files_intersect
	
	usethis::ui_info("Comparing files: {usethis::ui_value(files_intersect)}")
	
	files_fullpath = .pathes |> base::lapply(\ (dir_path) base::'names<-'(
		x = base::file.path(dir_path, files_intersect), 
		value = files_intersect))
	
	pathpairs = files_intersect |> 
		base::lapply(\ (file) base::list(
			base = files_fullpath$base[file], 
			compare = files_fullpath$comp[file]))
	
	future::plan(.future_plan)
	pathpairs |> 
		future.apply::future_lapply(
			\ (pathes) pathes |> 
				base::lapply(base::readRDS) |> 
				base::lapply(data.table::as.data.table) |> 
				base::lapply(.func_sort) |> 
				base::lapply(data.table::as.data.table) |> 
				base::Reduce(x = _, f = diffdf::diffdf)) |> 
		base::identity() -> .reports
	
	base::list(
		file_lack = base::list(
			base = .files_base_lack, 
			comp = .files_comp_lack), 
		issue_reports = base::Filter(
			f = diffdf::diffdf_has_issues, 
			x = .reports), 
		diff_reports = .reports)
}

