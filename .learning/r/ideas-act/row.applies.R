row.apply = 
	function (fun) 
	function (...) 
(\ (l) 
(\ (n) 
(\ (n) 
(\ (r) 
	list () |> 
		
		#' formats
		#' 
		Reduce (
			x = l,
			f = \ (a,b) base::c (a, list({length(b) <- r; b})),
			init = _) |> 
		base::'names<-'(
			x = _,
			value = n) |>
		
		lapply(as.list) |> 
		
		#' pivots
		#' 
		#' also: 
		#' 
		#'   Reduce (
		#'     x = _,
		#'     f = \ (a,b) seq(r) |> 
		#'       lapply (\ (rownum) base::c (a[[rownum]], list(b[rownum]))) ) |> 
		#' 
		#' but the using codes are clear.
		#' 
		Reduce (
			x = _,
			init = list (),
			f = \ (a,b) seq(r) |> 
				lapply (\ (rownum) {length(a) <- r; base::c (a[[rownum]], list(b[[rownum]]))}) ) |> 
		lapply (\ (l) base::'names<-'(x = l, value = n)) |> 
		base::'names<-'(x = _, value = seq(r)) |> 
		
		#' applies
		#' 
		lapply (\ (params) do.call (fun, params) ) |>
		
		base::identity()
	
) (length(l[[1]]))
) (if (is.null(n)) rep("",length(l)) else n)
) (names(l))
) (list (...))


row.apply (min) (a = 1:4, b = 3:5, c = 2:5) |> unlist ()
#| 1  2  3  4 
#| 1  2  3 NA 

row.apply (\ (...) list(...)) (a = 1:4, b = c("a","b"), c = 2:5)
#| (shows the params)

row.apply (paste) (a = 1:4, b = c("a","b"), c = 2:5) |> unlist ()
#|       1        2        3        4 
#| "1 a 2"  "2 b 3" "3 NA 4" "4 NA 5" 

row.apply (sum) (list(1:4, c(NA,1), c(NA,2)), na.rm = c(F,F,T)) |> unlist ()
#| 1  2  3 
#|10 NA  2 



#' simpler ver'
#' 

simple_transpose = function (
		df, 
		.rownames_maker = 
			\ (.data) tibble::rownames_to_column(
				var = ".rowname",
				.data = .data),
		.keep_colname = F) tibble::as_tibble(df) |> 
	.rownames_maker() |> 
	tidyr::pivot_longer(
		cols = - .rowname,
		names_to = ".colname",
		values_to = ".value") |> 
	tidyr::pivot_wider(
		names_from = .rowname,
		values_from = .value) |> 
	dplyr::select(- tidyselect::all_of(
		if (.keep_colname) NULL else '.colname')) |> 
	base::identity()

# tibble::tibble(1:4,2:5) |> simple_transpose()
# # # A tibble: 2 × 4
# #     `1`   `2`   `3`   `4`
# #   <int> <int> <int> <int>
# # 1     1     2     3     4
# # 2     2     3     4     5

# tibble::tibble (1:4,4:1) |> 
#   simple_transpose(.keep_colname = T) |> 
#   simple_transpose(\ (.d) dplyr::rename(.d, .rowname = .colname))
# # # A tibble: 4 × 2
# #   `1:4` `4:1`
# #   <int> <int>
# # 1     1     4
# # 2     2     3
# # 3     3     2
# # 4     4     1

simple_rowfunc = function (func) function (...) tibble::tibble(...) |> 
	simple_transpose() |> 
	base::lapply(func) |> 
	simple_transpose() |> 
	base::identity()

# simple_rowfunc (identity) (1:4, 4:1)
# # # A tibble: 4 × 2
# #     `1`   `2`
# #   <int> <int>
# # 1     1     4
# # 2     2     3
# # 3     3     2
# # 4     4     1
# 
# simple_rowfunc (min) (1:4, 4:1)
# # # A tibble: 4 × 1
# #     `1`
# #   <int>
# # 1     1
# # 2     2
# # 3     2
# # 4     1
# 
# simple_rowfunc (sum) (1:4, 4:1)
# # # A tibble: 4 × 1
# #     `1`
# #   <int>
# # 1     5
# # 2     5
# # 3     5
# # 4     5

simple_rowsumm = function (func) function (...) simple_rowfunc (func) (...) |> 
	unlist(recursive = T, use.names = F)

# simple_rowsumm (min) (1:4, 4:1)
# # [1] 1 2 2 1

# base::pmin (1:4, 4:1)
# # [1] 1 2 2 1

