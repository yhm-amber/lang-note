library(magrittr); 

1 %>% `-`() ; # [1] -1
> 1 %>% `-` ; # [1] -1

minus = \(x) \(y) x - y ;

1 %>% minus(2) ; # 2> Error in x(., 2) : unused argument (2)
1 %>% minus(2)() ; # [1] 1

1 %>% minus()(2) ; # 2> Error in x()(., 2) : unused argument (2)
1 %>% minus(.)(2) ; # 2> Error in x(.)(., 2) : unused argument (2)

(1 %>% minus(.))(2) ; # [1] -1
(1 %>% minus)(2) ; # [1] -1
magrittr::`%>%`(1,x)(2) ; # [1] -1

### 👺 magrittr 的 %>% 只认右边对象语法中的最后一个写着的括号。
### 👺 一个括号都没有的时候，才会自动补一个 (.) 。


### 👺 与 4.1.0 后新增的 Native 管道对比

"aa" %>% paste ("bb") ; # [1] "aa bb"
"aa" |> paste ("bb") ; # [1] "aa bb"
"aa" %>% paste (.,"bb",.) ; # [1] "aa bb aa"
"aa" |> paste (_,"bb",_) ;
## 2> 
## Error in paste("_", "bb", "_") : 
##   pipe placeholder can only be used as a named argument (<input>:1:9)

"aa" %>% paste (...=.,"bb",...=.) ; # [1] "aa bb aa"
"aa" |> paste (...=_,"bb",...=_) ;
## 2> 
## Error in paste(... = "_", "bb", ... = "_") : 
##   pipe placeholder may only appear once (<input>:1:9)

"aa" %>% paste ("bb",...=.) ; # [1] "bb aa"
"aa" |> paste ("bb",...=_) ; # [1] "bb aa"

### 👺 magrittr 管道提供的语法更灵活，写法也更多。
### 👺 Native 管道提供的语法不那么灵活、限制较多（这有时是好事有时不利于简洁代码）。
### 👺 Native 管道是直接被解释为 lhs 位于 rhs 最后一个括号的第一个参数，完全零性能影响。
### 👺 magrittr 管道是用函数在第三方库实现的，当然虽不是零代价抽象但代价也没多少。
### 👺 magrittr 管道身上最大的代价其实是需要引入第三方库， Native 管道因而在避免引入库的场景下会更加优雅。
### 👺 但由于历史原因， Native 管道是在新版本才能用的，且 magrittr 管道极为成熟，因而后者反而会在另一些受限场景胜出。

### 👺 总之，两者区别不是太大：
### 👺 - 一个灵活一个刻板，各有各的好处。
### 👺 - 一个是库一个要新版，各有各的优势场景。
### 👺 可根据需要使用。比如：
### 👺 - 无版本必须多旧的限制、且要尽量少依赖地制作自己的库，用 Native 管道。
### 👺 - 更青睐与刻板带来的严谨性，用 Native 管道。
### 👺 - 介意 %>% 这种写法过于容易被覆盖因而不够严谨，用 Native 管道（ |> 没那么容易被覆盖，但 %>% 可以被定义为中坠函数而达到覆盖效果。可以赋值 `%>%` 为 NA 来恢复第三方库该管道的功能）。
### 👺 - 更愿意让代码不具备语言特色、乐于与其他语言（ OCaml, Elixir, ... ）的约定习惯保持一致，用 Native 管道。
### 👺 - 不介意引入第三方库、青睐灵活的语法、希望可以有简洁美观的代码、或者更喜欢简洁明确的错误提示，用 magrittr 管道（有整个系列哦）。

