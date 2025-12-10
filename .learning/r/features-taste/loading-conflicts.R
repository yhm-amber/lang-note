
#: a simple good way
dplyr::starwars |> dplyr::filter(height < 1)
#| # A tibble: 0 × 14
#| # ℹ 14 variables: name <chr>, height <int>, mass <dbl>, hair_color <chr>,
#| #   skin_color <chr>, eye_color <chr>, birth_year <dbl>, sex <chr>, gender <chr>,
#| #   homeworld <chr>, species <chr>, films <list>, vehicles <list>, starships <list>

# ------------

#: if wans to using `base::library`
library(conflicted)
library(dplyr)
starwars |> filter(height < 1)
#| Error:
#| ! [conflicted] filter found in 2 packages.
#| Either pick the one you want with `::`:
#| • dplyr::filter
#| • stats::filter
#| Or declare a preference with `conflicts_prefer()`:
#| • conflicts_prefer(dplyr::filter)
#| • conflicts_prefer(stats::filter)
#| Run `rlang::last_trace()` to see where the error occurred.

#: the {conflicted} package can auto-validate potential ambiguities.
#: and you can just need to add the disambiguation code as prompted.

conflicts_prefer(dplyr::filter)
#| [conflicted] Will prefer dplyr::filter over any other package.
starwars |> filter(height < 1)
#| ...

#~ ref: https://conflicted.r-lib.org/#usage

# ------------

#: you can also use {modules} to isolate the namespace.
m = modules::module({ dplyr = modules::import('dplyr') })
#| Masking (modules:dplyr):
#|   `intersect` from: base
#|   `setdiff` from: base
#|   `setequal` from: base
#|   `union` from: base
dplyr
#| Error: object 'dplyr' not found
starwars
#| Error: object 'starwars' not found
m$dplyr$starwars |> m$dplyr$filter(height < 1)
#| ...

#~ ref: https://conflicted.r-lib.org/#alternative-approaches

# ------------

#: or use {import} to got a python-style import.
dplyr |> import::from(fp.filter = filter, starwars)
#: this could create an attached environment 'imports' and `starwars`, `fp_filter` are in it.
starwars |> fp.filter(height < 1)
#| ...

#~ ref: https://conflicted.r-lib.org/#alternative-approaches

