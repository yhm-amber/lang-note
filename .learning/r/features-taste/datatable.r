
#' Define

X = data.table::setDT(tibble::tribble(
	~ a, 	~ b,    	~ c, 
	21,  	"L101", 	"2020-02-02", 
	22,  	"L102", 	"2015-02-02", 
	31,  	"L201", 	"2023-03-03", 
	32,  	"L202", 	"2024-04-04", 
	42,  	"H101", 	"2008-07-07", 
	81,  	"H201", 	"2029-12-21", 
))[, c := zoo::as.Date(c)]

#| > X
#|        a      b          c
#|    <num> <char>     <Date>
#| 1:    21   L101 2020-02-02
#| 2:    22   L102 2015-02-02
#| 3:    31   L201 2023-03-03
#| 4:    32   L202 2024-04-04
#| 5:    42   H101 2008-07-07
#| 6:    81   H201 2029-12-21

Rules = base::c(
	R0 = '2002-08-01', 
	R11 = '2020-02-29', 
	R2 = '2019-05-01', 
	R12 = '2024-05-10') |> 
	zoo::as.Date() |> 
	base::sort()

#| > Rules
#|           R0           R2          R11          R12 
#| "2002-08-01" "2019-05-01" "2020-02-29" "2024-05-10" 

#' `base::findInterval`

X[, rule_mark := c |> base::findInterval(Rules) |> magrittr::'%>%'({base::names(Rules)[.]})]

#| > X
#|        a      b          c rule_mark
#|    <num> <char>     <Date>    <char>
#| 1:    21   L101 2020-02-02        R2
#| 2:    22   L102 2015-02-02        R0
#| 3:    31   L201 2023-03-03       R11
#| 4:    32   L202 2024-04-04       R11
#| 5:    42   H101 2008-07-07        R0
#| 6:    81   H201 2029-12-21       R12

X[, rule_mark2 := {
	Rules0 = Rules |> timechange::time_add(year = -1); 
	base::names(Rules0) = base::names(Rules); 
	c |> base::findInterval(Rules0) |> magrittr::'%>%'({base::names(Rules0)[.]})}]

#| > X
#|        a      b          c rule_mark rule_mark2
#|    <num> <char>     <Date>    <char>     <char>
#| 1:    21   L101 2020-02-02        R2        R11
#| 2:    22   L102 2015-02-02        R0         R0
#| 3:    31   L201 2023-03-03       R11        R11
#| 4:    32   L202 2024-04-04       R11        R12
#| 5:    42   H101 2008-07-07        R0         R0
#| 6:    81   H201 2029-12-21       R12        R12

#' Get number from string

#| > base::c('z3456789RTDFL()A112','z3456789RTDFL()A113') |> stringi::stri_extract_all_regex("\\d+") |> purrr::map_chr(~ .x[base::length(.x)])
#| [1] "112" "113"
#| > base::c('z3456789RTDFL()A112','z3456789RTDFL()A113') |> stringi::stri_replace_all_regex("[^0-9]", "")
#| [1] "3456789112" "3456789113"

#' Specify column by value with `:=`

cols0 = base::c('a','b')
cols1 = base::c('rule_mark','rule_mark2')

X[, (glue::glue(":{cols0}:{cols1}:")) := (\ (a, b) base::paste(b, a)) |> 
	base::Map(
		a = base::mget(cols0), 
		b = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 :a:rule_mark: :b:rule_mark2:
#|    <num> <char>     <Date>    <char>     <char>        <char>         <char>
#| 1:    21   L101 2020-02-02        R2        R11         R2 21       R11 L101
#| 2:    22   L102 2015-02-02        R0         R0         R0 22        R0 L102
#| 3:    31   L201 2023-03-03       R11        R11        R11 31       R11 L201
#| 4:    32   L202 2024-04-04       R11        R12        R11 32       R12 L202
#| 5:    42   H101 2008-07-07        R0         R0         R0 42        R0 H101
#| 6:    81   H201 2029-12-21       R12        R12        R12 81       R12 H201

cols1 = base::c('rule_mark')

X[, (glue::glue(":{cols0}:{cols1}:")) := (\ (a, b) base::paste(b, a)) |> 
	base::Map(
		a = base::mget(cols0), 
		b = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 :a:rule_mark: :b:rule_mark2: :b:rule_mark:
#|    <num> <char>     <Date>    <char>     <char>        <char>         <char>        <char>
#| 1:    21   L101 2020-02-02        R2        R11         R2 21       R11 L101       R2 L101
#| 2:    22   L102 2015-02-02        R0         R0         R0 22        R0 L102       R0 L102
#| 3:    31   L201 2023-03-03       R11        R11        R11 31       R11 L201      R11 L201
#| 4:    32   L202 2024-04-04       R11        R12        R11 32       R12 L202      R11 L202
#| 5:    42   H101 2008-07-07        R0         R0         R0 42        R0 H101       R0 H101
#| 6:    81   H201 2029-12-21       R12        R12        R12 81       R12 H201      R12 H201

#' Delete end 3 cols

#| > X[, base::mget(base::names(.SD)[base::seq(base::length(.SD)) |> utils::head(-3)])]
#|        a      b          c rule_mark rule_mark2
#|    <num> <char>     <Date>    <char>     <char>
#| 1:    21   L101 2020-02-02        R2        R11
#| 2:    22   L102 2015-02-02        R0         R0
#| 3:    31   L201 2023-03-03       R11        R11
#| 4:    32   L202 2024-04-04       R11        R12
#| 5:    42   H101 2008-07-07        R0         R0
#| 6:    81   H201 2029-12-21       R12        R12

X[, (base::names(.SD)[base::seq(base::length(.SD)) |> utils::tail(3)]) := NULL]

#| > X
#|        a      b          c rule_mark rule_mark2
#|    <num> <char>     <Date>    <char>     <char>
#| 1:    21   L101 2020-02-02        R2        R11
#| 2:    22   L102 2015-02-02        R0         R0
#| 3:    31   L201 2023-03-03       R11        R11
#| 4:    32   L202 2024-04-04       R11        R12
#| 5:    42   H101 2008-07-07        R0         R0
#| 6:    81   H201 2029-12-21       R12        R12

#' Complex calculates

cols0 = base::c('a','b')
cols1 = base::c('rule_mark')

calc0 = \ (n, m) base::as.character(n) |> 
	stringi::stri_replace_all_regex('[^0-9]', '') |> 
	base::as.integer() |> 
	magrittr::'%>%'({. * 2 + 1}) |> 
	base::paste(m)

X[, (glue::glue("{{hi, {cols0} !}}")) := calc0 |> 
	base::Map(
		n = base::mget(cols0), 
		m = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 {hi, a !} {hi, b !}
#|    <num> <char>     <Date>    <char>     <char>    <char>    <char>
#| 1:    21   L101 2020-02-02        R2        R11     43 R2    203 R2
#| 2:    22   L102 2015-02-02        R0         R0     45 R0    205 R0
#| 3:    31   L201 2023-03-03       R11        R11    63 R11   403 R11
#| 4:    32   L202 2024-04-04       R11        R12    65 R11   405 R11
#| 5:    42   H101 2008-07-07        R0         R0     85 R0    203 R0
#| 6:    81   H201 2029-12-21       R12        R12   163 R12   403 R12

cols1 = base::c('rule_mark','rule_mark2')

X[, (glue::glue("{{hi, {cols0} !}}")) := calc0 |> 
	base::Map(
		n = base::mget(cols0), 
		m = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 {hi, a !} {hi, b !}
#|    <num> <char>     <Date>    <char>     <char>    <char>    <char>
#| 1:    21   L101 2020-02-02        R2        R11     43 R2   203 R11
#| 2:    22   L102 2015-02-02        R0         R0     45 R0    205 R0
#| 3:    31   L201 2023-03-03       R11        R11    63 R11   403 R11
#| 4:    32   L202 2024-04-04       R11        R12    65 R11   405 R12
#| 5:    42   H101 2008-07-07        R0         R0     85 R0    203 R0
#| 6:    81   H201 2029-12-21       R12        R12   163 R12   403 R12

#' So, at first time, rule_mark uses twice.
#' See it clear: 

cols1 = base::c('rule_mark')
new_col = glue::glue("{{hi, {cols0} and {cols1} !}}")

X[, (new_col) := calc0 |> 
	base::Map(
		n = base::mget(cols0), 
		m = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 {hi, a !} {hi, b !}
#|    <num> <char>     <Date>    <char>     <char>    <char>    <char>
#| 1:    21   L101 2020-02-02        R2        R11     43 R2   203 R11
#| 2:    22   L102 2015-02-02        R0         R0     45 R0    205 R0
#| 3:    31   L201 2023-03-03       R11        R11    63 R11   403 R11
#| 4:    32   L202 2024-04-04       R11        R12    65 R11   405 R12
#| 5:    42   H101 2008-07-07        R0         R0     85 R0    203 R0
#| 6:    81   H201 2029-12-21       R12        R12   163 R12   403 R12
#|    {hi, a and rule_mark !} {hi, b and rule_mark !}
#|                     <char>                  <char>
#| 1:                   43 R2                  203 R2
#| 2:                   45 R0                  205 R0
#| 3:                  63 R11                 403 R11
#| 4:                  65 R11                 405 R11
#| 5:                   85 R0                  203 R0
#| 6:                 163 R12                 403 R12

#| > X[, mget(names(.SD)[seq(length(.SD)) |> utils::tail(2)])]
#|    {hi, a and rule_mark !} {hi, b and rule_mark !}
#|                     <char>                  <char>
#| 1:                   43 R2                  203 R2
#| 2:                   45 R0                  205 R0
#| 3:                  63 R11                 403 R11
#| 4:                  65 R11                 405 R11
#| 5:                   85 R0                  203 R0
#| 6:                 163 R12                 403 R12

cols1 = base::c('rule_mark','rule_mark2')
new_col = glue::glue("{{hi, {cols0} and {cols1} !}}")

X[, (new_col) := calc0 |> 
	base::Map(
		n = base::mget(cols0), 
		m = base::mget(cols1))]

#| > X
#|        a      b          c rule_mark rule_mark2 {hi, a !} {hi, b !}
#|    <num> <char>     <Date>    <char>     <char>    <char>    <char>
#| 1:    21   L101 2020-02-02        R2        R11     43 R2   203 R11
#| 2:    22   L102 2015-02-02        R0         R0     45 R0    205 R0
#| 3:    31   L201 2023-03-03       R11        R11    63 R11   403 R11
#| 4:    32   L202 2024-04-04       R11        R12    65 R11   405 R12
#| 5:    42   H101 2008-07-07        R0         R0     85 R0    203 R0
#| 6:    81   H201 2029-12-21       R12        R12   163 R12   403 R12
#|    {hi, a and rule_mark !} {hi, b and rule_mark !} {hi, b and rule_mark2 !}
#|                     <char>                  <char>                   <char>
#| 1:                   43 R2                  203 R2                  203 R11
#| 2:                   45 R0                  205 R0                   205 R0
#| 3:                  63 R11                 403 R11                  403 R11
#| 4:                  65 R11                 405 R11                  405 R12
#| 5:                   85 R0                  203 R0                   203 R0
#| 6:                 163 R12                 403 R12                  403 R12
