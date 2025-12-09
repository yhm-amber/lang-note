a = 999
b = data.table::as.data.table(dplyr::starwars)[F]

print(b[a] |> dplyr::select(base::seq(11)))
#|      name height  mass hair_color skin_color eye_color birth_year    sex gender homeworld species
#|    <char>  <int> <num>     <char>     <char>    <char>      <num> <char> <char>    <char>  <char>
#| 1:   <NA>     NA    NA       <NA>       <NA>      <NA>         NA   <NA>   <NA>      <NA>    <NA>
print(a)
#| [1] 999

base::list2env(base::list(
		a = 1, 
		b = data.table::as.data.table(dplyr::starwars))) |> 
		base::with({
				print(b[a] |> dplyr::select(base::seq(11)))
				print(a)
		})
#|              name height  mass hair_color skin_color eye_color birth_year    sex    gender homeworld species
#|            <char>  <int> <num>     <char>     <char>    <char>      <num> <char>    <char>    <char>  <char>
#| 1: Luke Skywalker    172    77      blond       fair      blue         19   male masculine  Tatooine   Human
#| [1] 1

print(b[a] |> dplyr::select(base::seq(11)))
#|      name height  mass hair_color skin_color eye_color birth_year    sex gender homeworld species
#|    <char>  <int> <num>     <char>     <char>    <char>      <num> <char> <char>    <char>  <char>
#| 1:   <NA>     NA    NA       <NA>       <NA>      <NA>         NA   <NA>   <NA>      <NA>    <NA>
print(a)
#| [1] 999
