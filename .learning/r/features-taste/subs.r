
1 %in% c(1,2) ; # [1] TRUE
c(1,3) %in% c(1,2,4) ; # [1] TRUE FALSE
c(1,NA) %in% c(1,2,4) ; # [1] TRUE FALSE
c(1,NA) %in% c(1,2,4,NA) ; # [1] TRUE TRUE

match (c(1,3), c(2,3,4,3)) ; # [1] NA 2

intersect (c(2,5,7), c(1,5,2,5)) ; # [1] 2 5

union (c(5,7,2), c(2,1,5,2,5)) ; # [1] 5 7 2 1
union (c(2,1,5,2,5), c(5,7,2)) ; # [1] 2 1 5 7

setdiff (c(7,5,3), c(2,1,5,2,5)) ; # [1] 7 3
setdiff (c(2,1,5,2,5), c(7,5,3)) ; # [1] 2 1

setequal (c(1,2,3,2), c(3,3,2,2,1)) ; # [1] TRUE
