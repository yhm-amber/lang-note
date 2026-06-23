#!/usr/bin/env sh


git_bike () 
(
	_out_param () 
	(
		for x in "$@" ;
		do "${OUTER_FN:-echo}" "${x}" && :; done && 
		: ) && 
	
	_params_take () 
	(
		head () ( echo "$1" && : ) && 
		tail () ( shift 1 && _out_param "$@" && : ) && 
		home () ( _out_param "$@" | head -n "$(($# - 1))" && : ) && 
		ende () ( shift "$(($# - 1))" && _out_param "$@" && : ) && 
		: :: && 
		"$@" && 
		: ) && 
	
	_flatout_line () 
	(
		while read -r -- line ;
		do OUTER_FN="${FLATTER_FN:-echo}" "${@:-_out_param}" $line && :; done && 
		: ) && 
	
	_std_exec () 
	(
		#: (echo true | _std_exec once) && echo a || echo x
		#: echo true | _std_exec once echo status is:
		once () 
		(
			read -r -- xs && 
			"$@" ${xs} && 
			: ) && 
		
		#: echo 'true' | _std_exec lines
		lines () 
		(
			while read -r -- line ;
			do "$@" $line && :; done && 
			: ) && 
		: :: && 
		"$@" && 
		: ) && 
	
	#: repo_chk shallow . && git fetch --unshallow --all
	repo_chk () 
	(
		gitdir () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-inside-git-dir | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is inside gitdir ~' ) | 
				_std_exec once && 
			: ) && 
		
		worktree () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-inside-work-tree | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is inside worktree ~' ) | 
				_std_exec once && 
			: ) && 
		
		bare () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-bare-repository | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is bare repository ~' ) | 
				_std_exec once && 
			: ) && 
		
		shallow () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-shallow-repository | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is shallow repository ~' ) | 
				_std_exec once && 
			: ) && 
		: :: && 
		"$@" && 
		: ) && 
	
	#: ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | LINES_MAX=2 _wait_outs    #> out 1, ::2 after 10 sec. waites.
	#: ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | LINES_MAX=2 _wait_outs :: #> out ::2, ::3 after 10 sec. waites.
	_wait_outs() 
	(
		PAT="$*" awk -v max="${LINES_MAX:-6}" -- ' 
		BEGIN { pat = ENVIRON["PAT"] }
		$0 ~ pat { if (c < max) { a[++c] = $0 } else { next } }
		END { for (i = 1; i < 1 + c; i++) print a[i] }' && 
		: )
	
	#: git_bike auto_clone -- <remote-link> [<aim-path>]
	auto_clone () 
	(
		echo :: git cloning in shallow mode '(i.e.: depth 1)' :: && 
		while ! git clone --progress --depth 1 --no-single-branch "$@" 2>&1 ;
		do 1>&2 echo tried: "$((++try_clone))" for clone && :; done | 
			tee >(cat 1>&2) | 
			#::	will only out 3 lines (which has "'")
			#;;	 after keep waiting until EOF
			LINES_MAX=3 _wait_outs "'" | 
			#::	Just a head -n 1 alternative
			#;;	 but with no SIGPIPE to avoid pipe-broken.
			LINES_MAX=1 _wait_outs 'Cloning into' | 
			_flatout_line _out_param | 
			tail -n 1 | 
			cut -d "'" -f 2 | 
			while read -r -- out_dir ;
			do 
			(
				echo :: change workdir to "\`${out_dir}\`" from "\`$PWD\`" to unshallow fetch :: && 
				cd "${out_dir}" && 
				while ! ( repo_chk shallow . && git fetch --unshallow --all && : ) ;
				do 1>&2 echo tried: "$((++try_unshallow))" for unshallow && :; done && 
				: ) && 
			break ; done
		: ) && 
	
	#: git_bike all_sync [<workspace>] [<workspace>] ...
	#::	workspace: means the prefix in full name of a repo
	#..	 like it in so many hubs -- <workspace>/<reponame>. In generally
	#;;	 a 'workspace' can be the id-name of a(n) user or org.
	all_sync () 
	(
		_out_param "${@:-.}" | _all_sync && 
		: ) && 
	
	_all_sync () 
	(
		while read -r -- workspace ;
		do 
			ls -1 -d -- "${workspace}/*" | 
				( tee >(cat >&3) | _all_pull && : ) 3>&1 | 
				( tee >(cat >&3) | _all_push && : ) 3>&1 | 
				cat -n -- - 1>&2 && 
			:; 
		done && 
		: ) && 
	
	
	#: git_bike all_push [<git-dir>] [<git-dir>] ...
	all_push () 
	(
		_out_param "${@:-.}" | _all_push && 
		: ) && 
	
	_all_push () 
	(
		while read -r -- gitdir ;
		do 
			(
				cd "${gitdir}" && 
				git pull && 
				git remote | while read -r -- git_remote ;
				do 
					echo working: push to remote "'${git_remote}'" for "'${gitdir}'" && 
					git push "${git_remote}" && 
					:; 
				done && 
				: ) && 
			:; 
		done
		: ) && 
	
	
	#: git_bike all_pull [<git-dir>] [<git-dir>] ...
	all_pull () 
	(
		_out_param "${@:-.}" | _all_pull && 
		: ) && 
	
	_all_pull () 
	(
		while read -r -- gitdir ;
		do 
			(
				cd "${gitdir}" && 
				git remote | while read -r -- git_remote ;
				do 
					echo working: pull from remote "'${git_remote}'" for "'${gitdir}'" && 
					git pull "${git_remote}" && 
					:; 
				done && 
				git pull && 
				: ) && 
			:; 
		done
		: ) && 
	
	
	: -------- && 
	
	"$@" && 
	: )


#### 别令速记
# ~~~~
	# git clone --no-single-branch -- ...
	# git clone --depth=1 --no-single-branch -- ...
	# git clone --deeprn=1 --no-single-branch -- ...
	
	# x_Retry git fetch --unshallow --all
	
	# git branch --all | cat # 可得全分支
	# git tag --no-column | cat # 可得全签记
# ~~~~

# : \
git_bike "$@" && :





### considering more but unfinished ...
# ~~~~
	# #: git_bike autosync <workspace> [<workspace> ...]
	# autosync () 
	# (
	# 	for workspace in "$@" ; 
	# 	do (
	# 		# cd  && 
	# 		# 每工间当皆 repo
	# 		ls -1 -d -- "${workspace}/*" | while read repo_path ; 
	# 		do (
	# 			cd "${repo_path}" && 
	# 			# 得皆更
	# 			git fetch --all && 
	# 			git remote | 
	# 				while read remote_name ; 
	# 				do 
	# 					git for-each-ref --format '%(refname:short)' -- refs/remotes/"${remote_name}" | 
	# 						#: 却引
	# 						grep -F -v -- '->' | 
	# 						#: 必详
	# 						grep -F -- '/' | 
	# 						#: 明分
	# 						awk -F "${remote_name}/" -- '{print "'"${remote_name}"'",$2}' | 
	# 						#: 序之
	# 						sort -u | 
	# 						#: 以待排布
	# 						cat && 
	# 					:; 
	# 				done | 
	# 				#: 排布 得各支 与其诸源
	# 				awk -- '
	# 					{ mem[$2] = !mem[$2] ? $1 : mem[$2] " " $1 } 
	# 					END { for (i in mem) print i,mem[i] } 
	# 					BEGIN { OFS = "\t" }' | 
	# 				#? 通道 012 皆有默认消费 再多则必须显式定义消费
	# 				( 
	# 					tee >(cat >&3) | 
	# 						awk -- '
	# 							BEGIN { IFS = "\t" } 
	# 							BEGIN { OFS = "\t" } 
	# 							{ print "- "$1":", $2 } 
	# 							BEGIN { hi_cn = "此有分支 从出诸源" } 
	# 							BEGIN { hi_en = "There are Branches, with their source Remotes." } 
	# 							BEGIN { print hi_cn } 
	# 							BEGIN { print hi_en } 
	# 							BEGIN { print "----" }' | 
	# 						cat >&5 && 
	# 					: ) 3>&1 | 
	# 				while read -r -- branch sources ## TODO HERE ...
	# 				cat && 
	# 			: ) && 
	# 			:; 
	# 		done
	# 		: ) && 
	# 		:; 
	# 	done && 
	# 	: )
# ~~~~




#### demo -----------------------

#|	$ git_bike auto_clone https://github.com/LibreService/my_rime.git --mirror
#|	:: git cloning in shallow mode (i.e.: depth 1) ::
#|	Cloning into bare repository 'my_rime.git'...
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Recv failure: Connection was reset
#|	tried: 1 for clone
#|	Cloning into bare repository 'my_rime.git'...
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21286 ms: Could not connect to server
#|	tried: 2 for clone
#|	Cloning into bare repository 'my_rime.git'...
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21287 ms: Could not connect to server
#|	tried: 3 for clone
#|	Cloning into bare repository 'my_rime.git'...
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Recv failure: Connection was reset
#|	tried: 4 for clone
#|	Cloning into bare repository 'my_rime.git'...
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21308 ms: Could not connect to server
#|	tried: 5 for clone
#|	Cloning into bare repository 'my_rime.git'...
#|	remote: Enumerating objects: 589, done.
#|	remote: Counting objects: 100% (589/589), done.
#|	remote: Compressing objects: 100% (433/433), done.
#|	remote: Total 589 (delta 272), reused 314 (delta 124), pack-reused 0 (from 0)
#|	Receiving objects: 100% (589/589), 63.24 MiB | 9.70 MiB/s, done.
#|	Resolving deltas: 100% (272/272), done.
#|	:: change workdir to `my_rime.git` from `/mnt/e/rimeweb.pwa-src` to unshallow fetch ::
#|	repochk: `/mnt/e/rimeweb.pwa-src/my_rime.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21329 ms: Could not connect to server
#|	tried: 1 for unshallow
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21321 ms: Could not connect to server
#|	tried: 2 for unshallow
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21291 ms: Could not connect to server
#|	tried: 3 for unshallow
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21287 ms: Could not connect to server
#|	tried: 4 for unshallow
#|	fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21334 ms: Could not connect to server
#|	tried: 5 for unshallow
#|	remote: Enumerating objects: 2436, done.
#|	remote: Counting objects: 100% (1850/1850), done.
#|	remote: Compressing objects: 100% (435/435), done.
#|	remote: Total 1573 (delta 1162), reused 1381 (delta 1058), pack-reused 0 (from 0)
#|	Receiving objects: 100% (1573/1573), 1.58 MiB | 1.31 MiB/s, done.
#|	Resolving deltas: 100% (1162/1162), completed with 122 local objects.

#|	$ git_bike auto_clone https://github.com/LibreService/my_rime.git --mirror
#|	:: git cloning in shallow mode (i.e.: depth 1) ::
#|	Cloning into bare repository 'my_rime.git'...
#|	remote: Enumerating objects: 589, done.
#|	remote: Counting objects: 100% (589/589), done.
#|	remote: Compressing objects: 100% (433/433), done.
#|	remote: Total 589 (delta 272), reused 314 (delta 124), pack-reused 0 (from 0)
#|	Receiving objects: 100% (589/589), 63.24 MiB | 6.23 MiB/s, done.
#|	Resolving deltas: 100% (272/272), done.
#|	:: change workdir to `my_rime.git` from `/mnt/e/rimeweb.pwa-src` to unshallow fetch ::
#|	repochk: `/mnt/e/rimeweb.pwa-src/my_rime.git` is shallow repository ~ true
#|	remote: Enumerating objects: 2436, done.
#|	remote: Counting objects: 100% (1850/1850), done.
#|	remote: Compressing objects: 100% (435/435), done.
#|	remote: Total 1573 (delta 1162), reused 1381 (delta 1058), pack-reused 0 (from 0)
#|	Receiving objects: 100% (1573/1573), 1.58 MiB | 67.00 KiB/s, done.
#|	Resolving deltas: 100% (1162/1162), completed with 122 local objects.


