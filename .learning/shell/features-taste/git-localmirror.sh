


#: demo with repo: gh:SukiSU-Ultra/SukiSU-Ultra.git

: got mirror
(
	mkdir -p -- SukiSU.Ultra-src && 
	cd -- SukiSU.Ultra-src && 
	git clone -v --mirror -- https://github.com/SukiSU-Ultra/SukiSU-Ultra.git && 
	cd -- SukiSU-Ultra.git && 
	
	echo -- main dev | while read -r -- branch ; 
	do git worktree add ../tree/"$branch" "$branch" ; done && 
	
	echo -- v4.1.2 v3.1.9 | while read -r -- tag ; 
	do git worktree add ../tags/"$tag" "$tag" ; done && 
	
	# {
	# 	git worktree add ../tree/main main ; 
	# 	git worktree add ../tree/dev dev ; 
	# 	git worktree add ../tags/v4.1.2 v4.1.2 ; 
	# 	git worktree add ../tags/v3.1.9 v3.1.9 ; 
	# } && 
	
	: )


: update trees - only wt main
#: simple for only branch main - to the bare repo.git then: 
#: ~ (cd ../tree/main && git checkout --detach) && git remote update && (cd ../tree/main && git checkout main)

: update trees
#: ..but for more wt branch - to the bare repo.git then: 
#: ~ ((cd ../tree/beanch-a && git checkout --detach) && (cd ../tree/beanch-b && git checkout --detach) && ...) && 
#: ~ git remote update && 
#: ~ ((cd ../tree/beanch-a && git checkout beanch-a) && (cd ../tree/beanch-b && git checkout beanch-b) && ...) && 
#: ~ :;
#: so can be codes: 
(
	cd -- SukiSU.Ultra-src/SukiSU-Ultra.git && 
	
	: git remote update && # will error, need add : for go on.
	#2> fatal: refusing to fetch into branch 'refs/heads/dev' checked out at '../tree/dev'
	
	find -- ../tree -maxdepth 1 -mindepth 1 -type d | 
		while read -r -- path ; 
		do 
			( 
				cd -- "$path" && 
				git checkout --detach && 
				: ) && 
			(1>&2 echo - :detached: "$path") && 
			:; 
		done && 
	
	git remote update && 
	(
		1>&2 echo - :remote updated: "$(
			read -r -- pwd < <(echo "$PWD") && 
			echo "$(dirname "$pwd" | xargs basename)/$(basename "$pwd")" && 
			: )" && 
		: ) && 
	
	find -- ../tree -maxdepth 1 -mindepth 1 -type d | 
		while read -r -- path ; 
		do 
			( 
				cd -- "$path" && 
				git checkout "$(basename "$path")" && 
				: ) && 
			(1>&2 echo - :checkouted: "$path" as "$(basename "$path")") && 
			:; 
		done && 
	: )




