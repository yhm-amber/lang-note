
attributes (NA) ; # NULL
attributes (1L) ; # NULL
attributes (2) ; # NULL
attributes (c(9,0)) ; # NULL

attributes (table (12)) ;
## $dim
## [1] 1
## 
## $dimnames
## $dimnames[[1]]
## [1] "12"
## 
## 
## $class
## [1] "table"
## 

attributes (list("a", 1L, 1.5)) ; # NULL

(function (x) { attributes (x) <- NULL ; x }) (table (12)) ; # [1] 1
(function (x) { attributes (x) <- NULL ; x }) (table (c (1L,2L,3L))) ; # [1] 1 1 1
(function (x) { attributes (x) <- NULL ; x }) (table (c (1L,2L,1L))) ; # [1] 2 1


(function (x) {function (a) {function (b) { attr (x, a) <- b ; x }}}) (12) ("Tom") (1) ;
## [1] 12
## attr(,"Tom")
## [1] 1

(function ()
{ x <- 0 ; y <- 0 ; names(lm(x ~ y)) })() ;
##  [1] "coefficients"  "residuals"     "effects"       "rank"         
##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
##  [9] "xlevels"       "call"          "terms"         "model"   


matrix(1:12, nrow=3, ncol=4) ;
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12

attr (matrix(1:12, nrow=3, ncol=4), "dim") ; # [1] 3 4
dim (matrix(1:12, nrow=3, ncol=4)) ; # [1] 3 4
