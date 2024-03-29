### 👺 可以作用于向量，但会输出为 list 。可以用 Reduce 或者 unlist 变为向量。

1:12 |> Map (\(a) a, a = _) ;
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
## 
## [[4]]
## [1] 4
## 
## [[5]]
## [1] 5
## 
## [[6]]
## [1] 6
## 
## [[7]]
## [1] 7
## 
## [[8]]
## [1] 8
## 
## [[9]]
## [1] 9
## 
## [[10]]
## [1] 10
## 
## [[11]]
## [1] 11
## 
## [[12]]
## [1] 12
## 

1:12 |> Map (\(a) a, a = _) |> Reduce (\(a,b) c(a,b), x = _) ;
1:12 |> Map (\(a) a, a = _) |> unlist() ;
# [1]  1  2  3  4  5  6  7  8  9 10 11 12



### 👺 Map 是 mapply 的封装。

mapply (rep, 1:4, 4:1) ;
mapply (rep, x = 1:4, times = 4:1) ;

## [[1]]
## [1] 1 1 1 1
## 
## [[2]]
## [1] 2 2 2
## 
## [[3]]
## [1] 3 3
## 
## [[4]]
## [1] 4
## 

mapply (rep, times = 1:4, x = 4:1) ;
mapply ({\(a,b) rep(b,a)}, 1:4, 4:1) ;
mapply ({\(a,b) rep(b,a)}, a = 1:4, b = 4:1) ;

## [[1]]
## [1] 4
## 
## [[2]]
## [1] 3 3
## 
## [[3]]
## [1] 2 2 2
## 
## [[4]]
## [1] 1 1 1 1
## 

mapply(rep, times = 1:4, MoreArgs = list(x = 5)) ;
## [[1]]
## [1] 5
## 
## [[2]]
## [1] 5 5
## 
## [[3]]
## [1] 5 5 5
## 
## [[4]]
## [1] 5 5 5 5
## 

mapply(rep, x = 1:4, MoreArgs = list(times = 5)) ;
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    1    2    3    4
## [3,]    1    2    3    4
## [4,]    1    2    3    4
## [5,]    1    2    3    4

### 👺 在说明文档的它的 `...` 部分可以用具名参数，参数名取决于前面的闭包的参数名。

mtcars |> Map (\(xx) c(xx), xx = _) ;

### 👺 这样会把一个 n 行表格变为一个 List ，列表的键就是原本的字段名即 $foo $bar 这样的东西会在原本 [[1]] [[2]] ... 的位置，每个元素为长度为 n 的向量。


min <- \(xs) Reduce (\(x,y) if (x<y) x else y, xs) ;

list (1,2,4,3,6,5) |> min()
Reduce (\(x,y) if (x<y) x else y, list (1,2,4,3,6,5)) ;
list (1,2,4,3,6,5) |> Reduce (\(x,y) if (x<y) x else y, x = _) ;
list (1,2,4,3,6,5) |> Reduce (\(a,b) if (a<b) a else b, x = _) ;
# [1] 1

### 👺 reduce 的 xs 位就是叫 x 。


flatt <- \(xss,flatf = c) xss |> Reduce (\(a,b) flatf (a,b) , x = _) ;
list (list (1,0,3),list (2,4),list (3,6,5)) |> flatt(c)
list (list (1,0,3),list (2,4),list (3,6,5)) |> flatt(rbind)
list (list (1,0,3),list (2,4),list (3,6,5)) |> flatt(cbind)

### 👺 如果要摆平的是 List ，需要用的函数就是 c 即连接函数了。
### 👺 因为 c (list (1,2,3), list (4,5)) 就相当于 list (1,2,3,4,5) 。



(\()
	c ("aaa#1.rds"
		, "aaa#2.rds"
		, "aaa#3.rds"
		, "bbb#1.rds"
		, "bbb#2.rds"
		, "ccc#1.rds") -> src ;
	
	src |> lapply (\(per) per |> strsplit("[#]")) |> lapply (\(a) a[[1]][1]) |> unlist() ;
	src |> strsplit("[#]") |> lapply (\(a) a[1]) |> unlist() ;
	# [1] "aaa" "aaa" "aaa" "bbb" "bbb" "ccc"
) ()

### 👺 向量直接向量运算即可。

