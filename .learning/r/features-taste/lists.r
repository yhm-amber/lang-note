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

### 👺 当然，由于 R 中， "data.frame" 的行是用向量而不是列表实现的。
### 👺 因而，这儿的表中的一格，也就不能够是列表、向量、表，也不能是闭包了。





list(11,22,33)[2] |> identical (list(22)) ; # [1] TRUE
list(11,22,33)[[2]] |> identical (22) ; # [1] TRUE

list(aa=11,bb=22,cc=33)[[2]] |> identical (22) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[["bb"]] |> identical (22) ; # [1] TRUE
list(aa=11,bb=22,cc=33)$bb |> identical (22) ; # [1] TRUE

list(aa=11,bb=22,cc=33)[2] |> identical (list(bb = 22)) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[2] |> identical (list(aa = 22)) ; # [1] FALSE

### 👺 一个 "list" class 的值，即一个列表，用单层中括号，即取得其相应子列表。

list(aa=11,bb=22,cc=33)[3:2] |> identical (list(cc=33,bb=22)) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[2:3] |> identical (list(bb=22,cc=33)) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[c(T,F,T)] |> identical (list(aa=11,cc=33)) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[c(3,1,2)] |> identical (list(cc=33,aa=11,bb=22)) ; # [1] TRUE
list(aa=11,bb=22,cc=33)[c("bb","cc","aa")] |> identical (list(bb=22,cc=33,aa=11)) ; # [1] TRUE

### 👺 根据单层中括号中的限定：
### 👺 	若只能选中一个元素，则取得的子列表就只有一个元素。比如 list(11,22,33)[2] 这样所得结果就相当于 list(22) 。
### 👺 	若能够选中多个元素，则取得的子列表里就有这多个元素。比如 list(11,22,33)[c(2,3)] 这样所得结果就相当于 list(22,33) 。

### 👺 对于有键名的 "list" 元素和更多的选中语法可见上面的例子。
### 👺 不同于映射类型，键值列表的数据结构中的元素顺序是作为有意义的要素被解析的，因而也允许键的重复。

list(cc=33,bb=22) |> identical (list(bb=22,cc=33)) ; # [1] FALSE
list(cc=33,bb=22) |> identical (list(33,22)) ; # [1] FALSE

### 👺 键值对内容完全相同的列表，顺序不同，也要被视为内容不同。
### 👺 即便顺序相同，只是键层面有区别的列表内容也要被视为不同。
