
#: 无限递减数列

#: 定义生成器
generate_encilioingzero = coro::generator(\ (.first = 0) {
	repeat { coro::yield(.first); .first = .first - 1 }
})

#: 默认参数使用
coro::loop(for (a in generate_encilioingzero()) {
	print(a)
}) #: will gen nums continuously like:

#| ...
#| [1] -98082
#| [1] -98083
#| [1] -98084
#| [1] -98085
#| [1] -98086
#| [1] -98087
#| [1] -98088
#| [1] -98089
#| [1] -98090
#| [1] -98091
#| [1] -98092
#| [1] -98093
#| [1] -98094
#| [1] -98095
#| ...

#: 指定递减数列的开始
coro::loop(for (a in generate_encilioingzero(999999)) {
	print(a)
}) #: will gen nums continuously like:

#| ...
#| [1] 979129
#| [1] 979128
#| [1] 979127
#| [1] 979126
#| [1] 979125
#| [1] 979124
#| [1] 979123
#| [1] 979122
#| [1] 979121
#| [1] 979120
#| [1] 979119
#| ...







#: 循环播放一个向量

#: 生成器定义
generate_vecloop = coro::generator(\ (vec, .start_at = 1, .lenfn = base::length) {
	repeat {
		coro::yield(vec[.start_at])
		.start_at = (if (.start_at < .lenfn(vec)) .start_at + 1 else 1)
	}
})

#: 无限循环播放大写字母
coro::loop(for (a in generate_vecloop(base::toupper(base::letters))) {
	print(a)
})

#| ...
#| [1] "B"
#| [1] "C"
#| [1] "D"
#| [1] "E"
#| [1] "F"
#| [1] "G"
#| [1] "H"
#| [1] "I"
#| [1] "J"
#| [1] "K"
#| [1] "L"
#| [1] "M"
#| ...

#: 指定停止点 - 播放九个后停止
base::list2env(base::list(i = 9)) |> base::with({
	coro::loop(for (a in base::toupper(base::letters) |> generate_vecloop(6)) {
		print(a); if ((i <- i - 1) > 0) {} else break
	})
})

#| [1] "F"
#| [1] "G"
#| [1] "H"
#| [1] "I"
#| [1] "J"
#| [1] "K"
#| [1] "L"
#| [1] "M"
#| [1] "N"


#: 准备数据集
data.table::setDT(src <- dplyr::starwars |> dplyr::select(base::seq(11)))

#: 把数据集当作向量循环播放（有断点） - 行
base::list2env(base::list(i = 9)) |> base::with({
	coro::loop(for (a in src |> generate_vecloop(6, .lenfn = base::nrow)) {
		print(a); if ((i <- i - 1) > 0) {} else break
	})
})
#|         name height  mass  hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|       <char>  <int> <num>      <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Owen Lars    178   120 brown, grey      light      blue         52   male masculine  Tatooine   Human
#|                  name height  mass hair_color skin_color eye_color birth_year    sex   gender homeworld species
#|                <char>  <int> <num>     <char>     <char>    <char>      <num> <char>   <char>    <char>  <char>
#| 1: Beru Whitesun Lars    165    75      brown      light      blue         47 female feminine  Tatooine   Human
#|      name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|    <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1:  R5-D4     97    32       <NA> white, red       red         NA   none masculine  Tatooine   Droid
#|                 name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|               <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Biggs Darklighter    183    84      black      light     brown         24   male masculine  Tatooine   Human
#|              name height  mass    hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|            <char>  <int> <num>        <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Obi-Wan Kenobi    182    77 auburn, white       fair blue-gray         57   male masculine   Stewjon   Human
#|                name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|              <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Anakin Skywalker    188    84      blond       fair      blue       41.9   male masculine  Tatooine   Human
#|              name height  mass   hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|            <char>  <int> <num>       <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Wilhuff Tarkin    180    NA auburn, grey       fair      blue         64   male masculine    Eriadu   Human
#|         name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|       <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Chewbacca    228   112      brown    unknown      blue        200   male masculine  Kashyyyk Wookiee
#|        name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|      <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Han Solo    180    80      brown       fair     brown         29   male masculine  Corellia   Human


#: 把数据集当作向量循环播放（有断点） - 列
base::list2env(base::list(i = 9)) |> base::with({
	coro::loop(for (a in base::as.list(src) |> generate_vecloop(6)) {
		str(a); if ((i <- i - 1) > 0) {} else break
	})
})
#| List of 1
#|  $ eye_color: chr [1:87] "blue" "yellow" "red" "yellow" ...
#| List of 1
#|  $ birth_year: num [1:87] 19 112 33 41.9 19 52 47 NA 24 57 ...
#| List of 1
#|  $ sex: chr [1:87] "male" "none" "none" "male" ...
#| List of 1
#|  $ gender: chr [1:87] "masculine" "masculine" "masculine" "masculine" ...
#| List of 1
#|  $ homeworld: chr [1:87] "Tatooine" "Tatooine" "Naboo" "Tatooine" ...
#| List of 1
#|  $ species: chr [1:87] "Human" "Droid" "Droid" "Human" ...
#| List of 1
#|  $ name: chr [1:87] "Luke Skywalker" "C-3PO" "R2-D2" "Darth Vader" ...
#| List of 1
#|  $ height: int [1:87] 172 167 96 202 150 178 165 97 183 182 ...
#| List of 1
#|  $ mass: num [1:87] 77 75 32 136 49 120 75 32 84 77 ...





#: we can also ---

#: to define a df row-loop - directly,
generate_dfloop = coro::generator(\ (df, .start_row = 1) {
	repeat {
		coro::yield(df[.start_row, ])
		.start_row = (if (.start_row < base::nrow(df)) .start_row + 1 else 1)
	}
})

#: ... - or using vec-loop warpper!
#: (no-need to use coro::loop inner a coro::generator fn define)
generate_dfloop = coro::generator(\ (df, .start_row = 1) {
	for (i in generate_vecloop(base::seq(base::nrow(df)))) {
		print(df[i, ])
	}
})

coro::loop(for (a in generate_dfloop(src)) {
	print(a)
})
#: will looping-play rows in src.

