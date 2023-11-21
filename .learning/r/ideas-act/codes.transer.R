codes.call.ast <- 
\ (callings) callings |> 
	as.list () |> 
	lapply (\ (x) 
		if (is.call(x)) codes.call.ast (x) else x) ;

### 🦕 把 "call" class 变为 "list" class 的 AST （抽象语法树）。
### 🐢 这个定义一样的： codes.call.ast <- \ (callings) purrr::map_if(as.list(callings), is.call, codes.call.ast) ;


codes.ast.call <- 
\ (ast) ast |> 
	lapply (\ (xs) 
		if (list.have.nest (xs)) codes.ast.call (xs) else 
		if (is.list (xs)) as.call (xs) else xs) |> 
	as.call() ;

### 🦕 把像上面那样的 AST "list" 变回为对应的 "call" class 的数据

codes.ast.deeplapply <- 
\ (ast, f) ast |> 
	lapply (\ (x) 
		if (is.list (x)) 
		codes.ast.deeplapply (x, f) else 
		f (x)) ;

### 🦕 能够对 AST "list" 中所有元素遍历并做出合乎 f 变换的转换
### 🦕 （比如能把乘号替换成除号）


list.have.nest = 
\ (lst) lst |> 
	lapply (\ (x) is.list(x)) |> 
	Reduce (\ (a, b) a || b, x = _) ;

### 🦕 判断一个 "list" 的元素里有没有 "list" class 的。



### 🐍 test
### 🐍 示例：把乘号转为除号。
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.ast () |> 
	codes.ast.deeplapply (\ (a) if (identical(a, `*` |> quote ())) `/` |> quote () else a) |> 
	codes.ast.call () ; # list(1, 2, 3 + 1 - 4/8, list(3/5))
### 🦎 pre test also

### 🐊 define fun by pre 🦎
codes.call.trans = 
\ (callings, f = \ (a) a) callings |> 
	codes.call.ast () |> 
	codes.ast.deeplapply (f) |> 
	codes.ast.call () ;

### 🐍 test
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.trans (\ (a) 
		if (identical(a, `*` |> quote ())) 
		`/` |> quote () else a) ; # list(1, 2, 3 + 1 - 4/8, list(3/5))
