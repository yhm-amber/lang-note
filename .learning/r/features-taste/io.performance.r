{
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		lapply (
			\ (name) datasets::volcano |> 
				saveRDS(".../path/to/a/" |> paste0(name))
			) -> volcano.save.a.n4096
		) -> volcano.save.a.t4096
	
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		lapply (
			\ (name) readRDS(".../path/to/a/" |> paste0(name))
			) -> volcano.read.a.n4096
		) -> volcano.read.a.t4096
}

{
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		lapply (
			\ (name) datasets::volcano |> 
				saveRDS(".../path/to/b/" |> paste0(name))
			) -> volcano.save.b.n4096
		) -> volcano.save.b.t4096
	
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		lapply (
			\ (name) readRDS(".../path/to/b/" |> paste0(name))
			) -> volcano.read.b.n4096
		) -> volcano.read.b.t4096
}

volcano.t4096 = list (
	save = list (a = volcano.save.a.t4096, b = volcano.save.b.t4096), 
	read = list (a = volcano.read.a.t4096, b = volcano.read.b.t4096))

## > volcano.t4096
## $save
## $save$a
##    user  system elapsed 
##   5.679   0.350  64.785 
## 
## $save$b
##    user  system elapsed 
##  13.514   0.527  72.120 
## 
## 
## $read
## $read$a
##    user  system elapsed 
##   0.744   0.204  39.310 
## 
## $read$b
##    user  system elapsed 
##   0.692   0.223  35.401 
## 
## 


library (future.apply)
future::plan (future::cluster, workers = 12)

{
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		future_lapply (
			\ (name) datasets::volcano |> 
				saveRDS(".../path/to/a/" |> paste0(name))
			) -> volcano.save.a.n4096.par12
		) -> volcano.save.a.t4096.par12
	
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		future_lapply (
			\ (name) readRDS(".../path/to/a/" |> paste0(name))
			) -> volcano.read.a.n4096.par12
		) -> volcano.read.a.t4096.par12
}

{
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		future_lapply (
			\ (name) datasets::volcano |> 
				saveRDS(".../path/to/b/" |> paste0(name))
			) -> volcano.save.b.n4096.par12
		) -> volcano.save.b.t4096.par12
	
	system.time (
		(seq(4096)-1) |> 
		paste0 ("volcano",...=_,".rds") |> 
		future_lapply (
			\ (name) readRDS(".../path/to/b/" |> paste0(name))
			) -> volcano.read.b.n4096.par12
		) -> volcano.read.b.t4096.par12
}

future::plan (future::sequential)
detach ("package:future.apply", unload = T)
detach ("package:future", unload = T)

volcano.t4096.par12 = list (
	save = list (a = volcano.save.a.t4096.par12, b = volcano.save.b.t4096.par12), 
	read = list (a = volcano.read.a.t4096.par12, b = volcano.read.b.t4096.par12))

## > volcano.t4096.par12
## $save
## $save$a
##    user  system elapsed 
##   1.933   0.039  18.825 
## 
## $save$b
##    user  system elapsed 
##   2.180   0.099  18.574 
## 
## 
## $read
## $read$a
##    user  system elapsed 
##   2.849   0.167  34.802 
## 
## $read$b
##    user  system elapsed 
##   2.413   0.150  33.157 
## 
## 

