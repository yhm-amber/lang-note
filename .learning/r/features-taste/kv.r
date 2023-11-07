c ("a" = 1, "b" = 2, "c" = 3, "d" = 4) ;
## a b c d 
## 1 2 3 4 

c ("a" = 1, "b" = 2, "c" = 3, "d" = 4) [c ("c","a","e")] ;
##   c    a <NA> 
##   3    1   NA 

table (c("a","a","b","c")) ;
## a b c
## 2 1 1

setNames (c (1,2,3,4), c("a","b","c","d")) ;
## a b c d 
## 1 2 3 4 

unname (setNames (c (1,2,3,4), c("a","b","c","d"))) ; # [1] 1 2 3 4

setNames (c("a","b","c","d"), c (1,2,3,4)) ;
##   1   2   3   4 
## "a" "b" "c" "d" 

unname (setNames (c("a","b","c","d"), c (1,2,3,4))) ; # [1] "a" "b" "c" "d"

setNames (c (1,2,3,4), c (4,3,2,1)) ;
## 4 3 2 1 
## 1 2 3 4 

setNames (c (1,2,3,4), c (4,3,2,1)) [c (1,1,3,5)] ;
##    4    4    2 <NA> 
##    1    1    3   NA 

setNames (c("a","b","c","d"), c (1,2,3,4)) [c (1,1,3,5)] ;
##    1    1    3 <NA> 
##  "a"  "a"  "c"   NA 

setNames (c (1,2,3,4), c("a","b","c","d")) [c (1,1,3,5)] ;
##    a    a    c <NA> 
##    1    1    3   NA 

