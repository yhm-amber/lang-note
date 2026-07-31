

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



