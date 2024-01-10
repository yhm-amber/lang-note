
(\() 
{
	library(magrittr);
	x = data.table::data.table(a = c(2,2,3,3), b = 2:5);
	
	x ;
	##    a b
	## 1: 2 2
	## 2: 2 3
	## 3: 3 4
	## 4: 3 5
	
	x %>% {.[!duplicated(.$a)]} ;
	##    a b
	## 1: 2 2
	## 2: 3 4
	x ;
	##    a b
	## 1: 2 2
	## 2: 2 3
	## 3: 3 4
	## 4: 3 5
	
	x %<>% {.[!duplicated(.$a)]};
	x ;
	##    a b
	## 1: 2 2
	## 2: 3 4
	
	#' 🏐 对于 `%<>%` 管道： `x %<>% {.[!duplicated(.$a)]}` 相当于 `x <- x %>% {.[!duplicated(.$a)]}` 即 `x <- x[!duplicated(x$a)]}`
	#' 🏐 这里的 `{.[!duplicated(.$a)]}` 是用于基于 `a` 字段对表 `x` 去重、只留下第一行。
	#' 
}) () ;
