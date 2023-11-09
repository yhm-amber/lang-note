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




