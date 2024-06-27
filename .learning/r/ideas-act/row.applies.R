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
