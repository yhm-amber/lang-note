
#' 这个结构和 Elixir 的 quote 类似。表达式算是延迟执行的对象。

expression (1 + 1) ;
expression (1   +   1) ;
expression (1+1) ;
# expression(1 + 1)

expression (1 + 1) |> eval () ; # [1] 2

#' 表达式也能从字符串取得

"1+1" |> parse (text = _) ; # expression(1+1)
"1 + 1" |> parse (text = _) ; # expression(1 + 1)
"1   +   1" |> parse (text = _) ; # expression(1   +   1)

"1+1" |> parse (text = _) |> eval () ;
"1 + 1" |> parse (text = _) |> eval () ;
"1   +   1" |> parse (text = _) |> eval () ;
# [1] 2

#' 函数对象也可以这样被解析出来
#' 即函数定义语句本身也可以算是表达式
#' （可以，这很 Elixir 。）

(expression (\ (x) x) |> eval ()) (0)
(expression (\ (x) x) |> eval (expr = _)) (0)
(parse (text = "\\ (x) x") |> eval ()) (0)
# [1] 0

#' 所以只要能取得字符串就可以这样解析。

(data.frame (fs = c("\\(x) x", "\\(x) \\(y) x + y"))$fs [1] |> parse(text = _) |> eval ()) (1)
(data.frame (fs = c("\\(x) x", "\\(x) \\(y) x + y"))$fs [2] |> parse(text = _) |> eval ()) (1) (0)
# [1] 1


#' 这样可以取得字面量的代码（有格式化的效果）
#' 来自: https://dbplyr.tidyverse.org/reference/copy_to.src_sql.html
#' 

base::deparse(base::substitute(base::c (xxxx+1,''+y,zzz))) # [1] "base::c(xxxx + 1, \"\" + y, zzz)"

