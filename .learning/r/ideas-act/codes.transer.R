codes.call.ast = 
\ (callings) callings |> 
	as.list () |> 
	lapply (\ (x) 
		if (is.call(x)) codes.call.ast (x) else x) ;

### 🦕 转换被引用代码为列表格式的 AST
### 🦕 把 "call" class 变为 "list" class 的 AST （抽象语法树）。
### 🐢 这个定义一样的： codes.call.ast <- \ (callings) purrr::map_if(as.list(callings), is.call, codes.call.ast) ;


codes.ast.call = 
\ (ast) ast |> 
	lapply (\ (xs) 
		if (list.have.nest (xs)) codes.ast.call (xs) else 
		if (is.list (xs)) as.call (xs) else xs) |> 
	as.call() ;

### 🦕 转换列表格式的 AST 为被引用代码
### 🦕 把像上面那样的 AST "list" 变回为对应的 "call" class 的数据

codes.ast.deeplapply.element = 
\ (ast, f) ast |> 
	lapply (\ (x) 
		if (is.list (x)) 
		codes.ast.deeplapply.element (x, f) else 
		f (x)) ;

### 🦕 对 AST 中所有元素按 f 转换
### 🦕 能够对 AST "list" 中所有元素遍历并做出合乎 f 变换的转换
### 🦕 （比如能把乘号替换成除号）



list.have.nest <- 
\ (lst) lst |> 
	lapply (\ (x) is.list(x)) |> 
	unlist () |> any () ;


### 🦕 子列表检测
### 🦕 判断一个 "list" 的元素里有没有 "list" class 的。
### 🐢 unlist () |> any () 这段逻辑上相当于 Reduce (\ (a, b) a || b, x = _) 。



### 🐍 test : 把乘号转为除号。
### 🦎 pre test
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.ast () |> 
	codes.ast.deeplapply.element (\ (a) if (identical(a, `*` |> quote ())) `/` |> quote () else a) |> 
	codes.ast.call () ;
# list(1, 2, 3 + 1 - 4/8, list(3/5))


### 🐊 defines by pre
codes.call.trans.element = 
\ (callings, f = \ (x) x) callings |> 
	codes.call.ast () |> 
	codes.ast.deeplapply.element (f) |> 
	codes.ast.call () ;

### 🦕 被引用代码内容转换器
### 🦕 对 "call" class 的被引用代码中所有元素按照 f 规定转换。


### 🐍 test
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.trans.element (\ (a) 
		if (identical(a, `*` |> quote ())) 
		`/` |> quote () else a) ;
# list(1, 2, 3 + 1 - 4/8, list(3/5))


### 🦕 可用于对任何元素的指定转换，通过分支表达式完成。
### 🦕 应该不能操作某个子 AST 整体，只能作用于非 "list" 的元素，即这里的 f 的自变量一定不会是 "list" 。
### 🦕 操作最末端一个子 AST 的思路，和 codes.ast.call 一样。不能用 deeplapply 。


### 🐊 defines
codes.ast.deeplapply.ast = 
\ (ast, f) ast |> lapply (\ (xs) 
	if (list.have.nest (xs)) 
	xs |> codes.ast.deeplapply.ast (f) else 
	if (is.list (xs)) 
	xs |> f () else xs) ;


### 🐍 test : 对于乘法等式把第一个参数变为 7 。
### 🦎 pre test
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.ast () |> 
	codes.ast.deeplapply.ast (\ (ast) if (ast[[1]] |> identical(`*` |> quote ())) `[[<-` (ast, 2, value = 7) else ast) |> 
	codes.ast.call () ;
# list(1, 2, 3 + 1 - 7 * 8, list(7 * 5))


### 🐊 defines by pre
codes.call.trans.ast = 
\ (callings, f = \ (a) a) callings |> 
	codes.call.ast () |> 
	codes.ast.deeplapply.ast (\ (ast) if (ast[[1]] |> identical(`*` |> quote ())) `[[<-` (ast, 2, value = 7) else ast) |> 
	codes.ast.call () ;


### 🐍 test
list (1,2,3+1-4*8,list (3*5)) |> quote() |> 
	codes.call.trans.ast (\ (ast) 
		if (ast[[1]] |> identical(`*` |> quote ())) 
		`[[<-` (ast, 2, value = 7) else ast) ;
# list(1, 2, 3 + 1 - 7 * 8, list(7 * 5))




