
#: run code after 1 sec like this:
(~ cat('woa !!')) |> later::later(1)
(\ () cat('woa !!')) |> later::later(1) # ..same
#a> woa !!

#: default delay is 0 sec
(~ message('woa !!')) |> later::later(0)
(~ message('woa !!')) |> later::later() # ..same
later::later(~ message('woa !!')) # ..same
#a>> woa !!

#: var access
a = 1
later::later(~ message(glue::glue_safe('woa !! {a}')))
#a>> woa !! 1
