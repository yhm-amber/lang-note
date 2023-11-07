duplicated (c(1,1)) ; # [1] FALSE TRUE

unique (c(1,2,3,2)) ; # [1] 1 2 3

### R 检查一个元素是否是重复出现的 duplicated(xs) 的效果，应该是相当于
### 
### xs 
###     |> scan (([],nil)) ((acc,_) -> x ->  (cond ? (acc,cond) : ([... acc, x], cond)) (x in acc)) 
###     |> map ((_,b) -> b) 
### ​
### ​（伪代码）
### ​
### ​相应的 unique 就是把最后改成
### ​
### ​    |> map ((a,_) -> a) 
### ​
### ​然后取出最后一个来了，或者用 reduce 就不用取最后一个。或者：
### ​
### xs 
###     |> scan (([],nil)) ((acc,_) -> x -> (x in acc) ? (acc,nil) : ([... acc, x], x)) 
### ​    |> map ((_,x) -> x) 
###     |> filter (x -> x isnt nil) 
### 
### 这个则是能够流式吐出结果的，从而适应于无限数据。
### 
​
