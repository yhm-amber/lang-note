
(\()
{
	x = 1 ;
	f = \(y) c (x=x, y=y, z=z) ;
	z = 2 ;
	f(3) |> print() ;
	x = 4 ;
	z = 5 ;
	y = 6 ;
	f(7) |> print() ;
})()
## x y z
## 1 3 2
## x y z
## 4 7 5


`names<-` (1:2, c("a", "b")) ;
(function (x, y) { attr (x, "names") <- y  ; x }) (1:2, c("a", "b")) ;
(function (x, y) { names (x) <- y  ; x }) (1:2, c("a", "b")) ;
## a b 
## 1 2 

#[v4.1.0+]
(\(x) \(y) x+y) (1) (2) ; # [1] 3

`[<-` (1:3, 2, 99) ;
(function (x) {function (y) {function (z) { x[y] <- z ; x }}}) (1:3) (2) (99) ;
# [1]  1 99  3

5 - 2 ;
`-` (5,2) ;
# [1] 3



(function () 
{
	x <- 1;
	g <- function () { print(x); x <- 2; };
	f <- function () { x <- 3; g(); };
	f(); print(x);
}) () ;
## [1] 1
## [1] 1

(function () 
{
	x <- -1;
	f <- function () 
	{ x + 100 };
	x <- 1000;
	f();
}) () ; # [1] 1100

#' 词法作用域，但绑定是绑定地址而不是值。
#' 
#' 其实也可以理解成是函数离开其定义的作用域之前，
#' 内的自由变量总是可以被随后更改。
#' 
#' 比如下面的这两个：
#' 

(\ ()
{
	f = (\(x) \(a) x + a) (1) ;
	f(2) |> print () ; # [1] 3
  	
  	x = 1000;
	f(2) |> print () ; # [1] 3
}) () ;

(\ ()
{
	f = (\(x) {f = \(a) x + a; x = 5; f}) (1) ;
	f(2) |> print () ; # [1] 7
	
	x = 1000;
	f(2) |> print () ; # [1] 7
}) () ;







(function (x, y=ifelse(x>0, TRUE, FALSE)) 
{ x <- -111; if(y) x*2 else x*10 }) (5) ; # [1] -1110

(\ (x, y = ifelse(x>0, TRUE, FALSE)) 
{ x <- -111; (if(y) x*2 else x*10) |> print()
; x <- 3; (if(y) x*2 else x*10) |> print()
; }) (5) ;
## [1] -1110
## [1] 30

### 👺 签名参数列表（形式参数）中的表达式是 Lazy 的。它更像是以另一种形式定义的函数，只有 y 被用的时候它才会被应用一下子。加上静态绑定的只是地址，所以后续修改就被体现出来了。

(function (x) 
{
	y <- numeric(length(x));
	y[x>0] <- 1; y; 
}) (-3:3) ;
(function (x) 
{
	`[<-` (numeric(length(x)), x>0, 1) ;
}) (-3:3) ;
# [1] 0 0 0 0 1 1 1







(\()
{
	div <- 
	\ (n) \ (r) \ (c) 
	ifelse (n > r, div (n - r) (r) (c + 1), c) ;
	
	div (13) (2) (0) ; # [1] 6
	#r-wasm/webr# div (103) (1) (0) ; # Error: evaluation nested too deeply: infinite recursion / options(expressions=)?
	#rstudio/rstudio# div (10003) (1) (0) ; # Error: C stack usage  7969396 is too close to the limit
}) () ;

(\()
{
	div <- 
	\ (n) \ (r) \ (c) 
	if (n > r) div (n - r) (r) (c + 1) else c ;
	
	div (103) (2) (0) ; # [1] 51
	#r-wasm/webr# div (1003) (1) (0) ; # Error: evaluation nested too deeply: infinite recursion / options(expressions=)?
	#rstudio/rstudio# div (10003) (1) (0) ; # Error: evaluation nested too deeply: infinite recursion / options(expressions=)?
}) () ;
