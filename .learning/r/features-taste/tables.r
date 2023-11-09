
(\ () 
{
	funny.langs <- data.frame ( rk = 1:4
	, lang.emoji = c ("🐌","🦀","🐫","🛷")
	, lang.name = c ("sh","rust","ocaml","wasm")
	) ;
	
	funny.langs |> print();
	`$<-` (funny.langs, "x", 2:5) |> print();
	`$<-` (funny.langs, "xx", 2*2:5) |> print();
	cbind (funny.langs, xxx = 3*2:5) |> print();
	funny.langs |> cbind (xxxx = 4*2:5) |> print();
}) () ;
##   rk lang.emoji lang.name
## 1  1         🐌        sh
## 2  2         🦀      rust
## 3  3         🐫     ocaml
## 4  4         🛷      wasm
##   rk lang.emoji lang.name x
## 1  1         🐌        sh 2
## 2  2         🦀      rust 3
## 3  3         🐫     ocaml 4
## 4  4         🛷      wasm 5
##   rk lang.emoji lang.name xx
## 1  1         🐌        sh  4
## 2  2         🦀      rust  6
## 3  3         🐫     ocaml  8
## 4  4         🛷      wasm 10
##   rk lang.emoji lang.name xxx
## 1  1         🐌        sh   6
## 2  2         🦀      rust   9
## 3  3         🐫     ocaml  12
## 4  4         🛷      wasm  15
##   rk lang.emoji lang.name xxxx
## 1  1         🐌        sh    8
## 2  2         🦀      rust   12
## 3  3         🐫     ocaml   16
## 4  4         🛷      wasm   20
