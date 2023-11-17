
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
	reptilia.emojis.table <- reptilia.emojis |> data.table::setDT() ;
	
	reptilia.emojis |> print();
	reptilia.emojis.table |> print();
	### 👺 这俩会以一种简洁的风格打印表格。后者比前者会多出类型部分。
	
	reptilia.emojis |> knitr::kable();
	reptilia.emojis.table |> knitr::kable();
	### 👺 这俩会一样地打印 markdown 格式的表格。
	### 👹 这个 `knitr` 是需额外安装的。
	
	### 👺 data.table 就是 class 字段是 [1] "data.table" "data.frame" 的对象。
	### 👺 data.frame 就是 class 字段是 [1] "data.frame" 的对象。
	### 👺 它俩的 typeof 输出都是 [1] "list" 。
}) ()
### 🤡 输出暂略


(\ (ff) 
{
	`[[<-` (mtcars, ff, value = 1:nrow(mtcars))$pp |> print();
	`$<-` (mtcars, ff, 1:nrow(mtcars))$ff |> print();
	# ~ 1:32
}) ("pp") ;

### 👺 在 "data.frame" 里： `[[<-` 可以动态决定字段名，`$<-` 不行。
### 👺 但前者传值必须用具名参数，后者则没有该具名参数。

(\ () 
{
	divisibal = \(a,b) a %% b == 0 ;
	divisibal -> `%.%` ;
	
	split_records = 
	\ (src, limitsize, spliter_fieldname = "split_group") (\ (nrows) (\ (fielded) 
		fielded |> split (fielded [[spliter_fieldname]] )
		) (fielded = `[[<-` (src, spliter_fieldname
			, value = (1:nrows - (if (nrows %.% limitsize) 1 else 0)) %/% limitsize)
		)) (nrows = src |> nrow()) ;
	
	# mtcars |> split_records (你希望按每份最多多大来切)
	# mtcars |> split_records (你希望按每份最多多大来切, 这里可以自己写个切分序号列的字段名)
	
	### 👺 计算 (1:nrow(src)) %/% limitsize 可得到内容为 limitsize 个 0 然后 limitsize 个 1 然后 limitsize 个 2 以此类推的序列的向量。
	### 👺 然后这个序列会被补充为相应的一列，允许自定义列名是为了避免覆盖已有列。然后就是按这列来切了。
	
	### 👺 正常应该是计算 (1:nrow(src) - 1) %/% limitsize 才可得到内容为 limitsize 个 0 然后 limitsize 个 1 然后 limitsize 个 2 以此类推的序列的向量。
	### 👺 如果没有减去 1 的话，第一个分区就会少一行。在 nrow(src) 刚好能整除 limitsize 的时候这会导致多分一个分区其中只有一行，
	### 👺 但多数不能整除的情况下这都会让最后余数行的那个分区多一行而第一个分区会少一行，从而相对来说更均匀一些。
	### 👺 而再加上 (if (nrows %.% limitsize) 1 else 0) 就可以根据情况自动选择了。
	
	mtcars |> split_records (6) |> print (); # 这会给出一个列表，其中每个元素都是表，每个表都是最多有 6 行。实际会是第一个分区 5 行、最后分区 3 行，其余分区均为 6 行。
	mtcars |> split_records (8) |> print (); # 这会给出一个列表，其中每个元素都是表。 8 刚好能被 32 整除，所以每个表都是 8 行。
	
	
	pieces2limitsize = 
	\ (pieces, wholesize) wholesize %/% pieces ;
	
	chop_records = 
	\ (src, pieces) src |> split_records (pieces |> pieces2limitsize (src |> nrow ())) ;
	### 👺 这个只能确保尽可能均匀切出多少整份，可能有余数份。
	
	mtcars |> chop_records (3) |> print (); # 它会被尽可能均匀地切成 3 整份（有余份）然后作为结果给出。
	mtcars |> chop_records (4) |> print (); # 它会被尽可能均匀地切成 4 整份（无余份）然后作为结果给出。
	
	divide_records = 
	\ (src, pieces, distributer_fieldname = "distributed_group") (\ (fielded) 
		fielded |> split (fielded [[distributer_fieldname]] )
		) (fielded = `[[<-` (src, distributer_fieldname
			, value = (1:nrow(src) - 1) %% pieces)) ;
	
	mtcars |> divide_records (3) |> print (); # 会尽可能均匀地分出 3 个组，不确保完全均匀。
	mtcars |> divide_records (4) |> print (); # 会尽可能均匀地分出 4 个组，不确保完全均匀。
}) ()

