% will not stack overflow

main(_) -> 
	((fun (X) -> ((X) (X)) end) (fun (X) -> ((X) (X)) end))
.
