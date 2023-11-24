
as.symbol("aaa") |> identical(quote(aaa)) ;
as.name("aaa") |> identical(quote(aaa)) ;
# [1] TRUE

c("aaa","bbb","ccc") |> Vectorize( as.symbol ) () ;
## $aaa
## aaa
## 
## $bbb
## bbb
## 
## $ccc
## ccc
## 

c("aaa","bbb","ccc") |> Vectorize( as.symbol ) () |> lapply (\(n) identical(n,quote(aaa))) ;
## $aaa
## [1] TRUE
## 
## $bbb
## [1] FALSE
## 
## $ccc
## [1] FALSE
## 

list("aaa","bbb","ccc") |> Vectorize( as.symbol ) () ;
## [[1]]
## aaa
## 
## [[2]]
## bbb
## 
## [[3]]
## ccc
## 

list("aaa","bbb","ccc") |> Vectorize( as.symbol ) () |> lapply (\(n) identical(n,quote(aaa))) ;
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] FALSE
## 
## [[3]]
## [1] FALSE
## 
