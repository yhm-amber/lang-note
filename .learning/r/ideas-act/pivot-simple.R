#: -------------------- e.g., pivot - col values take ----------------------

colvalues_take.native = function (
		data, 
		amt_colname = "amt", 
		amtyr_colname = "amtyr", 
		length = NULL, 
		num_regex = "\\d*\\.?\\d+") 
{
    # 取出数据中的金额列和年列
    {
        amt_colnames = colnames(data) |> stringr::str_subset(glue::glue("^{amt_colname}{num_regex}$"))
        amtyr_colnames = colnames(data) |> stringr::str_subset(glue::glue("^{amtyr_colname}{num_regex}$"))
        
        amt_seqx = amt_colnames |> stringr::str_match(glue::glue("^{amt_colname}({num_regex})$"))
        amtyr_seqx = amtyr_colnames |> stringr::str_match(glue::glue("^{amtyr_colname}({num_regex})$"))
    }
    
    # 比较两序号是否一致
    {
        amt_seq = as.numeric(amt_seqx[,2])
        amtyr_seq = as.numeric(amtyr_seqx[,2])
        
        if (!sort(amt_seq) |> identical(sort(amtyr_seq))) {
            rlang::abort(glue::glue("amt_seq ({usethis::value(amt_seq)}) not equal with amtyr_seq ({usethis::value(amtyr_seq)})"))
        }
        
        names(amt_seq) = amt_seqx[,1]
        names(amtyr_seq) = amtyr_seqx[,1]
        
        amt_seq = sort(amt_seq)
        amtyr_seq = sort(amtyr_seq)
    }
    
    # 列转行
    {
        res = data |> melt(
            id.vars = colnames(data) |> setdiff(names(amt_seq)) |> setdiff(names(amtyr_seq)), 
            measure.vars = list(amt = names(amt_seq), amtyr = names(amtyr_seq)), 
            variable.name = "seq")
    }
    
    res
}

#: same like
colvalues_take.simple = function (dt) 
{
    dtplyr::lazy_dt(dt) |> 
        tidyr::pivot_longer(
            cols = matches("^(amt|amtyr)\\d+$"),
            names_to = c(".value", "seq"),
            names_pattern = "^(amt(?:yr)?)(\\d+)$") |> 
        data.table::as.data.table()
}

#: additionally better

#'	@title Columnism Values Take
#'	@name colvalues_take
#'	@description Trans a wide-recording dataset as long-recording style.
#'	
#'	@param dt {data.table}, format as underlying.
#'	@param ... (symbol), to specify the prefixes by symbol style.
#'	@param pivot_prefixes {character}, to specify the prefixes by character way (the default setted here).
#'	@param sequence_colname {character}, to specify the colname of seq number, defuault is '.seq'.
#'	
#'	@returns {data.table}, A dataset that be transed.
#'	
#'	@examples
#'	
#'	dt <- data.table::data.table(
#'		id = 1:3,
#'		name = c("a", "b", "c"),
#'		status = c("ok", "ok", "fail"),
#'		amt.1   = c(200, 300, 400),
#'		amt.2   = c(120, 220, 320),
#'		amt.3   = c(NA, 210, NA),
#'		amtyr.1 = c(2010, 2020, 2030),
#'		amtyr.2 = c(2011, 2021, 2031),
#'		amtyr.3 = c(NA, 2022, NA),
#'		yr.1 = c(2020, 2030, 2060),
#'		yr.2 = c(2012, 2009, 2032),
#'		yr.3 = c(NA, 2019, NA),
#'		amtyr_iss.1 = c(T, F, T),
#'		amtyr_iss.2 = c(F, T, T),
#'		amtyr_iss.3 = c(NA, F, NA),
#'		prem.1 = c(909, 808, 707),
#'		prem.2 = c(901, 801, 701),
#'		prem.3 = c(NA, 806, NA))
#'	
#'	# to specify the prefixes by symbol style
#'	dt |> colvalues_take(yr, amt, amtyr, prem, amtyr_iss) |> data.table::setorder(id, name, .seq) |> print()
#'	# to specify the prefixes by character way
#'	dt |> colvalues_take(pivot_prefixes = c('amt', 'yr', 'prem', 'amtyr', 'amtyr_iss')) |> data.table::setorder(id, name, .seq) |> print()
#'	# specify nothing then default: yr, amt
#'	dt |> colvalues_take() |> data.table::setorder(id, name, .seq) |> print()
#'	
colvalues_take <- function(
		dt, 
		..., 
		pivot_prefixes = c('yr', 'amt'), 
		sequence_colname = '.seq') 
{
	# applies symbol
	{
		.pivot_prefixes = rlang::ensyms(...) |> purrr::map_chr(as.character)
		pivot_prefixes = if (length(.pivot_prefixes) > 0) .pivot_prefixes else pivot_prefixes
		usethis::ui_info("Pivot Prefixes: {usethis::ui_field(pivot_prefixes)}")
	}
	
	# specify by rgx
	prefix_regex <- pivot_prefixes |> 
		paste(collapse = '|') |> 
		paste0('^(', prefixes = _, ').(\\d+)$')
	
	# returns
	dtplyr::lazy_dt(dt) |> 
		tidyr::pivot_longer(
			cols = tidyselect::matches(prefix_regex),
			names_to = c('.value', sequence_colname),
			names_pattern = prefix_regex) |> 
		data.table::as.data.table()
}


#: demo

dt <- data.table::data.table(
	id = 1:3,
	name = c("a", "b", "c"),
	status = c("ok", "ok", "fail"),
	amt.1   = c(200, 300, 400),
	amt.2   = c(120, 220, 320),
	amt.3   = c(NA, 210, NA),
	amtyr.1 = c(2010, 2020, 2030),
	amtyr.2 = c(2011, 2021, 2031),
	amtyr.3 = c(NA, 2022, NA),
	yr.1 = c(2020, 2030, 2060),
	yr.2 = c(2012, 2009, 2032),
	yr.3 = c(NA, 2019, NA),
	amtyr_iss.1 = c(T, F, T),
	amtyr_iss.2 = c(F, T, T),
	amtyr_iss.3 = c(NA, F, NA),
	prem.1 = c(909, 808, 707),
	prem.2 = c(901, 801, 701),
	prem.3 = c(NA, 806, NA)) |> print()
#|	      id   name status amt.1 amt.2 amt.3 amtyr.1 amtyr.2 amtyr.3  yr.1  yr.2  yr.3 amtyr_iss.1 amtyr_iss.2 amtyr_iss.3 prem.1 prem.2 prem.3
#|	   <int> <char> <char> <num> <num> <num>   <num>   <num>   <num> <num> <num> <num>      <lgcl>      <lgcl>      <lgcl>  <num>  <num>  <num>
#|	1:     1      a     ok   200   120    NA    2010    2011      NA  2020  2012    NA        TRUE       FALSE          NA    909    901     NA
#|	2:     2      b     ok   300   220   210    2020    2021    2022  2030  2009  2019       FALSE        TRUE       FALSE    808    801    806
#|	3:     3      c   fail   400   320    NA    2030    2031      NA  2060  2032    NA        TRUE        TRUE          NA    707    701     NA

# to specify the prefixes by symbol style
dt |> colvalues_take(yr, amt, amtyr, prem, amtyr_iss) |> data.table::setorder(id, name, .seq) |> print()
#|	ℹ Pivot Prefixes: yr, amt, amtyr, prem, amtyr_iss
#|	      id   name status   .seq   amt amtyr    yr amtyr_iss  prem
#|	   <int> <char> <char> <char> <num> <num> <num>    <lgcl> <num>
#|	1:     1      a     ok      1   200  2010  2020      TRUE   909
#|	2:     1      a     ok      2   120  2011  2012     FALSE   901
#|	3:     1      a     ok      3    NA    NA    NA        NA    NA
#|	4:     2      b     ok      1   300  2020  2030     FALSE   808
#|	5:     2      b     ok      2   220  2021  2009      TRUE   801
#|	6:     2      b     ok      3   210  2022  2019     FALSE   806
#|	7:     3      c   fail      1   400  2030  2060      TRUE   707
#|	8:     3      c   fail      2   320  2031  2032      TRUE   701
#|	9:     3      c   fail      3    NA    NA    NA        NA    NA

# to specify the prefixes by character way
dt |> colvalues_take(pivot_prefixes = c('amt', 'yr', 'prem', 'amtyr', 'amtyr_iss')) |> data.table::setorder(id, name, .seq) |> print()
#|	ℹ Pivot Prefixes: amt, yr, prem, amtyr, amtyr_iss
#|	      id   name status   .seq   amt amtyr    yr amtyr_iss  prem
#|	   <int> <char> <char> <char> <num> <num> <num>    <lgcl> <num>
#|	1:     1      a     ok      1   200  2010  2020      TRUE   909
#|	2:     1      a     ok      2   120  2011  2012     FALSE   901
#|	3:     1      a     ok      3    NA    NA    NA        NA    NA
#|	4:     2      b     ok      1   300  2020  2030     FALSE   808
#|	5:     2      b     ok      2   220  2021  2009      TRUE   801
#|	6:     2      b     ok      3   210  2022  2019     FALSE   806
#|	7:     3      c   fail      1   400  2030  2060      TRUE   707
#|	8:     3      c   fail      2   320  2031  2032      TRUE   701
#|	9:     3      c   fail      3    NA    NA    NA        NA    NA

# specify nothing then default: yr, amt
dt |> colvalues_take() |> data.table::setorder(id, name, .seq) |> print()
#|	ℹ Pivot Prefixes: yr, amt
#|	      id   name status amtyr.1 amtyr.2 amtyr.3 amtyr_iss.1 amtyr_iss.2 amtyr_iss.3 prem.1 prem.2 prem.3   .seq   amt    yr
#|	   <int> <char> <char>   <num>   <num>   <num>      <lgcl>      <lgcl>      <lgcl>  <num>  <num>  <num> <char> <num> <num>
#|	1:     1      a     ok    2010    2011      NA        TRUE       FALSE          NA    909    901     NA      1   200  2020
#|	2:     1      a     ok    2010    2011      NA        TRUE       FALSE          NA    909    901     NA      2   120  2012
#|	3:     1      a     ok    2010    2011      NA        TRUE       FALSE          NA    909    901     NA      3    NA    NA
#|	4:     2      b     ok    2020    2021    2022       FALSE        TRUE       FALSE    808    801    806      1   300  2030
#|	5:     2      b     ok    2020    2021    2022       FALSE        TRUE       FALSE    808    801    806      2   220  2009
#|	6:     2      b     ok    2020    2021    2022       FALSE        TRUE       FALSE    808    801    806      3   210  2019
#|	7:     3      c   fail    2030    2031      NA        TRUE        TRUE          NA    707    701     NA      1   400  2060
#|	8:     3      c   fail    2030    2031      NA        TRUE        TRUE          NA    707    701     NA      2   320  2032
#|	9:     3      c   fail    2030    2031      NA        TRUE        TRUE          NA    707    701     NA      3    NA    NA

dt |> colvalues_take(yr, amt, sequence_colname = '.seq_a') |> colvalues_take(amtyr, prem, amtyr_iss, sequence_colname = '.seq_b') |> data.table::setorder(id, name, .seq_a, .seq_b) |> print()
#|	ℹ Pivot Prefixes: amtyr, prem, amtyr_iss
#|	ℹ Pivot Prefixes: yr, amt
#|	       id   name status .seq_a   amt    yr .seq_b amtyr amtyr_iss  prem
#|	    <int> <char> <char> <char> <num> <num> <char> <num>    <lgcl> <num>
#|	 1:     1      a     ok      1   200  2020      1  2010      TRUE   909
#|	 2:     1      a     ok      1   200  2020      2  2011     FALSE   901
#|	 3:     1      a     ok      1   200  2020      3    NA        NA    NA
#|	 4:     1      a     ok      2   120  2012      1  2010      TRUE   909
#|	 5:     1      a     ok      2   120  2012      2  2011     FALSE   901
#|	 6:     1      a     ok      2   120  2012      3    NA        NA    NA
#|	 7:     1      a     ok      3    NA    NA      1  2010      TRUE   909
#|	 8:     1      a     ok      3    NA    NA      2  2011     FALSE   901
#|	 9:     1      a     ok      3    NA    NA      3    NA        NA    NA
#|	10:     2      b     ok      1   300  2030      1  2020     FALSE   808
#|	11:     2      b     ok      1   300  2030      2  2021      TRUE   801
#|	12:     2      b     ok      1   300  2030      3  2022     FALSE   806
#|	13:     2      b     ok      2   220  2009      1  2020     FALSE   808
#|	14:     2      b     ok      2   220  2009      2  2021      TRUE   801
#|	15:     2      b     ok      2   220  2009      3  2022     FALSE   806
#|	16:     2      b     ok      3   210  2019      1  2020     FALSE   808
#|	17:     2      b     ok      3   210  2019      2  2021      TRUE   801
#|	18:     2      b     ok      3   210  2019      3  2022     FALSE   806
#|	19:     3      c   fail      1   400  2060      1  2030      TRUE   707
#|	20:     3      c   fail      1   400  2060      2  2031      TRUE   701
#|	21:     3      c   fail      1   400  2060      3    NA        NA    NA
#|	22:     3      c   fail      2   320  2032      1  2030      TRUE   707
#|	23:     3      c   fail      2   320  2032      2  2031      TRUE   701
#|	24:     3      c   fail      2   320  2032      3    NA        NA    NA
#|	25:     3      c   fail      3    NA    NA      1  2030      TRUE   707
#|	26:     3      c   fail      3    NA    NA      2  2031      TRUE   701
#|	27:     3      c   fail      3    NA    NA      3    NA        NA    NA
#|	       id   name status .seq_a   amt    yr .seq_b amtyr amtyr_iss  prem

#: made ×3 of 9 lines that became 27 lines.
