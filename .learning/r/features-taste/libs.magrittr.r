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
