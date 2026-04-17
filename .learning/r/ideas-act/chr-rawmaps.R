
codepoint_getchr <- function (codepoint) codepoint |> 
	# 毋使谬
	magrittr::'%>%'(
	{
		if 
			(base::is.character(.)) . |> base::strtoi(16L) else if 
			(base::is.integer(.)) . else if 
			(T) base::stop('utf8 code point must be int (hex chr support)')
	}) |> 
	# 呈若显
	magrittr::'%T>%'(
	{
		base::as.hexmode(.) |> 
			base::toupper() |> 
			base::append(after = 0, 'U+') |> 
			base::paste(collapse = '') |> 
			usethis::ui_info()
	}) |> 
	# 得字
	base::intToUtf8() |> 
	# 是止
	base::identity()

#' @describe make encoding-raw text as raw type in ls
#' @example base::c('e6 9c 99','e6 b1 89') |> as_raws.raw_texts() #: Raw List of 2
as_raws.raw_texts <- function (
		raw_texts, 
		raw_numbase = 16L) raw_texts |> 
	base::gsub(x = _, '[^0-9a-fA-F]', '') |> 
	base::strsplit("(?<=..)", perl = TRUE) |> 
	# 得弦而接 是为本目
	purrr::map(~ .x |> strtoi(raw_numbase) |> as.raw()) |> 
	# 是列 及型
	magrittr::'%T>%'({ base::class(.) <- base::c('raws', 'raw.ls') }) |> 
	# 至
	base::identity()

#' @describe let raw-ls has its show
#' @example base::c('e6 9c 99','e6 b1 89') |> as_raws.raw_texts() #: see the show
print.raw.ls = \ (x, .n = base::names(x)) xx |> 
	# 暂去其名 使能元令
	magrittr::'%T>%'({ base::names(.) <- NULL }) |> 
	# 成身
	purrr::map(~ utils::str(.x) |> utils::capture.output()) |> 
	# 名身
	purrr::map(~ base::list(raw = .x)) |> 
	# 加令元令
	purrr::imap(\ (.x, .i) .x |> magrittr::'%T>%'({ .$index <- .i })) |> 
	magrittr::'%T>%'({ base::names(.) <- .n }) |> 
	# 若初有名 复之 及加冕 若无名 亦使能自处
	purrr::imap(\ (.x, .i) .x |> base::c(base::list(
		name = if (base::is.character(.i)) .i))) |> 
	# 有名自有 无名自无
	purrr::map(~ .x |> magrittr::'%T>%'(
	{
		.$.i <- . |> 
			glue::glue_data_safe('({name})') |> 
			# 有名自有此 无名自无此
			base::append(after = 0, .['index']) |> 
			base::paste(collapse = ' ') |> 
			base::identity()
	})) |> 
	# 合身与令
	purrr::map(~ .x |> glue::glue_data_safe('{.i}:{raw}')) |> 
	purrr::map(~ '$' |> base::paste(.x)) |> 
	# 结首在尾
	magrittr::'%T>%'(
	{
		(if (!base::is.null(.n)) 'Named') |> 
			base::c('Raw List of') |> 
			base::c(base::length(.)) |> 
			# 合部为篱
			base::paste(collapse = ' ') |> 
			glue::glue_safe(head = _, '>>> {head} <<<') |> 
			# 合余为至
			base::c(.) |> base::c('') |> 
			base::paste(collapse = '\n') |> 
			# 示
			base::cat()
	}) |> 
	# 果当不見
	base::invisible()




#' @describe make char from encoding-raw text
#' @example base::c('e6 9c 99','e6 b1 89') |> rawtext_chr() #: "朙" "汉"
rawtext_chr <- function (
		raw_texts, 
		raw_numbase = 16L) raw_texts |> 
	# 得弦而用 至本相
	as_raws.raw_texts(raw_numbase = raw_numbase) |> 
	# 自本显明 知何如
	purrr::map_chr(rawToChar) |> 
	# 此
	base::identity()





