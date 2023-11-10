
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


(\ () 
{
	reptilia.emojis <- 
	data.frame (rank = 1:7
	, emoji = c ("🐍","🐉","🦖","🦎","🐊","🐢","🦕")
	, name = c ("snake","dragon","t-rex","lizard","crocodile","turtle","sauropod")
	, version.unicode = c ("6.0","6.0","10.0","9.0","6.0","6.0","10.0")
	, version.emoji = c ("1.0","1.0","5.0","3.0","1.0","1.0","5.0")
	, year.unicode = c (2010,2010,2017,2016,2010,2010,2017)
	, year.emoji = c (2015,2015,2017,2016,2015,2015,2017)
	) |> 
		(\ (x) 
		{ x |> 
			cbind (site.emojipedia = 
				paste ("https://emojipedia.org/",x$emoji, sep="") )
		} ) () ;
	
	### 👺 上面是做了个表然后基于原表加了个字段。
	
	
	### 👹 这个 `data.table` 是需额外安装的。
	reptilia.emojis.table <- reptilia.emojis |> data.table::setDF() ;
	
	reptilia.emojis |> print();
	reptilia.emojis.table |> print();
	### 👺 这俩会一样地以一种简洁的风格打印表格。
	
	reptilia.emojis |> knitr::kable();
	reptilia.emojis.table |> knitr::kable();
	### 👺 这俩会一样地打印 markdown 格式的表格。
}) ()
### 🤡 输出暂略
