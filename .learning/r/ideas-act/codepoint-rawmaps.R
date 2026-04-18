
#' @example base::c('0x6719', '0x6c49') |> codepoint.gen_utf8_text() #> "朙汉"
codepoint.gen_utf8_text <- function (codepoints) codepoints |> 
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
			purrr::map(~ .x |> base::append(after = 0, 'U+')) |> 
			purrr::map_chr(~ .x |> base::paste(collapse = '')) |> 
			base::append(after = 0, 'Code Point(s) Input:') |> 
			usethis::ui_info()
	}) |> 
	# 得字
	base::intToUtf8() |> 
	# 是止
	base::identity()

#' @describe make encoding-raw text as raw type in ls
#' @example base::c('e6 9c 99','e6 b1 89') |> rawtexts.as_raws() #: Raw List of 2
rawtexts.as_raws <- function (
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
#' @example base::c('e6 9c 99','e6 b1 89') |> rawtexts.as_raws() #: see the show
#' @example base::c(a = 'e6 9c 99',b = 'e6 b1 89') |> rawtexts.as_raws() #: see the named show
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

#' @describe create raw.ls from encoding-raw text(s).
#' @example raws.from_text('e6 9c 99','e6 b1 89') #: see the created raw.ls
#' @example raws.from_text(a = 'e6 9c 99',b = 'e6 b1 89') #: see the created named raw.ls
raws.from_text <- function (
		..., 
		.raw_numbase = 16L) base::c(...) |> 
	# 取 转
	rawtexts.as_raws(raw_numbase = .raw_numbase) |> 
	# 用 可
	base::identity()

#' @describe trans raw.ls as its chr(s)
#' @example raws.from_text(a = 'e6 9c 99',b = 'e6 b1 89') |> raws.as_chrs() #: a: "朙", b: "汉"
raws.as_chrs <- function (raw.ls) raw.ls |> 
	# 逐变之
	purrr::map_chr(base::rawToChar) |> 
	# 此
	base::identity()

#' @describe trans chr(s) as its raw.ls
#' @example base::c(a = '朙', b = '汉') |> chrs.as_raws() #: a: e6 9c 99, b: e6 b1 89
chrs.as_raws <- function (chrs) chrs |> 
	# 逐变之
	purrr::map(base::charToRaw) |> 
	# 是列 型
	magrittr::'%T>%'({ base::class(.) <- base::c('raws', 'raw.ls') }) |> 
	# 此
	base::identity()

#' @describe make char from encoding-raw text
#' @example base::c('e6 9c 99','e6 b1 89') |> rawtexts.as_chrs() #: "朙" "汉"
#' @example base::c(a = 'e6 9c 99', b = 'e6 b1 89') |> rawtexts.as_chrs() #: a: "朙", b: "汉"
rawtexts.as_chrs <- function (
		raw_text, 
		raw_numbase = 16L) raw_text |> 
	# 得弦而用 至本相
	rawtexts.as_raws(raw_numbase = raw_numbase) |> 
	# 自本显明 知何如
	raws.as_chrs() |> 
	# 此
	base::identity()
