#!/usr/bin/env sh


git_bike () 
(
	_out_param () 
	(
		for x in "$@" ;
		do "${OUTER_FN:-echo}" "${x}" && :; done && 
		: ) && 
	
	take_param () 
	(
		head () ( echo "$1" && : ) && 
		tail () ( shift 1 && _out_param "$@" && : ) && 
		home () ( _out_param "$@" | head -n "$(($# - 1))" && : ) && 
		ende () ( shift "$(($# - 1))" && _out_param "$@" && : ) && 
		: :: && 
		"$@" && 
		: ) && 
	
	_lines_flatten () 
	(
		while read -r -- line ;
		do OUTER_FN="${FLATTER_FN:-echo}" "${@:-_out_param}" $line && :; done && 
		: ) && 
	
	#: git_bike auto_clone -- <remote-link> [<aim-path>]
	auto_clone () 
	(
		out_dir="$(
			while ! (2>&1 git clone --depth 1 --no-single-branch "$@") ;
			do 1>&2 echo tryed: clone "$((++try_clone))" && :; done | 
				tee >(cat 1>&2) | 
				head -n 1 | 
				_lines_flatten _out_param | 
				tail -n 1 | 
				cut -d "'" -f 2 && 
			: )" && 
		(
			echo : cd "${out_dir}" at "$PWD"  && cd "${out_dir}" && 
			while ! git fetch --unshallow --all ;
			do 1>&2 echo tryed: unshallow "$((++try_unshallow))" && :; done && 
			: ) && 
		: ) && 
	
	#: git_bike all_sync [<workspace>] [<workspace>] ...
	#:	workspace: means the prefix in full name of a repo
	#:	 like it in so many hubs -- <workspace>/<reponame>. In generally
	#:	 a 'workspace' can be the id-name of a(n) user or org.
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




