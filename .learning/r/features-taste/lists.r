(\()
{
	funlist = list (\(x) x, \(x)\(f) f(x)) ;
	funlist [[1]] (funlist [[2]]) (7) (funlist [[1]]) ;
}) ()
(\()
{
	pair = list (head = \(x) x, tail = \(x)\(f) f(x)) ;
	pair$head (pair$tail) (7) (pair$head) ;
}) ()
(\()
{
	funcs = c (\(x) x, \(x)\(f) f(x)) ;
	funcs [[1]] (funcs [[2]]) (7) (funcs [[1]]) ;
}) ()
# [1] 7

### 👺 List 类似于别的语言的 Tuple ，或者比如 Julia 那样的有字段名的 Tuple 。在 OCaml 类似 Record 、在 TS/Java 类似 Object 。
### 👺 它的每个元素的关系并非一般约定的行的关系，而是字段的关系。其长度可以理解为字段的数量，而非记录的条数。
### 👺 因为 R 中的表是类似于列存储的。表是一个 List ，其中每个元素是每一列，每一列都是向量，从而形成一或多行。

list (\(x) x, \(x)\(f) f(x)) [[1]] |> typeof () ;
list (\(x) x, \(x)\(f) f(x)) [[2]] |> typeof () ;
c (\(x) x, \(x)\(f) f(x)) [[2]] |> typeof () ;
# [1] "closure"

### 👺 上面的例子同时揭示了，当有 "closure" 类型存在时，向量会自动变为 "list" 类型。
### 👺 下面的例子更明显。带有 "closure" 类型的 "list" 即便经过 unlist () 转换也依然还是 "list" 。

c (1,2,8) ; # [1] 1 2 8
c (1,2,T) ; # [1] 1 2 1
c (1,2,F) ; # [1] 1 2 0
c (F,T,3) ; # [1] 0 1 3

c (F,T,3,\()3) ;
c (F,T,3,\()3) |> unlist () ;

## [[1]]
## [1] FALSE
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] 3
## 
## [[4]]
## \()3
## 

c (\() 2) ;
## [[1]]
## \() 2
## 

### 👺 即便是只有一个闭包的单元素向量，也并不会是标量，而仍然会是 "list" 。

c (F,T) |> typeof () ; # [1] "logical"
c (F,T,3) |> typeof () ; # [1] "double"
c (F,T,3,\(x) x) |> typeof () ; # [1] "list"
c (\() 2)  |> typeof () ; # [1] "list"

### 👺 闭包的打印效果与它的定义代码一致，没有受到格式化的迹象。

c (\(x) x, \(x) \    (f)   f(x)) ;
## [[1]]
## \(x) x
## 
## [[2]]
## \(x) \    (f)   f(x)
## 



