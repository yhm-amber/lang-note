
### 👺 矩阵基本 👹

matrix (11:16, nrow=3, ncol=2) ;
##      [,1] [,2]
## [1,]   11   14
## [2,]   12   15
## [3,]   13   16

matrix (11:16, nrow=3, ncol=2) [] ;
##      [,1] [,2]
## [1,]   11   14
## [2,]   12   15
## [3,]   13   16

matrix (11:16, nrow=3, ncol=2) [3,] ; # [1] 13 16

matrix (11:16, nrow=3, ncol=2) [,2] ; # [1] 14 15 16

matrix (11:16, nrow=3, ncol=2) [c(1,3), c(1,2)] ;
##      [,1] [,2]
## [1,]   11   14
## [2,]   13   16

matrix (11:16, nrow=3, ncol=2) [c(1,3,5)] ; # [1] 11 13 15

matrix (c(1,1, 2,2, 3,2), ncol=2, byrow=TRUE) ;
##      [,1] [,2]
## [1,]    1    1
## [2,]    2    2
## [3,]    3    2


matrix (11:16, nrow=3, ncol=2) [matrix (c(1,1, 2,2, 3,2), ncol=2, byrow=TRUE)] ; # [1] 11 15 16

diag (matrix (11:16, nrow=3, ncol=2)) ; # [1] 11 15

diag (3) ;
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1

diag (1:4) ;
##      [,1] [,2] [,3] [,4]
## [1,]    1    0    0    0
## [2,]    0    2    0    0
## [3,]    0    0    3    0
## [4,]    0    0    0    4

diag (1:1) ;
##      [,1]
## [1,]    1

1:1 ; # [1] 1

c (matrix (11:16, nrow=3, ncol=2)) ; # [1] 11 12 13 14 15 16



### 👺 矩阵标头 👹

`colnames<-` (matrix(11:16, nrow=3, ncol=2), c('X', 'Y')) ;
##       X  Y
## [1,] 11 14
## [2,] 12 15
## [3,] 13 16

`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')) ;
##   [,1] [,2]
## a   11   14
## b   12   15
## c   13   16

`colnames<-` (`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')), c('X', 'Y')) ;
`rownames<-` (`colnames<-` (matrix(11:16, nrow=3, ncol=2), c('X', 'Y')), c('a', 'b', 'c')) ;

##    X  Y
## a 11 14
## b 12 15
## c 13 16

`colnames<-` (`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')), c('X', 'Y')) [1,] ;
`colnames<-` (`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')), c('X', 'Y')) ["a",] ;

##  X  Y 
## 11 14 

`colnames<-` (`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')), c('X', 'Y')) [,1] ;
`colnames<-` (`rownames<-` (matrix(11:16, nrow=3, ncol=2), c('a', 'b', 'c')), c('X', 'Y')) [,"X"] ;

##  a  b  c 
## 11 12 13 



### 👺 矩阵组成 👹

cbind(1) ;
##      [,1]
## [1,]    1

cbind(1,2) ;
##      [,1] [,2]
## [1,]    1    2

cbind(c(1,2)) ;
##      [,1]
## [1,]    1
## [2,]    2

cbind(c(1,2), c(3,4), c(5,6)) ;
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6


rbind(1) ;
##      [,1]
## [1,]    1

rbind(1,2) ;
##      [,1]
## [1,]    1
## [2,]    2

rbind(c(1,2)) ;
##      [,1] [,2]
## [1,]    1    2

rbind(c(1,2), c(3,4), c(5,6)) ;
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
## [3,]    5    6

cbind(matrix (11:16, nrow=3, ncol=2), c(1,-1,10)) ;
##      [,1] [,2] [,3]
## [1,]   11   14    1
## [2,]   12   15   -1
## [3,]   13   16   10

rbind(matrix (11:16, nrow=3, ncol=2), c(1,-1)) ;
##      [,1] [,2]
## [1,]   11   14
## [2,]   12   15
## [3,]   13   16
## [4,]    1   -1

### 👺 用 cbind 或 rbind 在矩阵后补的向量长度要分别等于矩阵的行数或列数，过长就会截断、过短会从头重复直到补齐。如果不是整数倍就会有警告。

cbind(1, c(1,-1,10)) ;
##      [,1] [,2]
## [1,]    1    1
## [2,]    1   -1
## [3,]    1   10

rbind(1, c(1,-1,10)) ;
##      [,1] [,2] [,3]
## [1,]    1    1    1
## [2,]    1   -1   10



### 👺 矩阵算数 👹

(function (A) { (A+2) + (A/2) }) (matrix (11:16, nrow=3, ncol=2)) ;
##      [,1] [,2]
## [1,] 18.5 23.0
## [2,] 20.0 24.5
## [3,] 21.5 26.0

rbind (c(1,2), c(3,4), c(5,6)) * 2 ;
rbind (c(1,2), c(3,4), c(5,6)) * c(2,2) ;
rbind (c(1,2), c(3,4), c(5,6)) * rbind (c(2,2),c(2,2),c(2,2)) ;

##      [,1] [,2]
## [1,]    2    4
## [2,]    6    8
## [3,]   10   12


rbind (c(1,2), c(3,4), c(5,6)) * c(1,8) ;
c(1,8) * rbind (c(1,2), c(3,4), c(5,6)) ;

##      [,1] [,2]
## [1,]    1   16
## [2,]   24    4
## [3,]    5   48



rbind (c(1,2), c(3,4), c(5,6)) * c(1,8,-1) ;
c(1,8,-1) * rbind (c(1,2), c(3,4), c(5,6)) ;

##      [,1] [,2]
## [1,]    1    2
## [2,]   24   32
## [3,]   -5   -6


### 👺 算数运算符 * 用于矩阵和矩阵，须具备一致的行列长度。
### 👺 算数运算符 * 用于矩阵和向量，向量长度或其倍数应等于矩阵总长度。



rbind (c(1,2), c(3,4), c(5,6)) * c(1,-1,8) ;
rbind (c(1,2), c(3,4), c(5,6)) * rbind (c(1,1), c(-1,-1), c(8,8)) ;

##      [,1] [,2]
## [1,]    1    2
## [2,]   -3   -4
## [3,]   40   48



rbind (c(1,2), c(3,4), c(5,6)) * c(1,-1) ;
rbind (c(1,2), c(3,4), c(5,6)) * rbind (c(1,-1), c(-1,1), c(1,-1)) ;
rbind (c(1,2), c(3,4), c(5,6)) * c(1,-1,1,-1,1,-1) ;
rbind (c(1,2), c(3,4), c(5,6)) * matrix (c(1,-1,1,-1,1,-1), ncol=2) ;
rbind (c(1,2), c(3,4), c(5,6)) * cbind (c(1,-1,1), c(-1,1,-1)) ;

##      [,1] [,2]
## [1,]    1   -2
## [2,]   -3    4
## [3,]    5   -6


### 👺 算数运算符 * 用于矩阵和向量，向量会。若矩阵总长度为向量长度倍数，向量会先扩充自身长度到与矩阵总长一致，然后以优先全列填充的顺序（这是默认）转为行列数与矩阵一致的矩阵，然后进行矩阵之间的数乘运算。


rbind (c(1,2), c(3,4), c(5,6), c(7,8)) * c(1,-1,8) ;
##      [,1] [,2]
## [1,]    1   -2
## [2,]   -3   32
## [3,]   40    6
## [4,]    7   -8
## Warning message:
## In rbind(c(1, 2), c(3, 4), c(5, 6), c(7, 8)) * c(1, -1, 8) :
##   longer object length is not a multiple of shorter object length

rbind (c(1,2), c(3,4), c(5,6), c(7,8)) * c(1,-1,8,1,-1,8,1,-1) ;
rbind (c(1,2), c(3,4), c(5,6), c(7,8)) * rbind (c(1,-1), c(-1,8), c(8,1), c(1,-1)) ;

##      [,1] [,2]
## [1,]    1   -2
## [2,]   -3   32
## [3,]   40    6
## [4,]    7   -8


### 👺 如果向量长度或其倍数不等于矩阵总大小，扩充会造成多余部分。这会导致警告。扩充到总大小然后按照前述规则计算，扩充后多余部分会被丢弃。
### 👹 如果向量长度大于矩阵总大小则报错。



### 👺 矩阵乘 %*% 👹

rbind(c(1,2), c(3,4), c(5,6), c(7,8)) %*% cbind(c(1,2), c(3,4), c(5,6), c(7,8), c(9,10)) ;
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    5   11   17   23   29
## [2,]   11   25   39   53   67
## [3,]   17   39   61   83  105
## [4,]   23   53   83  113  143

### 👺 对于矩阵乘 %*% ，作列须等于右行、结果行列将等于左行和右列。
### 👺 如左列右行不等，则于运算处 error 并中断。

### 👹 此处左 2 列、右 2 行，可矩阵乘。
### 👹 此处左 4 行、右 5 列，结果行列即为 4 行 5 列。

### cbind(c(1,2), c(3,4), c(5,6), c(7,8), c(9,10)) %*% rbind(c(1,2), c(3,4), c(5,6), c(7,8)) ;
### 👹 矩阵乘没有交换律。上面的代码会出错并中断进程。


1:2 ; # [1] 1 2

cbind (1:2) ;
rbind (1, 2) ;

##      [,1]
## [1,]    1
## [2,]    2

rbind (1:2) ;
cbind (1, 2) ;

##      [,1] [,2]
## [1,]    1    2

### 👺 当矩阵乘中有向量时，向量等价于怎样的矩阵取决于向量在矩阵乘左边还是右边。

1:2 %*% cbind(c(1,2), c(3,4), c(5,6)) ;
rbind (1:2) %*% cbind(c(1,2), c(3,4), c(5,6)) ;
cbind (1,2) %*% cbind(c(1,2), c(3,4), c(5,6)) ;

##      [,1] [,2] [,3]
## [1,]    5   11   17

### 👺 当向量在矩阵乘左边，它相当于 1 行 n 列的矩阵， n 为向量长度。
### 👹 左列 2 右行 2 可矩阵乘。左行 1 右列 3 故结果为 1 行 3 列。

rbind(c(1,2), c(3,4), c(5,6)) %*% 1:2 ;
rbind(c(1,2), c(3,4), c(5,6)) %*% cbind(1:2) ;
rbind(c(1,2), c(3,4), c(5,6)) %*% rbind(1,2) ;

##      [,1]
## [1,]    5
## [2,]   11
## [3,]   17

### 👺 当向量在矩阵乘右边，它相当于 1 列 n 行的矩阵， n 为向量长度。
### 👹 左列 2 右行 2 可矩阵乘。左行 3 右列 1 故结果为 3 行 1 列。

# cbind(c(1,2), c(3,4), c(5,6)) %*% 1:2 ;
### 👹 左列 3 右行 2 故不可矩阵乘。
# 1:2 %*% rbind(c(1,2), c(3,4), c(5,6)) ;
### 👹 左列 2 右行 3 故不可矩阵乘。
