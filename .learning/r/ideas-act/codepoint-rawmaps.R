

#' @example raws.from_text(a = 'e6 9c 99', b = 'e6 b1 89') -> example_raws
#' @example example_raws |> raws.encoding_trans(from_encoding = 'UTF-8', to_encoding = 'GB18030') -> example_raws.1
#' @example example_raws.1 |> raws.encoding_trans(from_encoding = 'GBK', to_encoding = 'UTF-8') -> example_raws.2
#' @example #: `example_raws.2` should equals with `example_raws`, `example_raws.1`: a: 96 4c, b: ba ba.
raws.encoding_trans <- function (
		raw.ls, 
		from_encoding = '', 
		to_encoding = '') raws.as_chrs(raw.ls) |> 
	# 籍能以成
	base::iconv(
		from = from_encoding, 
		to = to_encoding, 
		toRaw = T) |> 
	# 是返列 型记
	cls_sign.raw_ls() |> 
	base::identity()



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
print.codepoint_ls <- print.codepoint.ls <- print.codepoints <- \ (
		x, 
		.titleid_specify = x |> 
			purrr::map_chr(base::class) |> 
			tools::toTitleCase() |> 
			base::unique() |> 
			base::paste(collapse = '/') |> 
			base::invisible(), 
		.n = base::names(x)) x |> 
	# 当致
	purrr::map(cls_sign.codepoint) |> 
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
	cls_sign.codepoint() |> 
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
	cls_sign.codepoint_ls() |> 
	# 是止
	base::identity()

#' @example codepoints.from_hex(a = 0x6719L, b = 0x6c49L) #> Codepoint List: a: U+6719; b: U+6C49
#' @example codepoints.from_hex(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) #> Codepoint List: a: U+6719, U+6C49; b: U+6719
codepoints.from_hex <- function (...) base::list(...) |> 
	codepointhexls.as_codepoints() |> 
	base::identity()

#' @example base::c('0x6719', '0x6c49') |> codepoints.gen_utf8texts() #> "朙" "汉"
#' @example base::c(0x6719, 0x6c49) |> base::as.integer() |> codepoints.gen_utf8texts() #> "朙" "汉"
#' @example base::c(a = 0x6719L, b = 0x6c49L) |> codepoints.gen_utf8texts() #> a: "朙", b: "汉"
#' @example base::list(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> codepoints.gen_utf8texts() #> a: "朙汉", b: "朙"
#' @example codepoints.from_hex(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> codepoints.gen_utf8texts() #> a: "朙汉", b: "朙"
codepoints.gen_utf8texts <- function (
		codepoints, 
		.show_input = T) codepoints |> 
	# 使正 纵已亦兼
	codepointhexls.as_codepoints() |> 
	# 若呈
	magrittr::'%T>%'({ if (base::isTRUE(.show_input)) messaged_print(.) }) |> 
	# 得字
	purrr::map_chr(base::intToUtf8) |> 
	# 是止
	base::identity()

#' @example base::c(a = '朙汉', b = '朙') |> utf8texts.find_codepoints() #> a: U+6719, U+6C49; b: U+6719
#' @example base::list(a = '朙汉', b = '朙') |> utf8texts.find_codepoints() #> a: U+6719, U+6C49; b: U+6719
utf8texts.find_codepoints <- function (
		utf8texts) utf8texts |> 
	# 見其冥
	purrr::map(base::utf8ToInt) |> 
	# 須各型 列既指
	codepointhexls.as_codepoints() |> 
	# 見之
	base::identity()


#' @example codepoints.from_hex(a = base::c(0x6719L, 0x6c49L), b = 0x6719L) |> codepoints.as_raws() #> a: e6 9c 99 e6 b1 89, b: e6 9c 99
codepoints.as_raws <- function (codepoint.ls) codepoint.ls |> 
	codepoints.gen_utf8texts(.show_input = F) |> 
	magrittr::'%T>%'(message.chrs_preview) |> 
	chrs.as_raws() |> 
	base::identity()


#' @example raws.from_text(a = 'e6 9c 99',b = 'e6 b1 89') |> raws.as_codepoints() #: a: U+6719, b: U+6C49
#' @example raws.from_text(a = 'e6 9c 99 e6 b1 89',b = 'e6 b1 89') |> raws.as_codepoints() #: a: U+6719 U+6C49, b: U+6C49
raws.as_codepoints <- function (raw.ls) raw.ls |> 
	raws.as_chrs() |> 
	magrittr::'%T>%'(message.chrs_preview) |> 
	utf8texts.find_codepoints() |> 
	base::identity()


message.chrs_preview <- \ (x, ...) base::print(x) |> 
	utils::capture.output(type = 'output') |> 
	base::append(after = 0, '~~~~') |> 
	base::append(after = 0, ': Chrs preview :') |> 
	base::append('~~~~') |> 
	base::paste(collapse = '\n') |> 
	base::message(...)

messaged_print <- \ (x, ...) base::print(x) |> 
	utils::capture.output(type = 'output') |> 
	base::paste(collapse = '\n') |> 
	base::message(...)

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
	cls_sign.raw_ls() |> 
	# 至
	base::identity()

sign_class <- \ (x, ...) x |> 
	magrittr::'%T>%'({ base::class(.) <- base::c(...) }) |> 
	base::identity()

cls_sign.raw_ls <- \ (x) x |> sign_class('raw_ls', 'raw.ls', 'raws') |> base::identity()
cls_sign.codepoint_ls <- \ (x) x |> sign_class('codepoint_ls', 'codepoint.ls', 'codepoints') |> base::identity()
cls_sign.codepoint <- \ (x) x |> sign_class('codepoint') |> base::identity()

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
print.raw_ls <- print.raw.ls <- print.raws <- \ (
		x, 
		.titleid_specify = x |> 
			purrr::map_chr(base::class) |> 
			tools::toTitleCase() |> 
			base::unique() |> 
			base::paste(collapse = '/') |> 
			base::invisible(), 
		.n = base::names(x)) x |> 
	# 成各自指
	printool_outpre.list_namemark(
		.capby = \ (a) a |> utils::str(
			vec.len = base::getOption('str')$vec.len |> 
				wrapr::'%?%'(0L) |> 
				base::pmax(3 * 8)), 
		.n = .n) |> 
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
	cls_sign.raw_ls() |> 
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






pua_desc = tibble::tribble(
	~ pua,	~ desc,	
	'',	'木',	
	'',	'虫',	
	'',	'鱼',	
	'',	'革',	
	'',	'土',	
	'',	'禾',	
	'',	'鸟',	
	'',	'马',	
	'',	'口',	
	'',	'火',	
	'',	'足',	
	'',	'月',	
	'',	'阝',	
	'',	'牛',	
	'',	'女',	
	'',	'酉',	
	'',	'车',	
	'',	'目',	
	'',	'王',	
	'',	'山',	
	'',	'田',	
	'',	'𥫗',	
	'',	'雨',	
	'Ё',	'沍',	
	'あ',	'巃',	
	'ガ',	'酇',	
	'し',	'趫',	
	'ゼ',	'摛',	
	'ヌ',	'陁',	
	'ぽ',	'頫',	
	'も',	'騂',	
	'れ',	'嶓',	
	'ㄜ',	'洿',	
	'',	'甝',	
	'',	'㪺',	
	'',	'蓻',	
	'',	'薆',	
	'',	'窌',	
	'',	'䴥',	
	'',	'舋',	
	'',	'壝',	
	'',	'蚡',	
	'',	'湣',	
	'',	'跖',	
	'攵',	'斁',	
	'',	'虖',	
	'',	'昺',	
	'',	'棐',	
	'',	'阯',	
	'',	'禘',	
	'',	'祫',	
	'',	'慺',	
	'',	'覈',	
	'',	'刲',	
	'',	'脩',	
	'',	'鄠',	
	'',	'惓',	
	'',	'搢',	
	'',	'菑',	
	'',	'奭',	
	'',	'峣',	
	'',	'餕',	
	'',	'屃',	
	'',	'縕',	
	'',	'祲',	
	'',	'檮',	
	'',	'赑',	
	'',	'畤',	
	'',	'罍',	
	'',	'簠',	
	'',	'豨',	
	'',	'蹐',	
	'',	'礲',	
	'',	'乂',	
	'',	'濛',	
	'',	'弇',	
	'',	'酺',	
	'',	'偁',	
	'',	'扆',	
	'',	'珪',	
	'',	'餔',	
	'',	'磻',	
	'',	'櫺',	
	'匕',	'朼',	
	'呈',	'桯',	
	'牟',	'桙',	
	'四',	'柶',	
	'肃',	'橚',	
	'于',	'杅',	
	'',	'惇',	
	'',	'狝',	
	'',	'烝',	
	'',	'祐',	
	'氐',	'蚳',	
	'彖',	'蝝',	
	'干',	'靬',	
	'厷',	'𡉞',	
	'貢',	'𡎴',	
	'廣',	'圹',	
	'尞',	'㙩',	
	'臬',	'㙞',	
	'丕',	'坯',	
	'胥',	'壻',	
	'氏',	'秖',	
	'',	'嗛',	
	'',	'踆',	
	'霍',	'臛',	
	'斤',	'肵',	
	'鄉',	'膷',	
	'熏',	'臐',	
	'益',	'膉',	
	'隹',	'脽',	
	'',	'祇',	
	'',	'絪',	
	'',	'𤧸',	
	'',	'禋',	
	'',	'牴',	
	'',	'絜',	
	'',	'軿',	
	'',	'籥',	
	'奧',	'隩',	
	'厄',	'阨',	
	'戹',	'阸',	
	'九',	'𨸒',	
	'齐',	'隮',	
	'齊',	'隮',	
	'是',	'隄',	
	'焉',	'𨻳',	
	'',	'枌',	
	'',	'亹',	
	'',	'輶',	
	'',	'瀍',	
	'',	'跼',	
	'享',	'犉',	
	'曼',	'嫚',	
	'燕',	'嬿',	
	'雩',	'嫮',	
	'',	'轇',	
	'盾',	'輴',	
	'共',	'輁',	
	'免',	'輓',	
	'周',	'輖',	
	'蒙',	'矇',	
	'貴',	'璝',	
	'敫',	'璬',	
	'錄',	'琭',	
	'燮',	'𤫉',	
	'宣',	'瑄',	
	'',	'嵕',	
	'焦',	'嶕',	
	'卒',	'崒',	
	'',	'畼',	
	'',	'髮',	
	'',	'箠',	
	'',	'虓',	
	'',	'㝢',	
	'',	'卬',	
	'',	'瑒',	
	'艹',	'荾',	
	'艹亢',	'苀',	
	'艹尊',	'䔿',	
	'亻',	'傕',	
	'亻肥',	'俷',	
	'犭彖',	'猭',	
	'合',	'欱',	
	'纟圭',	'絓',	
	'军',	'鶤',	
	'扌',	'搉',	
	'扌',	'擭',	
	'扌',	'摎',	
	'讠少',	'訬',	
	'衤',	'袨',	
	'孚',	'䳕',	
	'',	'鵁',	
	'',	'鶄',	
	'<赤>',	'䞓',	
	'',	'幵',	
	'',	'藷',	
	'',	'紬',	
	'',	'毯',	
	'或',	'㖪',	
	'',	'驄',	
	'以',	'㕽',	
	'',	'𧔧',	
	'',	'𧐀',	
	'',	'絙',	
	'',	'羣',	
	'雨隻',	'䨥',	
	'',	'猪',	
	'',	'䂮',	
	'',	'㸌',	
	'',	'寘',	
	'',	'賸',	
	'',	'愬',	
	'阝',	'郳',	
	'',	'𠦜',	
	'',	'竈',	
	'',	'涼',	
	'',	'遲',	
	'',	'𦃈',	
	'',	'蔥',	
	'',	'雞',	
	'',	'︐（即竖排版 ，）',	
	'',	'︒（即竖排版 。）',	
	'',	'︑（即竖排版 、）',	
	'',	'︓（即竖排版 ：）',	
	'',	'︔（即竖排版 ；）',	
	'',	'︕（即竖排版 ！）',	
	'',	'︖（即竖排版 ？）',	
	'',	'︗（即竖排版 〖）',	
	'',	'︘（即竖排版 〗）',	
	'',	'︙（即竖排版 …）',	
	'',	'€',	
	'',	'〾',	
	'',	'⿰',	
	'',	'⿱',	
	'',	'⿲',	
	'',	'⿳',	
	'',	'⿴',	
	'',	'⿵',	
	'',	'⿶',	
	'',	'⿷',	
	'',	'⿸',	
	'',	'⿹',	
	'',	'⿺',	
	'',	'⿻',	
	'',	'𠂆',	
	'',	'𠂇',	
	'',	'𠂉',	
	'',	'𠃌',	
	'',	'⺄',	
	'',	'𠏈',	
	'',	'㑇',	
	'',	'㔾',	
	'',	'㖞',	
	'',	'㘚',	
	'',	'㘎',	
	'',	'⺌',	
	'',	'㣺',	
	'',	'㥮',	
	'',	'㤘',	
	'',	'龵',	
	'',	'㧏',	
	'',	'㧟',	
	'',	'㩳',	
	'',	'㧐',	
	'',	'龶',	
	'',	'龷',	
	'',	'㭎',	
	'',	'㱮',	
	'',	'㳠',	
	'',	'𠂒',	
	'',	'𡗗',	
	'',	'龸',	
	'',	'𤴔',	
	'',	'䁖',	
	'',	'䅟',	
	'',	'𥫗',	
	'',	'䌷',	
	'',	'㓁',	
	'',	'𦍌',	
	'',	'𢦏',	
	'',	'䎱',	
	'',	'䎬',	
	'',	'⺻',	
	'',	'䏝',	
	'',	'䓖',	
	'',	'䙡',	
	'',	'䙌',	
	'',	'龹',	
	'',	'䜣',	
	'',	'䜩',	
	'',	'䝼',	
	'',	'䞍',	
	'',	'𧾷',	
	'',	'䥇',	
	'',	'䥺',	
	'',	'䥽',	
	'',	'䦂',	
	'',	'䦃',	
	'',	'䦅',	
	'',	'䦆',	
	'',	'䦟',	
	'',	'䦛',	
	'',	'䦷',	
	'',	'䦶',	
	'',	'𠦝',	
	'',	'𤇾',	
	'',	'䲣',	
	'',	'䲟',	
	'',	'䲠',	
	'',	'䲡',	
	'',	'䱷',	
	'',	'䲢',	
	'',	'䴓',	
	'',	'䴔',	
	'',	'䴕',	
	'',	'䴖',	
	'',	'䴗',	
	'',	'䴘',	
	'',	'䴙',	
	'',	'䶮',	
	'',	'䜌')

pua_maybe = data.table::setDT(pua_desc)[
	j = codepoint := utf8texts.find_codepoints(pua)][
	j = maybe := desc |> stringr::str_replace_all(base::c('（.*?）' = '')) |> base::trimws('both')][
	j = .(codepoint, maybe, pua, desc)]


#| > pua_maybe 
#|           codepoint  maybe    pua   desc
#|      <codepoint_ls> <char> <char> <char>
#|   1:          58283     木           木
#|   2:          58365     虫           虫
#|   3:          58366     鱼           鱼
#|   4:          58368     革           革
#|   5:          58369     土           土
#|  ---                                    
#| 299:          59488     䴗           䴗
#| 300:          59489     䴘           䴘
#| 301:          59490     䴙           䴙
#| 302:          59491     䶮           䶮
#| 303:          59492     䜌           䜌

#| > pua_maybe[pua == '']
#|         codepoint  maybe    pua             desc
#|    <codepoint_ls> <char> <char>           <char>
#| 1:          59286     ︙       ︙（即竖排版 …）








