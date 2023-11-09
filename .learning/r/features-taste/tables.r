
(\ () 
{
	funny.langs <- data.frame ( rk = 1:4
	, lang.emoji = c ("🐌","🦀","🐫","🛷")
	, lang.name = c ("sh","rust","ocaml","wasm")
	) ;
	
	funny.langs ;
	`$<-` (funny.langs, "x", 2:5) ;
	`$<-` (funny.langs, "xx", 2*2:5) ;
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
