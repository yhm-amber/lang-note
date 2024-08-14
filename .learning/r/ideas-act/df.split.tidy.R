df_split = function (.df, ...) .df |> 
	dplyr::group_split(...) |> 
	magrittr::'%>%'(base::'names<-'(., purrr::map(
		.x = ., 
		.f = \ (a) a |> 
			dplyr::select(...) |> 
			base::unique())))

df_split_at = function (df, fields) df |> 
	dplyr::group_by(dplyr::pick(tidyselect::all_of(fields))) |> 
	dplyr::group_split() |> 
	magrittr::'%>%'(base::'names<-'(., purrr::map(
		.x = ., 
		.f = ~ .x |> 
			dplyr::select(tidyselect::all_of(fields)) |> 
			base::unique())))


style.no_pipe = \ () 
{
	df_split = function (.df, ...) 
	{
		.sp = .df |> 
			dplyr::group_split(...)
		
		base::names(.sp) = .sp |> base::lapply(
			\ (a) a |> 
				dplyr::select(...) |> 
				base::unique())
		.sp
	}
	
	df_split_at = function (df, fields) 
	{
		.sp = df |> 
			dplyr::group_by(dplyr::pick(tidyselect::all_of(fields))) |> 
			dplyr::group_split()
		
		base::names(.sp) = .sp |> base::lapply(
			\ (a) a |> 
				dplyr::select(tidyselect::all_of(fields)) |> 
				base::unique())
		.sp
	}
}
