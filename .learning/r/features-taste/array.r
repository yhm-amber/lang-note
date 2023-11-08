### 👺 数组 👹

array (2) ; # [1] 2
array (c(1,2,3)) ; # [1] 1 2 3
array (c(1,2,3) %o% c(1,-1)) ; # [1]  1  2  3 -1 -2 -3
array (t (c(1,2,3) %o% c(1,-1))) ; # [1]  1 -1  2 -2  3 -3

### 👺 数组默认只有一个维度，如果是从矩阵构建则一列一列地取出数据。

array (t (c(1,2,3) %o% c(1,-1)), dim = c(4,4)) ;
##      [,1] [,2] [,3] [,4]
## [1,]    1    3    2    1
## [2,]   -1   -3   -2   -1
## [3,]    2    1    3    2
## [4,]   -2   -1   -3   -2

array (t (c(1,2,3) %o% c(1,-1)), dim = c(3,2)) ;
##      [,1] [,2]
## [1,]    1   -2
## [2,]   -1    3
## [3,]    2   -3

### 👺 dim 属性是一个向量，它用于限制数组大小。如果是二维向量，则取得二维数组，这就是矩阵。内容会一列一列地从数据来源取元素填充。数据来源如果是矩阵则该矩阵中的元素也是一列取完然后再一列地被取出。
### 👺 第一个元素决定行长度，第二个元素决定列长度。

array (t (c(1,2,3) %o% c(1,-1)), dim = c(1,2,3,4)) ;
## , , 1, 1
## 
##      [,1] [,2]
## [1,]    1   -1
## 
## , , 2, 1
## 
##      [,1] [,2]
## [1,]    2   -2
## 
## , , 3, 1
## 
##      [,1] [,2]
## [1,]    3   -3
## 
## , , 1, 2
## 
##      [,1] [,2]
## [1,]    1   -1
## 
## , , 2, 2
## 
##      [,1] [,2]
## [1,]    2   -2
## 
## , , 3, 2
## 
##      [,1] [,2]
## [1,]    3   -3
## 
## , , 1, 3
## 
##      [,1] [,2]
## [1,]    1   -1
## 
## , , 2, 3
## 
##      [,1] [,2]
## [1,]    2   -2
## 
## , , 3, 3
## 
##      [,1] [,2]
## [1,]    3   -3
## 
## , , 1, 4
## 
##      [,1] [,2]
## [1,]    1   -1
## 
## , , 2, 4
## 
##      [,1] [,2]
## [1,]    2   -2
## 
## , , 3, 4
## 
##      [,1] [,2]
## [1,]    3   -3
## 

### 👺 第三四等等个元素决定行组序号的长度。第 3 个以及往后的数字从左往右规定组编号每一位的最大值。

array (t (c(1,2,3) %o% c(1,-1)), dim = c(1,2,1,1,1,1,1,1,1,2)) ;
## , , 1, 1, 1, 1, 1, 1, 1, 1
## 
##      [,1] [,2]
## [1,]    1   -1
## 
## , , 1, 1, 1, 1, 1, 1, 1, 2
## 
##      [,1] [,2]
## [1,]    2   -2
## 

array (t (c(1,2,3) %o% c(1,-1)), dim = c(1,2,1)) ;
## , , 1
## 
##      [,1] [,2]
## [1,]    1   -1
## 

### 👺 不论如何前两个逗号总没有数字，因为二维及以内的数组显示形式为矩阵。

array (t (c(1,2,3) %o% c(1,-1)), dim = c(1,2,0)) ;
array (1, dim = c(1,2,0)) ;

## <1 x 2 x 0 array of double>
##      [,1] [,2]
## [1,]
## 

# array (t (c(1,2,3) %o% c(1,-1)), dim = c(0,2,1)) ;
# array (t (c(1,2,3) %o% c(1,-1)), dim = c(1,0,1)) ;
### 👹 前两个维度的长度限制不能为 0 。

### 👺 只要有一个维度最大值为 0 就会导致无法填充。
### 👺 维度位置不写和写 1 效果是不完全一样的。只要写了，就会影响分组序号的位数。其含义表达的就是数组的维度有很多，即便每个维度的长度都极为有限以至于只能存一个元素。

### 👹 所有维度长度自然都不能是负数。

array (1:24, dim = c(3,2,2,3)) ;
## , , 1, 1
## 
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
## 
## , , 2, 1
## 
##      [,1] [,2]
## [1,]    7   10
## [2,]    8   11
## [3,]    9   12
## 
## , , 1, 2
## 
##      [,1] [,2]
## [1,]   13   16
## [2,]   14   17
## [3,]   15   18
## 
## , , 2, 2
## 
##      [,1] [,2]
## [1,]   19   22
## [2,]   20   23
## [3,]   21   24
## 
## , , 1, 3
## 
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
## 
## , , 2, 3
## 
##      [,1] [,2]
## [1,]    7   10
## [2,]    8   11
## [3,]    9   12
## 

array (1:24, dim = c(3,2,2,3)) [,1,,c(1,2)] ;
## , , 1
## 
##      [,1] [,2]
## [1,]    1    7
## [2,]    2    8
## [3,]    3    9
## 
## , , 2
## 
##      [,1] [,2]
## [1,]   13   19
## [2,]   14   20
## [3,]   15   21
## 

array (1:24, dim = c(3,2,2,3)) [,1,,c(1,2)] [,2,] ;
array (1:24, dim = c(3,2,2,3)) [,1,2,c(1,2)] ;

##      [,1] [,2]
## [1,]    7   19
## [2,]    8   20
## [3,]    9   21

### 👺 如果仅剩两个维度没被限制为 1 ，就能得到二维数组即矩阵。
### 👺 就是说，如果某个维度不是取多个下标而是只取一个，那么该维度将不再会体现在结果多维数组的维度里。即有几个维度被这样对待，结果数组相对于来源数组的维度就要减少几个。
### 👺 由于在某个维度只取一个序号会导致该维度的消失，所以连续用中括号的时候要注意一下维度的变化，有的维度可能已经消失因而相对应的取序号的位置可能会往前顺移。
