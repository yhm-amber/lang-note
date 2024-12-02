

#| > z |> format(scientific = F) |> paste(collapse = '\n') |> cat()
#|    2000
#| 1000000
#| 1500000
#| 2000000
#| > z |> format(scientific = F, trim = TRUE) |> paste(collapse = '\n') |> cat()
#| 2000
#| 1000000
#| 1500000
#| 2000000
#| > z |> as.character() |> paste(collapse = '\n') |> cat()
#| 2000
#| 1e+06
#| 1500000
#| 2e+06
#| > z |> paste() |> paste(collapse = '\n') |> cat()
#| 2000
#| 1e+06
#| 1500000
#| 2e+06
#| > # So plz format at first before paste.
#| > 
#| > # z: 
#| > c(2000,1000000,1500000,2000000) -> z
