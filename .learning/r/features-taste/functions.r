`names<-` (1:2, c("a", "b")) ;
(function (x, y) { attr (x, "names") <- y  ; x }) (1:2, c("a", "b")) ;
(function (x, y) { names (x) <- y  ; x }) (1:2, c("a", "b")) ;
## a b 
## 1 2 

`[<-` (1:3, 2, 99) ;
(function (x) {function (y) {function (z) { x[y] <- z ; x }}}) (1:3) (2) (99) ;
# [1]  1 99  3

5 - 2 ;
`-` (5,2) ;
# [1] 3

