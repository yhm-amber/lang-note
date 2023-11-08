`names<-` (1:2, c("a", "b")) ;
## a b 
## 1 2 

(function (x, y) { attr (x, "names") <- y  ; x }) (1:2, c("a", "b")) ;

(function (x, y) { names (x) <- y  ; x }) (1:2, c("a", "b")) ;
## a b 
## 1 2 
