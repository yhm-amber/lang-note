
#' @example base::c(0x6719L, 0x6c49L) |> magrittr::'%T>%'({ base::class(.) = 'codepoint' }) |> base::print()
print.codepoint <- \ (codepoint) base::as.hexmode(codepoint) |> 
	base::toupper() |> 
	# 附各值首
	purrr::map(~ .x |> base::append(after = 0, 'U+')) |> 
	purrr::map_chr(~ .x |> base::paste(collapse = '')) |> 
	# 附此目首
	base::append(after = 0, 'codepoint') |> 
	base::append(after = 1, glue::glue_safe(
		n = base::length(codepoint), '[1:{n}]')) |> 
	# 显
	magrittr::'%T>%'(glue:::print.glue(sep = ' ')) |> 
	# 果不見
	base::invisible()

#' @example 
#' base::list(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> 
#' 	magrittr::'%T>%'({ base::class(.) = 'codepoint.ls' }) |> 
#' 	base::print()
#' @example 
#' base::list(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> 
#' 	purrr::map(~ .x |> magrittr::'%T>%'({ base::class(.) = 'codepoint' })) |> 
#' 	magrittr::'%T>%'({ base::class(.) = 'codepoint.ls' }) |> 
#' 	base::print()
print.codepoint.ls <- print.codepoints <- \ (
		x, 
		.titleid_specify = x |> 
			purrr::map_chr(base::class) |> 
			tools::toTitleCase() |> 
			base::unique() |> 
			base::paste(collapse = '/') |> 
			base::invisible(), 
		.n = base::names(x)) x |> 
	# 当致
	purrr::map(~ .x |> magrittr::'%T>%'({ base::class(.) <- base::c('codepoint') })) |> 
	# 成各自指
	printool_outpre.list_namemark(.capby = base::print, .n = .n) |> 
	# 结首在尾 示
	magrittr::'%T>%'({ . |> 
		printool_outpre.list_headmark(
			.titleid_specify = .titleid_specify, 
			.n = .n) |> 
		base::cat()}) |> 
	# 果当不見
	base::invisible()

#' @example base::c('0x6719', '0x6c49') |> codepointhex.as_codepoint() #> codepoint [1:2] U+6719 U+6C49
#' @example base::c(0x6719, 0x6c49) |> base::as.integer() |> codepointhex.as_codepoint() #> codepoint [1:2] U+6719 U+6C49
#' @example base::c(0x6719L, 0x6c49L) |> codepointhex.as_codepoint() #> codepoint [1:2] U+6719 U+6C49
codepointhex.as_codepoint <- function (codepointhex) codepointhex |> 
	# 毋使谬 转
	magrittr::'%>%'(
	{
		if 
			(base::is.character(.)) . |> base::strtoi(16L) else if 
			(base::is.integer(.)) . else if 
			(T) base::stop('utf8 code point must be int (hex chr support)')
	}) |> 
	# 是目 及型
	magrittr::'%T>%'({ base::class(.) <- base::c('codepoint') }) |> 
	# 出
	base::identity()

#' @example base::c(a = 0x6719L, b = 0x6c49L) |> codepointhexls.as_codepoints() #> Codepoint List: a: U+6719; b: U+6C49
#' @example base::list(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> codepointhexls.as_codepoints() #> Codepoint List: a: U+6719, U+6C49; b: U+6719
codepointhexls.as_codepoints <- function (codepointhex.ls) codepointhex.ls |> 
	purrr::map(~ .x |> 
		# 转 使正
		codepointhex.as_codepoint() |> 
		base::invisible()) |> 
	# 是列 及型
	magrittr::'%T>%'({ base::class(.) <- base::c('codepoint.ls', 'codepoints') }) |> 
	# 是止
	base::identity()



#' @example base::c('0x6719', '0x6c49') |> codepoint.gen_utf8text() #> "朙" "汉"
#' @example base::c(0x6719, 0x6c49) |> base::as.integer() |> codepoint.gen_utf8text() #> "朙" "汉"
#' @example base::c(a = 0x6719L, b = 0x6c49L) |> codepoint.gen_utf8text() #> a: "朙", b: "汉"
#' @example base::list(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> codepoint.gen_utf8text() #> a: "朙汉", b: "朙"
codepoint.gen_utf8text <- function (
		codepoints, 
		.show_input = T) codepoints |> 
	# 使正
	codepointhexls.as_codepoints() |> 
	# 若呈
	magrittr::'%T>%'({ if (base::isTRUE(.show_input)) base::print(.) }) |> 
	# 得字
	purrr::map_chr(base::intToUtf8) |> 
	# 是止
	base::identity()

#' @example base::c(a = '朙汉', b = '朙') |> utf8text.find_codepoint() #> a: U+6719, U+6C49; b: U+6719
#' @example base::list(a = '朙汉', b = '朙') |> utf8text.find_codepoint() #> a: U+6719, U+6C49; b: U+6719
utf8text.find_codepoint <- function (
		utf8texts) utf8texts |> 
	# 見其冥
	purrr::map(base::utf8ToInt) |> 
	# 須各型 列既指
	codepointhexls.as_codepoints() |> 
	# 見之
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





printool_outpre.list_namemark <- \ (
		x, 
		.capby = base::print, 
		.n = base::names(x)) x |> 
	# 暂去其名 使能元令
	magrittr::'%T>%'({ base::names(.) <- NULL }) |> 
	# 成身名身
	purrr::map(~ .capby(.x) |> utils::capture.output()) |> 
	purrr::map(~ base::list(content = .x |> base::trimws('both'))) |> 
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
	purrr::map(~ .x |> glue::glue_data_safe('{.i}: {content}')) |> 
	purrr::map(~ '$' |> base::paste(.x)) |> 
	# 出
	base::identity()

printool_outpre.list_headmark <- \ (
		x, 
		.titleid_specify = x |> 
			purrr::map_chr(base::class) |> 
			tools::toTitleCase() |> 
			base::unique() |> 
			base::paste(collapse = '/') |> 
			base::invisible(), 
		.n = base::names(x)) x |> 
	magrittr::'%>%'(
	{
		(if (!base::is.null(.n)) 'Named') |> 
			base::c(.titleid_specify) |> 
			base::c('List of') |> 
			base::c(base::length(.)) |> 
			# 合部为篱首
			base::paste(collapse = ' ') |> 
			glue::glue_safe(head = _, '>>> {head} <<<') |> 
			# 合余至
			base::c(.) |> base::c('') |> 
			base::paste(collapse = '\n') |> 
			# 不示
			base::invisible()
	}) |> 
	# 出
	base::identity()


#' @describe let raw-ls has its show
#' @example base::c('e6 9c 99','e6 b1 89') |> rawtexts.as_raws() #: see the show
#' @example base::c(a = 'e6 9c 99',b = 'e6 b1 89') |> rawtexts.as_raws() #: see the named show
print.raw.ls <- print.raws <- \ (
		x, 
		.titleid_specify = x |> 
			purrr::map_chr(base::class) |> 
			tools::toTitleCase() |> 
			base::unique() |> 
			base::paste(collapse = '/') |> 
			base::invisible(), 
		.n = base::names(x)) x |> 
	# 成各自指
	printool_outpre.list_namemark(.capby = utils::str, .n = .n) |> 
	# 结首在尾 示
	magrittr::'%T>%'({ . |> 
		printool_outpre.list_headmark(
			.titleid_specify = .titleid_specify, 
			.n = .n) |> 
		base::cat()}) |> 
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
