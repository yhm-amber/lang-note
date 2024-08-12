readxl_sheets = function (path, ...) 
{
	sheet_names = readxl::excel_sheets(path)
	base::names(sheet_names) = sheet_names
	
	usethis::ui_info("Loading sheets: {usethis::ui_value(sheet_names)}")
	
	sheet_names |> 
		base::lapply(\ (sheet_name) readxl::read_excel(
			path = path, 
			sheet = sheet_name, 
			...)) |> 
		base::identity()
}


readxl_sheets = function (path, ...) 
	
	readxl::excel_sheets(path) |> 
		magrittr::'%>%'(base::'names<-'(.,.)) |> 
		magrittr::'%T>%'({usethis::ui_info("Loading sheets: {usethis::ui_value(.)}")}) |> 
		base::lapply(\ (sheet_name) readxl::read_excel(
			path = path, 
			sheet = sheet_name, 
			...)) |> 
		base::identity()


readxl_diffsheets = function (
		path_base, 
		path_comp, 
		pathes = base::list(
			base = path_base,
			comp = path_comp), 
		...) 
{
	usethis::ui_info("Loading workbooks: {usethis::ui_value(pathes)}")
	
	sheets_names = pathes |> base::lapply(readxl::excel_sheets)
	sheets_intersect = sheets_names |> base::Reduce(x = _, f = base::intersect)
	base::names(sheets_intersect) = sheets_intersect
	
	sheets_names |> 
		purrr::map(~ base::setdiff(x = .x, y = sheets_intersect)) |> 
		purrr::imap(\ (x, n) usethis::ui_info(
			"Sheets only in {usethis::ui_value(n)}: {usethis::ui_value(x)}"))
	
	usethis::ui_info("Diffing sheets: {usethis::ui_value(sheets_intersect)}")
	
	sheets_intersect |> 
		base::lapply(
			\ (sheet_name) pathes |> 
				base::lapply(\ (path) readxl::read_excel(
					path = path, 
					sheet = sheet_name, 
					...)) |> 
				base::Reduce(
					f = \ (a,b) diffdf::diffdf(
						base = a, 
						compare = b, 
						...), 
					x = _)) |> 
		base::identity()
}


readxl_diffsheets = function (
		path_base, 
		path_comp, 
		pathes = base::list(
			base = path_base,
			comp = path_comp), 
		...) pathes |> 
	magrittr::'%T>%'({usethis::ui_info("Loading workbooks: {usethis::ui_value(.)}")}) |> 
	base::lapply(readxl::excel_sheets) |> 
	magrittr::'%>%'(
		(function (
			sheets_names, 
			sheets_intersect = base::Reduce(
				f = base::intersect, 
				x = sheets_names)) 
		{
			sheets_names |> 
				purrr::map(~ base::setdiff(x = .x, y = sheets_intersect)) |> 
				purrr::imap(\ (x, n) usethis::ui_info(
					"Sheets only in {usethis::ui_value(n)}: {usethis::ui_value(x)}"))
			
			usethis::ui_info("Diffing sheets: {usethis::ui_value(sheets_intersect)}")
			
			sheets_intersect
		})) |> 
	magrittr::'%>%'(base::'names<-'(.,.)) |> 
	base::lapply(
		\ (sheet_name) pathes |> 
			base::lapply(\ (path) readxl::read_excel(
				path = path, 
				sheet = sheet_name, 
				...)) |> 
			base::Reduce(
				f = \ (a,b) diffdf::diffdf(
					base = a, 
					compare = b, 
					...), 
				x = _)) |> 
	base::identity()





