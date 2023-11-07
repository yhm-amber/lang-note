
print("Hello, world!"); # [1] "Hello, world!"
(function (x) { function (y) { x + y } }) (x=3) (y=4) ; # [1] 7
!c(TRUE,FALSE,TRUE) ; # [1] FALSE TRUE FALSE

seq (0, pi, length.out=10) ;
##  [1] 0.0000000 0.3490659 0.6981317 1.0471976 1.3962634 1.7453293 2.0943951
##  [8] 2.4434610 2.7925268 3.1415927

length(c(1,2,3,4)) ; # [1] 4
length(c(1,2,3,-4)) ; # [1] 4

numeric(4) ; # [1] 0 0 0 0

(function (x) { ifelse(x < 0, 0, 1) }) (c (1,-2,3,-4)) ; # [1] 1 0 1 0

