

# zoo::as.Date

#: -------------------- year diff ----------------------

#: simple: date_bg |> clock::date_count_between(date_ed, 'year')

x = data.table::data.table(a = zoo::as.Date(c('2023-05-01', '2023-06-01', '2024-05-01', '2025-05-01'))) |> print()
#|             a
#|        <Date>
#| 1: 2023-05-01
#| 2: 2023-06-01
#| 3: 2024-05-01
#| 4: 2025-05-01

x[, b := '2018-05-01' |> clock::date_count_between(a, 'year')] |> print()
#|             a     b
#|        <Date> <num>
#| 1: 2023-05-01     5
#| 2: 2023-06-01     5
#| 3: 2024-05-01     6
#| 4: 2025-05-01     7

x[, c := '2016-05-01' |> clock::date_count_between(a, 'year')] |> print()
#|             a     b     c
#|        <Date> <num> <num>
#| 1: 2023-05-01     5     7
#| 2: 2023-06-01     5     7
#| 3: 2024-05-01     6     8
#| 4: 2025-05-01     7     9


#: -------------------- add year ----------------------

add_yr = \ (date, yr) date |> 
	lubridate::'%m+%'(lubridate::period(month = yr * 12))

zoo::as.Date('2024-02-29') #> [1] "2024-02-29"
zoo::as.Date('2024-02-29') |> add_yr(2) #> [1] "2026-02-28"
zoo::as.Date('2024-02-29') |> add_yr(4) #> [1] "2028-02-29"
zoo::as.Date('2024-02-29') |> add_yr(-2) #> [1] "2022-02-28"
zoo::as.Date('2024-02-29') |> add_yr(-4) #> [1] "2020-02-29"
zoo::as.Date('2024-02-29') |> add_yr(-2.5) #> [1] "2021-08-29"
zoo::as.Date('2024-02-29') |> add_yr(-4.5) #> [1] "2019-08-29"

#: Usage: policy year

dt <- data.table::data.table(polyr = c(0,2,3,5,6,8,10))
dt[, polyr_diff := c(diff(polyr), 1)]

dt
#|    polyr polyr_diff
#|    <num>      <num>
#| 1:     0          2
#| 2:     2          1
#| 3:     3          2
#| 4:     5          1
#| 5:     6          2
#| 6:     8          2
#| 7:    10          1

dt[, pol_iss_date := zoo::as.Date('2018-09-01')]
dt[, start_date := (pol_iss_date + 1) |> add_yr(polyr)]
dt[, end_date := (start_date - 1) |> add_yr(polyr_diff)]
dt
#|    polyr polyr_diff pol_iss_date start_date   end_date
#|    <num>      <num>       <Date>     <Date>     <Date>
#| 1:     0          2   2018-09-01 2018-09-02 2020-09-01
#| 2:     2          1   2018-09-01 2020-09-02 2021-09-01
#| 3:     3          2   2018-09-01 2021-09-02 2023-09-01
#| 4:     5          1   2018-09-01 2023-09-02 2024-09-01
#| 5:     6          2   2018-09-01 2024-09-02 2026-09-01
#| 6:     8          2   2018-09-01 2026-09-02 2028-09-01
#| 7:    10          1   2018-09-01 2028-09-02 2029-09-01


#: -------------------- mon diff ----------------------

dt = data.table::data.table(date_1 = base::c('2021-03-01','2021-05-01') |> zoo::as.Date(), date_0 = zoo::as.Date('2020-11-12')) |> print()
#|        date_1     date_0
#|        <Date>     <Date>
#| 1: 2021-03-01 2020-11-12
#| 2: 2021-05-01 2020-11-12

dt[, date.mon_diff := 12 * (zoo::as.yearmon(date_1) - zoo::as.yearmon(date_0))] |> print()
#|        date_1     date_0 date.mon_diff
#|        <Date>     <Date>         <num>
#| 1: 2021-03-01 2020-11-12             4
#| 2: 2021-05-01 2020-11-12             6

dt[, earlier_mons := date_0 |> purrr::map2(
	date.mon_diff, 
	~ .x |> 
		add_yr((pmin(na.rm = T, 0, .y - 1):(.y - 1)) / 12) |> 
		zoo::as.yearmon())] |> print()
#|        date_1     date_0 date.mon_diff                                          earlier_mons
#|        <Date>     <Date>         <num>                                                <list>
#| 1: 2021-03-01 2020-11-12             4                   Nov 2020,Dec 2020,Jan 2021,Feb 2021
#| 2: 2021-05-01 2020-11-12             6 Nov 2020,Dec 2020,Jan 2021,Feb 2021,Mar 2021,Apr 2021

dt[, earlier_mons := date_0 |> purrr::map2(
	date.mon_diff, 
	~ .x |> 
		add_yr((pmin(na.rm = T, 0, .y - 1):(.y - 1)) / 12) |> 
		format("%Y/%m"))] |> print()
#|        date_1     date_0 date.mon_diff                                    earlier_mons
#|        <Date>     <Date>         <num>                                          <list>
#| 1: 2021-03-01 2020-11-12             4                 2020/11,2020/12,2021/01,2021/02
#| 2: 2021-05-01 2020-11-12             6 2020/11,2020/12,2021/01,2021/02,2021/03,2021/04


#: -------------------- year qtr ----------------------

demo = data.table::data.table(date = zoo::as.Date(c(
	'2020-03-10', '2021-04-01', '2022-09-01', '2025-12-31')))
date2yearqtr = function (date, format = '%Y-%q/4') zoo::as.Date(date) |> 
	zoo::as.yearqtr() |> zoo:::format.yearqtr(format)

demo
#|          date
#|        <Date>
#| 1: 2020-03-10
#| 2: 2021-04-01
#| 3: 2022-09-01
#| 4: 2025-12-31

demo[, .(date, yrqr = date |> date2yearqtr('%Y %q'))] #: 简单示例
#|          date   yrqr
#|        <Date> <char>
#| 1: 2020-03-10 2020 1
#| 2: 2021-04-01 2021 2
#| 3: 2022-09-01 2022 3
#| 4: 2025-12-31 2025 4

demo[, .(date, yrqr = date |> date2yearqtr())] #: 默认格式化效果
#|          date   yrqr
#|        <Date> <char>
#| 1: 2020-03-10 2020-1/4
#| 2: 2021-04-01 2021-2/4
#| 3: 2022-09-01 2022-3/4
#| 4: 2025-12-31 2025-4/4

demo[, .(date, yrqr = date |> date2yearqtr('qtr:%q|yr:%Y'))] #: 复杂示例
#|          date          yrqr
#|        <Date>        <char>
#| 1: 2020-03-10 qtr:1|yr:2020
#| 2: 2021-04-01 qtr:2|yr:2021
#| 3: 2022-09-01 qtr:3|yr:2022
#| 4: 2025-12-31 qtr:4|yr:2025

#: 同批次禁止使用不同的格式化模板示例
demo = data.table::data.table(
	date = zoo::as.Date(c('2020-03-10', '2021-04-01', '2022-09-01', '2025-12-31')), 
	fmt = c('%Y %q', 'qtr:%q|yr:%Y', '%Yq%q', '%Y|%q'))

demo
#|          date          fmt
#|        <Date>       <char>
#| 1: 2020-03-10        %Y %q
#| 2: 2021-04-01 qtr:%q|yr:%Y
#| 3: 2022-09-01        %Yq%q
#| 4: 2025-12-31        %Y|%q

demo[, date |> date2yearqtr(fmt)]
#>> Error in if (format == "%Y Q%q") { : the condition has length > 1




#: -------------------- e.g., Date Complete - demo with IBNR ----------------------

#'	@title IBNR Factor Table Time Fills
#'	@name ibnrfct_prefill
#'	
#'	@param ibnr_factors {data.table}, ibnr_factors from old format which has fields: `benefit_type`, `year`, `month`, `count_factor`, `amount_factor`
#'	@param beginning_till {date}, The earlist date for you, using to fill the previous months.
#'	
#'	@returns {data.table}, Dataset which has filled the time.
#'	
#'	@description
#'	Fill the IBNR Factor table till the beginning date you specified. Only supports granularity of month.
#'	
#'	@examples
#'	
#'	ibnr_factors = data.table::data.table(
#'		benefit_type = c('A','A','B'), 
#'		year = 2021, 
#'		month = 3:5, 
#'		count_factor = exp(-pi) + 1, 
#'		amount_factor = exp(-pi) * 2 + 1)
#'	
#'	#: Just format back with nothing fills
#'	ibnr_factors |> ibnrfct_prefill()
#'	#: Fill to 2020-11-12
#'	ibnr_factors |> ibnrfct_prefill('2020-11-12')
#'	
ibnrfct_prefill = function (
		ibnr_factors, 
		beginning_till = zoo::as.Date(NA)) 
{
	# error situation
	{
		# check ibnr_factors
		{
			needcol.ibnr_factors = c('benefit_type', 'year', 'month', 'count_factor', 'amount_factor')
			colnames(ibnr_factors) = colnames(ibnr_factors) |> tolower()
			if (all(needcol.ibnr_factors %in% colnames(ibnr_factors))) {
				usethis::ui_done("Fields {usethis::ui_field(needcol.ibnr_factors)} found in IBNR factors input.")
			} else {
				.m = glue::glue(
					"\\
					Missing Column - IBNR factors input MUST has fields {
					usethis::ui_field(needcol.ibnr_factors)} in it but only found [{
					usethis::ui_field(colnames(ibnr_factors))}].")
				usethis::ui_oops(.m)
				stop(.m)
			}
		}
		
		# check the beginning_till
		{
			allowclass.beginning_till = c('Date', 'character')
			if (any(class(beginning_till) %in% allowclass.beginning_till)) {
				usethis::ui_done("Class of inputed begin-date {usethis::ui_value(class(beginning_till))} is supported (which is in [{usethis::ui_value(allowclass.beginning_till)}]).")
			} else {
				.m = glue::glue(
					"\\
					Class of inputed begin-date {
					usethis::ui_value(class(beginning_till))} is NOT supported (which is not in [{
					usethis::ui_value(allowclass.beginning_till)}]).")
				usethis::ui_oops(.m)
				stop(.m)
			}
		}
	}
	
	# ready fn
	{
		add_mo = \ (date, mo) "lubridate" |> withr::with_package(date %m+% lubridate::period(month = if (length(mo) > 0) mo else as.integer(NA)))
		add_dy = \ (date, dy) "lubridate" |> withr::with_package(date %m+% lubridate::period(day = if (length(dy) > 0) dy else as.integer(NA)))
		add_yr = \ (date, year) date |> add_mo(year * 12)
		
		add_mo_posi = \ (date, mo) date |> add_mo(mo |> purrr::keep(~ .x >= 0))
		add_dy_posi = \ (date, dy) date |> add_dy(dy |> purrr::keep(~ .x >= 0))
		add_yr_posi = \ (date, year) date |> add_yr(year |> purrr::keep(~ .x >= 0))
	}
	
	# param type
	{
		data.table::setDT(ibnr_factors)
		beginning_till = zoo::as.Date(beginning_till)
	}
	
	# init dataset
	{
		ibnr_factors[, origin_date := zoo::as.Date(zoo::as.yearmon(.SD |> glue::glue_data('{year}-{month}')))]
		ibnr_factors[, time_corresponding := origin_date |> format("%Y/%m")]
		ibnr_factors[, bnf_id := benefit_type]
	}
	
	# make earlist of input dataset
	{
		benefit_earlist = ibnr_factors[, .(origin_earlist = min(na.rm = T, origin_date)), by = bnf_id]
		benefit_earlist[, beginning_till := pmin(na.rm = T, origin_earlist, beginning_till)]
	}
	
	
	# calc diff auto
	{
		benefit_earlist[, earlier_mon.diff := (zoo::as.yearmon(origin_earlist) - zoo::as.yearmon(beginning_till)) * 12]
		benefit_earlist[, earlier_mon := beginning_till |> purrr::map2(earlier_mon.diff, ~ .x |> add_mo_posi(pmin(na.rm = T, 0, .y - 1):(.y - 1)) |> format("%Y%m"))]
	}
	
	# unwarp res list
	{
		benefit_earlier = benefit_earlist[, purrr::map2(
			bnf_id, 
			earlier_mon, 
			~ tidyr::crossing(bnf_id = .x, time_corresponding = .y)) |> 
				data.table::rbindlist()][!is.na(time_corresponding)]
		
		benefit_earlier[, let(count_factor = 1, amount_factor = 1)]
	}
	
	# rbind input
	{
		ibnr_factors_full = data.table::setDT(ibnr_factors)[, .(bnf_id, time_corresponding, count_factor, amount_factor)] |> 
			list(benefit_earlier) |> 
			data.table::rbindlist() |> 
			data.table::setorder(bnf_id, time_corresponding)
	}
	
	# select fields and return
	{
		ibnr_factors_full[, .(
			benefit_type = bnf_id, 
			time_corresponding, 
			ibnr_factor.a = amount_factor, 
			ibnr_factor.c = count_factor)]
	}
}




ibnr_factors = data.table::data.table(
	benefit_type = c('A','A','B'), 
	year = 2021, 
	month = 3:5, 
	count_factor = exp(-pi) + 1, 
	amount_factor = exp(-pi) * 2 + 1) |> print()
#|	   benefit_type  year month count_factor amount_factor
#|	         <char> <num> <int>        <num>         <num>
#|	1:            A  2021     3     1.043214      1.086428
#|	2:            A  2021     4     1.043214      1.086428
#|	3:            B  2021     5     1.043214      1.086428

#: Just format back with nothing fills
ibnr_factors |> ibnrfct_prefill()
#|	✔ Fields benefit_type, year, month, count_factor, amount_factor found in IBNR factors input.
#|	✔ Class of inputed begin-date 'Date' is supported (which is in ['Date', 'character']).
#|	   benefit_type time_corresponding ibnr_factor.a ibnr_factor.c
#|	         <char>             <char>         <num>         <num>
#|	1:            A            2021/03      1.086428      1.043214
#|	2:            A            2021/04      1.086428      1.043214
#|	3:            B            2021/05      1.086428      1.043214

#: Fill to 2020-11-12
ibnr_factors |> ibnrfct_prefill('2020-11-12')
#|	✔ Fields benefit_type, year, month, count_factor, amount_factor found in IBNR factors input.
#|	✔ Class of inputed begin-date 'character' is supported (which is in ['Date', 'character']).
#|	    benefit_type time_corresponding ibnr_factor.a ibnr_factor.c
#|	          <char>             <char>         <num>         <num>
#|	 1:            A             202011      1.000000      1.000000
#|	 2:            A             202012      1.000000      1.000000
#|	 3:            A            2021/03      1.086428      1.043214
#|	 4:            A            2021/04      1.086428      1.043214
#|	 5:            A             202101      1.000000      1.000000
#|	 6:            A             202102      1.000000      1.000000
#|	 7:            B             202011      1.000000      1.000000
#|	 8:            B             202012      1.000000      1.000000
#|	 9:            B            2021/05      1.086428      1.043214
#|	10:            B             202101      1.000000      1.000000
#|	11:            B             202102      1.000000      1.000000
#|	12:            B             202103      1.000000      1.000000
#|	13:            B             202104      1.000000      1.000000

