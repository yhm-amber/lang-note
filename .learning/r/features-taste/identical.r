
identical (function (x) {x}, function (y) {y}) ; # [1] FALSE
identical (c(1,2), c(c(1),c(2))) ; # [1] TRUE

identical (function (x) {x}, function (x) {x}) ; # [1] TRUE
