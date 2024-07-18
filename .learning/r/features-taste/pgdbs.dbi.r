
pg_connecter = function (envvals) DBI::dbConnect(
	host = as.character(envvals['host']),
	port = as.integer(envvals['port']),
	dbname = as.character(envvals['dbname']),
	user = as.character(envvals['user']),
	password = as.character(envvals['password']),
	drv = RPostgres::Postgres())


gen_envvals = function (envnames) envnames |> 
	mapply(FUN = base::Sys.getenv) |> 
	magrittr::'%>%'(base::'class<-'("Dlist"))
gen_envprofiles = function (envnames) envnames |> 
	mapply(FUN = \ (X) paste0("export", " ", X, "=", "###")) |> 
	magrittr::'%>%'(base::'class<-'("Dlist"))
glue_envnames = function (namesmapp, .name_prefix = "WHAT_FOR_CWRW_DB_") namesmapp |> 
	mapply(FUN = \ (X) paste0(.name_prefix, X)) |> 
	magrittr::'%>%'(base::'class<-'("Dlist"))


glue_envnames(
	
	namesmapp = base::c(
		host = "HOST",
		port = "PORT",
		dbname = "DBNAME",
		user = "USER",
		password = "PASSWD"))
#| host                                 WHAT_FOR_CWRW_DB_HOST
#| port                                 WHAT_FOR_CWRW_DB_PORT
#| dbname                               WHAT_FOR_CWRW_DB_DBNAME
#| user                                 WHAT_FOR_CWRW_DB_USER
#| password                             WHAT_FOR_CWRW_DB_PASSWD

glue_envnames(
	
	namesmapp = base::c(
		host = "HOST",
		port = "PORT",
		dbname = "DBNAME",
		user = "USER",
		password = "PASSWD"), 
	
	.name_prefix = "AANAA_") -> envnames

envnames
#| host                                 AANAA_HOST
#| port                                 AANAA_PORT
#| dbname                               AANAA_DBNAME
#| user                                 AANAA_USER
#| password                             AANAA_PASSWD

gen_envprofiles(envnames)
#| host                                 export AANAA_HOST=###
#| port                                 export AANAA_PORT=###
#| dbname                               export AANAA_DBNAME=###
#| user                                 export AANAA_USER=###
#| password                             export AANAA_PASSWD=###

#' You can use this, 
#' edit to fill the settings they really are, 
#' then add them into your `~/.profile`
#' then you can see the result you just added by this: 
#' 
gen_envvals(envnames)
#|| ...

conn_pg_env = (
	
	\ (envnames) function (
		.show_content = F,
		.fun_content = if (.show_content) base::print.Dlist else base::identity,
		.fns = base::list(
			gen_envvals = gen_envvals,
			pg_connecter = pg_connecter)) envnames |> 
		magrittr::'%T>%'(print.Dlist) |> 
		.fns$gen_envvals() |> 
		magrittr::'%T>%'(.fun_content) |> 
		.fns$pg_connecter()) (glue_envnames(
			
			namesmapp = base::c(
				host = "HOST",
				port = "PORT",
				dbname = "DBNAME",
				user = "USER",
				password = "PASSWD"),
			
			.name_prefix = "WHAT_FOR_CWRW_DB_")) |> 
	
	base::identity()

#' You can try these: 
#' 
#' - `db_jobstates = conn_pg_env()`
#' - `DBI::dbDisconnect(db_jobstates)`
#' - `db_jobstates = conn_pg_env(T)`
#' - `DBI::dbDisconnect(db_jobstates)`
#' 

fbind = function (f.a, f.b) \ (...) f.b(f.a(...))



#' Data prepare
#' 

starwars = dplyr::select(seq(11), .data = dplyr::starwars)

#' Check copy
#' 

db_jobstates = conn_pg_env(T)

db_jobstates |> dplyr::copy_to(starwars, temporary = F, overwrite = F)

DBI::dbDisconnect(db_jobstates)


#' Check effects
#' 

db_jobstates = conn_pg_env()
#| host                                 WHAT_FOR_CWRW_DB_HOST
#| port                                 WHAT_FOR_CWRW_DB_PORT
#| dbname                               WHAT_FOR_CWRW_DB_DBNAME
#| user                                 WHAT_FOR_CWRW_DB_USER
#| password                             WHAT_FOR_CWRW_DB_PASSWD

db_jobstates |> dplyr::tbl(from = "starwars")
#| # Source:   table<"starwars"> [?? x 11]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|    name               height  mass hair_color    skin_color  eye_color birth_year sex    gender    homeworld species
#|    <chr>               <int> <dbl> <chr>         <chr>       <chr>          <dbl> <chr>  <chr>     <chr>     <chr>  
#|  1 Luke Skywalker        172    77 blond         fair        blue            19   male   masculine Tatooine  Human  
#|  2 C-3PO                 167    75 NA            gold        yellow         112   none   masculine Tatooine  Droid  
#|  3 R2-D2                  96    32 NA            white, blue red             33   none   masculine Naboo     Droid  
#|  4 Darth Vader           202   136 none          white       yellow          41.9 male   masculine Tatooine  Human  
#|  5 Leia Organa           150    49 brown         light       brown           19   female feminine  Alderaan  Human  
#|  6 Owen Lars             178   120 brown, grey   light       blue            52   male   masculine Tatooine  Human  
#|  7 Beru Whitesun Lars    165    75 brown         light       blue            47   female feminine  Tatooine  Human  
#|  8 R5-D4                  97    32 NA            white, red  red             NA   none   masculine Tatooine  Droid  
#|  9 Biggs Darklighter     183    84 black         light       brown           24   male   masculine Tatooine  Human  
#| 10 Obi-Wan Kenobi        182    77 auburn, white fair        blue-gray       57   male   masculine Stewjon   Human  
#| # ℹ more rows
#| # ℹ Use `print(n = ...)` to see more rows

db_jobstates |> 
	dplyr::tbl(from = "starwars") |> 
	dplyr::mutate(is_droid = species == 'Droid')
#| # Source:   SQL [?? x 12]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|    name               height  mass hair_color    skin_color  eye_color birth_year sex    gender    homeworld species is_droid
#|    <chr>               <int> <dbl> <chr>         <chr>       <chr>          <dbl> <chr>  <chr>     <chr>     <chr>   <lgl>   
#|  1 Luke Skywalker        172    77 blond         fair        blue            19   male   masculine Tatooine  Human   FALSE   
#|  2 C-3PO                 167    75 NA            gold        yellow         112   none   masculine Tatooine  Droid   TRUE    
#|  3 R2-D2                  96    32 NA            white, blue red             33   none   masculine Naboo     Droid   TRUE    
#|  4 Darth Vader           202   136 none          white       yellow          41.9 male   masculine Tatooine  Human   FALSE   
#|  5 Leia Organa           150    49 brown         light       brown           19   female feminine  Alderaan  Human   FALSE   
#|  6 Owen Lars             178   120 brown, grey   light       blue            52   male   masculine Tatooine  Human   FALSE   
#|  7 Beru Whitesun Lars    165    75 brown         light       blue            47   female feminine  Tatooine  Human   FALSE   
#|  8 R5-D4                  97    32 NA            white, red  red             NA   none   masculine Tatooine  Droid   TRUE    
#|  9 Biggs Darklighter     183    84 black         light       brown           24   male   masculine Tatooine  Human   FALSE   
#| 10 Obi-Wan Kenobi        182    77 auburn, white fair        blue-gray       57   male   masculine Stewjon   Human   FALSE   
#| # ℹ more rows
#| # ℹ Use `print(n = ...)` to see more rows

db_jobstates |> 
	dplyr::tbl(from = "starwars") |> 
	dplyr::mutate(is_droid = species == 'Droid') |> 
	
	#' `CREATE TABLE stwr2 AS SELECT ... FROM starwars ...`
	#' 
	dplyr::copy_to(
		dest = db_jobstates, 
		temporary = F, 
		overwrite = F, 
		name = "stwr2", 
		df = _)

db_jobstates |> dplyr::tbl(from = "stwr2")
#| # Source:   table<"stwr2"> [?? x 12]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|    name               height  mass hair_color    skin_color  eye_color birth_year sex    gender    homeworld species is_droid
#|    <chr>               <int> <dbl> <chr>         <chr>       <chr>          <dbl> <chr>  <chr>     <chr>     <chr>   <lgl>   
#|  1 Luke Skywalker        172    77 blond         fair        blue            19   male   masculine Tatooine  Human   FALSE   
#|  2 C-3PO                 167    75 NA            gold        yellow         112   none   masculine Tatooine  Droid   TRUE    
#|  3 R2-D2                  96    32 NA            white, blue red             33   none   masculine Naboo     Droid   TRUE    
#|  4 Darth Vader           202   136 none          white       yellow          41.9 male   masculine Tatooine  Human   FALSE   
#|  5 Leia Organa           150    49 brown         light       brown           19   female feminine  Alderaan  Human   FALSE   
#|  6 Owen Lars             178   120 brown, grey   light       blue            52   male   masculine Tatooine  Human   FALSE   
#|  7 Beru Whitesun Lars    165    75 brown         light       blue            47   female feminine  Tatooine  Human   FALSE   
#|  8 R5-D4                  97    32 NA            white, red  red             NA   none   masculine Tatooine  Droid   TRUE    
#|  9 Biggs Darklighter     183    84 black         light       brown           24   male   masculine Tatooine  Human   FALSE   
#| 10 Obi-Wan Kenobi        182    77 auburn, white fair        blue-gray       57   male   masculine Stewjon   Human   FALSE   
#| # ℹ more rows
#| # ℹ Use `print(n = ...)` to see more rows

db_jobstates |> 
	dplyr::tbl(from = "starwars") |> 
	dplyr::mutate(is_droid = species == 'Droid') |> 
	dplyr::filter(is_droid) |> 
	
	#' `CREATE TABLE stwr2 AS SELECT ... FROM (SELECT ... FROM starwars) WHERE ...`
	#' 
	dplyr::copy_to(
		dest = db_jobstates, 
		temporary = F, 
		overwrite = F, 
		name = "stwr_droids", 
		df = _)

db_jobstates |> dplyr::tbl(from = "stwr_droids")
#| # Source:   table<"stwr_droids"> [6 x 12]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|   name   height  mass hair_color skin_color  eye_color birth_year sex   gender    homeworld species is_droid
#|   <chr>   <int> <dbl> <chr>      <chr>       <chr>          <dbl> <chr> <chr>     <chr>     <chr>   <lgl>   
#| 1 C-3PO     167    75 NA         gold        yellow           112 none  masculine Tatooine  Droid   TRUE    
#| 2 R2-D2      96    32 NA         white, blue red               33 none  masculine Naboo     Droid   TRUE    
#| 3 R5-D4      97    32 NA         white, red  red               NA none  masculine Tatooine  Droid   TRUE    
#| 4 IG-88     200   140 none       metal       red               15 none  masculine NA        Droid   TRUE    
#| 5 R4-P17     96    NA none       silver, red red, blue         NA none  feminine  NA        Droid   TRUE    
#| 6 BB8        NA    NA none       none        black             NA none  masculine NA        Droid   TRUE    

DBI::dbDisconnect(db_jobstates)



#' Check did them temporary
#' 
#' And add some new
#' 

db_jobstates = conn_pg_env()
#| host                                 WHAT_FOR_CWRW_DB_HOST
#| port                                 WHAT_FOR_CWRW_DB_PORT
#| dbname                               WHAT_FOR_CWRW_DB_DBNAME
#| user                                 WHAT_FOR_CWRW_DB_USER
#| password                             WHAT_FOR_CWRW_DB_PASSWD

db_jobstates |> dplyr::tbl(from = "stwr_droids")
#| # Source:   table<"stwr_droids"> [6 x 12]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|   name   height  mass hair_color skin_color  eye_color birth_year sex   gender    homeworld species is_droid
#|   <chr>   <int> <dbl> <chr>      <chr>       <chr>          <dbl> <chr> <chr>     <chr>     <chr>   <lgl>   
#| 1 C-3PO     167    75 NA         gold        yellow           112 none  masculine Tatooine  Droid   TRUE    
#| 2 R2-D2      96    32 NA         white, blue red               33 none  masculine Naboo     Droid   TRUE    
#| 3 R5-D4      97    32 NA         white, red  red               NA none  masculine Tatooine  Droid   TRUE    
#| 4 IG-88     200   140 none       metal       red               15 none  masculine NA        Droid   TRUE    
#| 5 R4-P17     96    NA none       silver, red red, blue         NA none  feminine  NA        Droid   TRUE    
#| 6 BB8        NA    NA none       none        black             NA none  masculine NA        Droid   TRUE    

db_jobstates |> 
	dplyr::tbl(from = "starwars") |> 
	dplyr::mutate(is_droid = species == 'Droid') |> 
	dplyr::filter(sex == 'none') |> 
	
	#' `CREATE TABLE stwr2 AS SELECT ... FROM (SELECT ... FROM starwars) WHERE ...`
	#' 
	dplyr::copy_to(
		dest = db_jobstates, 
		temporary = F, 
		overwrite = F, 
		name = "stwr_sexnone", 
		df = _)

diffdf::diffdf(
	compare = db_jobstates |> dplyr::tbl(from = "stwr_sexnone") |> dplyr::collect(),
	base = db_jobstates |> dplyr::tbl(from = "stwr_droids") |> dplyr::collect())
#| No issues were found!

db_jobstates |> 
	dplyr::tbl(from = "starwars") |> 
	dplyr::mutate(is_droid = species == 'Droid') |> 
	dplyr::filter(is.na(hair_color)) |> 
	
	#' `CREATE TABLE stwr2 AS SELECT ... FROM (SELECT ... FROM starwars) WHERE ...`
	#' 
	dplyr::copy_to(
		dest = db_jobstates, 
		temporary = F, 
		overwrite = F, 
		name = "stwr_nahair", 
		df = _)

db_jobstates |> dplyr::tbl(from = "stwr_nahair")
#| # Source:   table<"stwr_nahair"> [5 x 12]
#| # Database: postgres  [chinaesinfo_dev@pgm-2ze6r3p3042giq53.pg.rds.aliyuncs.com:5432/chinaesinfo-dev]
#|   name                  height  mass hair_color skin_color       eye_color birth_year sex   gender homeworld species is_droid
#|   <chr>                  <int> <dbl> <chr>      <chr>            <chr>          <dbl> <chr> <chr>  <chr>     <chr>   <lgl>   
#| 1 C-3PO                    167    75 NA         gold             yellow           112 none  mascu… Tatooine  Droid   TRUE    
#| 2 R2-D2                     96    32 NA         white, blue      red               33 none  mascu… Naboo     Droid   TRUE    
#| 3 R5-D4                     97    32 NA         white, red       red               NA none  mascu… Tatooine  Droid   TRUE    
#| 4 Greedo                   173    74 NA         green            black             44 male  mascu… Rodia     Rodian  FALSE   
#| 5 Jabba Desilijic Tiure    175  1358 NA         green-tan, brown orange           600 herm… mascu… Nal Hutta Hutt    FALSE   

DBI::dbDisconnect(db_jobstates)

#' Test lock
#' 

db_jobstates = conn_pg_env()
#| host                                 WHAT_FOR_CWRW_DB_HOST
#| port                                 WHAT_FOR_CWRW_DB_PORT
#| dbname                               WHAT_FOR_CWRW_DB_DBNAME
#| user                                 WHAT_FOR_CWRW_DB_USER
#| password                             WHAT_FOR_CWRW_DB_PASSWD

db_jobstates |> DBI::dbExecute("BEGIN TRANSACTION")
#| [1] 0

db_jobstates |> DBI::dbExecute("LOCK TABLE stwr_droids, stwr_nahair IN ACCESS EXCLUSIVE MODE")
#|| When this statement inside a TRANSACTION, stdout: 
#|1 [1] 0
#|| When this statement is not inside a TRANSACTION, stderr:
#|2 Error: Failed to fetch row : ERROR:  LOCK TABLE can only be used in transaction blocks

#' 本 Session 中用 `ACCESS EXCLUSIVE MODE` 来 `LOCK TABLE` 后，
#' 其它 Session 下的该 `LOCK TABLE` 语句或者下述读取表活动均陷入等待，
#' 除了没有上锁的表。
#' 
#' 当执行 `END TRANSACTION` 过后，其余 Session 中处于阻塞等待状态的命令会被执行。
#' 
#' 语句 `BEGIN TRANSACTION` 不受影响。
#' 在没有拿到锁的 Session 上，表的读取进程不论是否在事务内均会被阻塞陷入等待。
#' 
#' 如果尝试中断这个等待，进程会没有响应，并在抢到锁之后再产生中断的效果。
#' 

db_jobstates |> dplyr::tbl(from = "stwr_nahair")
db_jobstates |> dplyr::tbl(from = "stwr_droids")
db_jobstates |> dplyr::tbl(from = "stwr_sexnone")

db_jobstates |> DBI::dbExecute("END TRANSACTION")
#| [1] 0





