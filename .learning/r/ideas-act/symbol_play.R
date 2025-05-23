syms_to_chr = function (...) rlang::ensyms(...) |> purrr::map_chr(base::as.character)
terms_to_chr = function(...) base::as.list(base::substitute(base::list(...)))[-1L] |> purrr::map_chr(~ base::deparse(.x) |> base::paste(collapse = ''))
