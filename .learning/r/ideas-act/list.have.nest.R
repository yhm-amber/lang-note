# pre test
list (1,2,3) |> lapply (\ (x) is.list(x)) |> Reduce (\ (a, b) a || b, x = _) ; # [1] FALSE
list (1,2,list()) |> lapply (\ (x) is.list(x)) |> Reduce (\ (a, b) a || b, x = _) ; # [1] TRUE

# def
list.have.nest = 
\ (xs) xs |> 
	lapply (\ (x) is.list(x)) |> 
	Reduce (\ (a, b) a || b, x = _) ;

# test
list (1,2,3) |> list.have.nest () ; # [1] FALSE
list (1,2,list()) |> list.have.nest () ; # [1] TRUE
