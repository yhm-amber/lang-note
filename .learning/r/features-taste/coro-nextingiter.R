
#: 简单数列生成

generate_encilioingzero = coro::generator(\ (.first = 0) {
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







#: 对一个向量循环播放

generate_vecloop = coro::generator(\ (vec, .start_at = 1, .lenfn = base::length) {
	repeat {
		coro::yield(vec[.start_at])
		.start_at = (if (.start_at < .lenfn(vec)) .start_at + 1 else 1)
	}
})

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

base::list2env(base::list(i = 9)) |> base::with({
	coro::loop(for (a in base::toupper(base::letters) |> generate_vecloop(6)) {
		print(a); if ((i <- i - 1) < 0) break
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
#| [1] "O"

