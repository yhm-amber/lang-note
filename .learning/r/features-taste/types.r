factor(c('A', 'B', 'A', 'C')) ; 
## [1] A B A C
## Levels: A B C

typeof (c('A', 'B', 'A', 'C')) ; # [1] "character"
typeof (factor(c('A', 'B', 'A', 'C'))) ; # [1] "integer"

typeof (c(1)) ; # [1] "double"
typeof (c(NA,1)) ; # [1] "double"
typeof (1) ; # [1] "double"

typeof (c(NA,NA)) ; # [1] "logical"
typeof (c(TRUE,FALSE,TRUE)) ; # [1] "logical"
typeof (c(1,TRUE)) ; # [1] "double"

1:10 ; # [1]  1  2  3  4  5  6  7  8  9 10
1.0:5.1 ; # [1] 1 2 3 4 5

typeof (1:10) ; # [1] "integer"
typeof (1.0:5.1) ; # [1] "integer"

factor (1:5) ; 
## [1] 1 2 3 4 5
## Levels: 1 2 3 4 5

is.logical (NA) ; # [1] TRUE
is.integer (factor(NA)) ; # [1] FALSE
is.integer (1:3) ; # [1] TRUE
typeof (factor(NA)) ; # [1] "integer"
is.integer (factor(1:3)) ; # [1] FALSE
is.double (c (1,2,3)) ; # [1] TRUE
is.integer (c(1L, -3L)) ; # [1] TRUE

c(-1, 0, 1) / 0 ; # [1] -Inf  NaN  Inf
typeof (c(-1, 0, 1) / 0) ; # [1] "double"
is.double (c(-1, 0, 1) / 0) ; # [1] TRUE

c(-1L, 0L, 1L) / 0L ; # [1] -Inf  NaN  Inf
typeof (c(-1L, 0L, 1L) / 0L) ; # [1] "double"
is.double (c(-1L, 0L, 1L) / 0L) ; # [1] TRUE

is.finite (c (c(-1L, 0L, 1L) / 0L, NULL, 1, NA)) ;    # [1] FALSE FALSE FALSE  TRUE FALSE
is.infinite (c (c(-1L, 0L, 1L) / 0L, NULL, 1, NA)) ;  # [1]  TRUE FALSE  TRUE FALSE FALSE
is.na (c (c(-1L, 0L, 1L) / 0L, NULL, 1, NA)) ;    # [1] FALSE  TRUE FALSE FALSE  TRUE
is.nan (c (c(-1L, 0L, 1L) / 0L, NULL, 1, NA)) ;   # [1] FALSE  TRUE FALSE FALSE FALSE
is.null (c (c(-1L, 0L, 1L) / 0L, NULL, 1, NA)) ;  # [1] FALSE

is.null (c(NULL,NULL)) ; # [1] TRUE

is.integer (NA_integer_) ; # [1] TRUE
is.double (NA_real_) ; # [1] TRUE
is.character (NA_character_) ; # [1] TRUE

list("a", 1L, 1.5) ;
## [[1]]
## [1] "a"
## 
## [[2]]
## [1] 1
## 
## [[3]]
## [1] 1.5
## 

typeof(list("a", 1L, 1.5)) ; # [1] "list"

c(1, c(2,3, c(4,5))) ; # [1] 1 2 3 4 5
c(FALSE, 1L, 2.5, "3.6") ; # [1] "FALSE" "1"     "2.5"   "3.6"  

as.numeric (c(FALSE, TRUE)) ; # [1] 0 1
as.character (c(FALSE, TRUE)) ; # [1] "FALSE" "TRUE" 

TRUE + 10 ; # [1] 11
paste("abc", 1) ; # [1] "abc 1"
