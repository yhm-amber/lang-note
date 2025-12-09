generate_encilioingzero = coro::generator(\ () {
	.first = 0
	repeat { coro::yield(.first); .first = .first - 1 }
})

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

