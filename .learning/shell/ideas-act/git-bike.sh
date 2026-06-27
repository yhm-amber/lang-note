#!/usr/bin/env bash


alias git-bike=git_bike && git_bike () 
(
	local __aliases_home__="$(alias)" && 
	
	_lang_tool () 
	(
		trim_line () 
		(
			while IFS="${SPACE_CHR:-${IFS}}" read -r -- _trimed ;
			do echo "${_trimed}" && :; done && 
			: ) && 
		
		help_alias () 
		(
			cat - | 
				SPACE_CHR="${IFS}" trim_line | 
				awk '{sub(/^alias /, ""); print}' | 
				while IFS== read -r -- a b ;
				do echo "- ${a}: means ${b}." && :; done | 
				awk '{print} BEGIN { print "sub command(s) here:" }'
				cat - && 
			#: only run if having args ...
			for _ in "$@" ;
			do 
				echo && 
				echo sub command: "$@" && 
				"${@}__helper__" && 
				:; 
			return $? ; done && 
			: ) && 
		
		alias_un () 
		(
			cat - | 
				SPACE_CHR="${IFS}" trim_line | 
				awk '{sub(/^alias /, ""); print}' | 
				while IFS== read -r -- a b ;
				do 
					_name="$(echo $a)" && 
					_body="$(eval echo "$b")" && 
					test "$_name" != "$_body" && 
					echo "unalias -- $_name ${SP:-;}" && 
					:; 
				done | 
				cat - && 
			: ) && 
		
		alias_fn () 
		(
			cat - | 
				SPACE_CHR="${IFS}" trim_line | 
				awk '{sub(/^alias /, ""); print}' | 
				while IFS== read -r -- a b ;
				do 
					_name="$(echo $a)" && 
					_body="$(eval echo "$b")" && 
					test "$_name" != "$_body" && 
					echo "function $_name () ( $_body "'"$@"'" ) ${SP:-&&} " && 
					:; 
				done | 
				cat - && 
			: ) && 
		
		alias_hp () 
		(
			cat - | 
				SPACE_CHR="${IFS}" trim_line | 
				awk '{sub(/^alias /, ""); print}' | 
				while IFS== read -r -- a b ;
				do 
					_name="$(echo $a)" && 
					_body="$(eval echo "$b")" && 
					test "$_name" != "$_body" && 
					echo "function ${_name}__helper__ () ( ${_body}__helper__ "'"$@"'" ) ${SP:-&&} " && 
					:; 
				done | 
				cat - && 
			: ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#.	__a__="$(alias)"
	#.	alias a=a b=b
	#.	alias | _set_tools diff "$__a__"
	#.	_set_tools diff "$__a__" <(alias)
	#:>	out: `alias a='a'` and `alias b='b'`
	_set_tools () 
	(
		diff () 
		(
			grep -x -F -f <( echo "$1" ) -v -- "${2:--}" && 
			: ) && 
		: :: && 
		"$@" && 
		: ) && 
	
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
		#. (echo true | _std_exec once) && echo a || echo x
		#. echo true | _std_exec once echo status is:
		once () 
		(
			read -r -- xs && 
			"$@" ${xs} && 
			: ) && 
		
		#. echo 'true' | _std_exec lines
		lines () 
		(
			while read -r -- line ;
			do "$@" $line && :; done && 
			: ) && 
		: :: && 
		"$@" && 
		: ) && 
	
	#. repo_chk shallow . && git fetch --unshallow --all
	alias repo-chk=repo_chk && repo_chk () 
	(
		local __aliases_home__="$(alias)" && 
		
		alias gitdir=gitdir && gitdir () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-inside-git-dir | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is inside gitdir ~' ) | 
				_std_exec once && 
			: ) && 
		
		alias worktree=worktree && worktree () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-inside-work-tree | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is inside worktree ~' ) | 
				_std_exec once && 
			: ) && 
		
		alias bare=bare && bare () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-bare-repository | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is bare repository ~' ) | 
				_std_exec once && 
			: ) && 
		
		alias shallow=shallow && shallow () 
		(
			cd "${*:-.}" && 
			git rev-parse --is-shallow-repository | 
				tee >( 1>&2 _std_exec once echo repochk: "\`$PWD\`" 'is shallow repository ~' ) | 
				_std_exec once && 
			: ) && 
		
		: :: && 
		
		alias sub-help=aliases && aliases () ( echo "$__aliases__" | _lang_tool "${@:-help_alias}" && : ) && 
		local __aliases_ende__="$(alias)" && 
		local __aliases__="$(echo "$__aliases_ende__" | _set_tools diff "$__aliases_home__")" && 
		eval "
			{ $(aliases cat | SP=';' _lang_tool alias_un) :; } && 
			$(aliases cat | SP='&&' _lang_tool alias_fn)
			$(aliases cat | SP='&&' _lang_tool alias_hp)
			: " && 
		help () ( sub-help help_alias "$@" ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#. ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | LINES_MAX=2 _wait_outs    #> out 1, ::2 after 10 sec. waites.
	#. ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | LINES_MAX=2 _wait_outs :: #> out ::2, ::3 after 10 sec. waites.
	_wait_outs() 
	(
		PAT="$*" awk -v max="${LINES_MAX:-6}" -- ' 
		BEGIN { pat = ENVIRON["PAT"] }
		$0 ~ pat { if (c < max) { a[++c] = $0 } else { next } }
		END { for (i = 1; i < 1 + c; i++) print a[i] }' && 
		: )
	
	#: git-bike auto-clone -- <remote-link> [<aim-path>]
	auto_clone__helper__ () 
	(
		echo && 
		echo 'Usage:' && 
		echo $'\t' 'git-bike auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]' && 
		echo && 
		echo 'This tool is for when you having a bad internet to your' && 
		echo ' remote repo. It will making a depth=1 shallow clone at the' && 
		echo ' first and then unshallow it, also at the end update it once' && 
		echo ' to make your local repo sync the newest records as far as it could.' && 
		echo ' All of the downloading works can auto-retry while it failed.' && 
		echo && 
		echo 'Demo:' && 
		echo '- git-bike auto-clone https://github.com/LibreService/my_rime.git --mirror' && 
		echo '- git-bike auto-clone https://github.com/gurecn/YuyanIme.git --mirror' && 
		echo '- git-bike auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git' && 
		echo '- git-bike auto-clone --mirror -- https://github.com/crynta/terax-ai.git' && 
		echo '- git-bike auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass' && 
		echo && 
		echo 'See help:' && 
		echo '- git-bike help auto-clone' && 
		echo '- git-bike help ac' && 
		echo && 
		: ) && 
	alias ac=auto_clone auto-clone=auto_clone && auto_clone () 
	(
		echo :: git cloning in shallow mode '(i.e.: depth 1)' :: && 
		while ! ( git clone --progress --depth 1 --no-single-branch "$@" 2>&1 && : ) ;
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
				(
					echo :: unshallowing in "\`$PWD\`" :: && 
					repo_chk shallow . && 
					while ! ( git fetch --unshallow --all && : ) ;
					do 1>&2 echo tried: "$((++try_unshallow))" for unshallow && :; done && 
					: ) && 
				(
					echo :: updating in "\`$PWD\`" :: && 
					while ! ( git remote update && : ) ;
					do 1>&2 echo tried: "$((++try_update))" for remote update && :; done && 
					: ) && 
				echo :: done for repo "\`${out_dir}\`". :: && 
				: ) && 
			break ; done
		: ) && 
	
	alias bp=bare_play bare-play=bare_play && bare_play () 
	(
		repo_chk bare . || return 4 ;
		
		: "Bare dir in a special named dir like 'name.comments-src' then:" && 
		: "- path of worktree dir from branch like 'name.comments-src/tree/<branch-name>'" && 
		: "- path of worktree dir from tag like 'name.comments-src/tags/<tag-name>'" && 
		
		local __aliases_home__="$(alias)" && 
		
		#. git-bike bare-play up
		#. git-bike bare-play up origin
		#. git-bike bare-play up github
		#. git-bike bare-play up disroot
		update__helper__ () 
		(
			echo && 
			echo 'Using for update bare repo. It will detach worktree dir(s)' && 
			echo ' which by branch(es), then remote update in automatically retrying,' && 
			echo ' then checkout these worktree dir(s) backing to their branch(es)' && 
			echo && 
			echo "Bare dir here MUST in a special named dir like: 'name.comments-src'. And:" && 
			echo "- path of worktree dir from branch must be like: 'name.comments-src/tree/<branch-name>'" && 
			echo "- path of worktree dir from tag must be like: 'name.comments-src/tags/<tag-name>'" && 
			echo && 
			echo 'Demo:' && 
			echo '- git-bike bare-play up' && 
			echo '- git-bike bare-play up origin' && 
			echo '- git-bike bare-play up github' && 
			echo '- git-bike bare-play up disroot' && 
			echo && 
			echo 'See help:' && 
			echo '- git-bike help bare-play update' && 
			echo '- git-bike help bare-play up' && 
			echo '- git-bike help bp up' && 
			echo '- git-bike bp help up' && 
			echo && 
			: ) && 
		alias up=update && update () 
		(
			find -- ../tree -maxdepth 1 -mindepth 1 -type d | while read -r -- treepath ;
			do 
				echo :: executing: '`checkout --detach`' in "'${treepath}'" :: && 
				(
					cd "${treepath}" && 
					git checkout --detach && 
					: ) && 
				(1>&2 echo upper: detached "${treepath}") && 
				:; 
			done && 
			
			echo :: executing: remote update "$@" :: && 
			while ! ( git remote update "$@" && : ) ;
			do 1>&2 echo tried: "$((++try_update))" for remote update && :; done && 
			(
				1>&2 echo upper: updated in "'.../$(
					read -r -- pwd < <(echo "$PWD") && 
					echo "$(dirname "$pwd" | xargs basename)/$(basename "$pwd")" && 
					: )'" for remote'(s)' $@ && 
				: ) && 
			
			find -- ../tree -maxdepth 1 -mindepth 1 -type d | while read -r -- treepath ; 
			do 
				_branch="$(basename "${treepath}")" && 
				echo :: executing: '`checkout '"$_branch"'`' in "'${treepath}'" :: && 
				(
					cd -- "${treepath}" && 
					git checkout "$_branch" && 
					: ) && 
				(1>&2 echo upper: checkouted "${treepath}" as "$_branch") && 
				:; 
			done && 
			: ) && 
		
		#. git-bike bare-play worktree add tree master
		#. git-bike bare-play worktree rm tree master
		#. git-bike bare-play worktree add tags v1.0.1
		#. git-bike bare-play worktree rm tags v1.0.1
		worktree__helper__ () 
		(
			echo && 
			echo 'Using for create/delete worktree(s) of bare repo. It will' && 
			echo ' search from branches/tags then run worktree add/remove to those object(s)' && 
			echo && 
			echo "Bare dir here MUST in a special named dir like: 'name.comments-src', then:" && 
			echo "- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'" && 
			echo "- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'" && 
			echo && 
			echo 'Demo:' && 
			echo '- git-bike bare-play worktree add tree master' && 
			echo '- git-bike bare-play worktree rm tree master' && 
			echo '- git-bike bare-play worktree add tags v1.0.1' && 
			echo '- git-bike bare-play worktree rm tags v1.0.1' && 
			echo '- git-bike bare-play wt a tags v1.16.1' && 
			echo '- git-bike bare-play wt a tree master' && 
			echo && 
			echo 'See help:' && 
			echo '- git-bike help bare-play worktree' && 
			echo '- git-bike help bare-play wt' && 
			echo '- git-bike help bp wt' && 
			echo '- git-bike bp help wt' && 
			echo && 
			: ) && 
		alias wt=worktree && worktree () 
		(
			case "$1" 
			in 
				(add|a|create|c|load|+)   __cmd_a__=add     __n_ctrl__=     && shift ;;
				(rm|remove|del|d|drop|-)  __cmd_a__=remove  __n_ctrl__=' '  && shift ;;
				(_) 1>&2 echo Unknown sub cmd a: "'$1'" && return 16 ;;
			esac && 
			
			case "$1" 
			in 
				(tags)  __cmd_b__=tag     __dir__=tags  __called__=tags      && shift ;;
				(tree)  __cmd_b__=branch  __dir__=tree  __called__=branches  && shift ;;
				(_) 1>&2 echo Unknown sub cmd b: "'$1'" && return 16 ;;
			esac && 
			
			return $( 
			shopt -u -q -- extglob ;
			{
				_name_input="$1" && shift && 
				{
					git "${__cmd_b__}" --format='%(refname:short)' --no-column --contains "$_name_input" || 
					echo $? 1>&6 ;
					:; 
				} | 
					tee >(awk -- '{ print "-",$0 } BEGIN { print "Contained '"${__called__}"': " }' 1>&2) | 
					{
						while read -r -- _name ;
						do 
							echo :: executing: worktree "${__cmd_a__}" "../${__dir__}/$_name" ${__n_ctrl__:-${_name}} "$@" :: && 
							git worktree "${__cmd_a__}" ../"${__dir__}"/$_name ${__n_ctrl__:-${_name}} "$@" && 
							ls ../"${__dir__}" && 
							:; 
						done || 
						echo $? 1>&6 ;
					} | 
					cat - 1>&7 && 
					:;
			} 6>&1 && : ) && : ) 7>&1 && 
		
		: :: && 
		
		alias sub-help=aliases && aliases () ( echo "$__aliases__" | _lang_tool "${@:-help_alias}" && : ) && 
		local __aliases_ende__="$(alias)" && 
		local __aliases__="$(echo "$__aliases_ende__" | _set_tools diff "$__aliases_home__")" && 
		eval "
			{ $(aliases cat | SP=';' _lang_tool alias_un) :; } && 
			$(aliases cat | SP='&&' _lang_tool alias_fn)
			$(aliases cat | SP='&&' _lang_tool alias_hp)
			: " && 
		help () ( sub-help help_alias "$@" ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#: git_bike all_sync [<workspace>] [<workspace>] ...
	#::	workspace: means the prefix in full name of a repo
	#..	 like it in so many hubs -- <workspace>/<reponame>. In generally
	#;;	 a 'workspace' can be the id-name of a(n) user or org.
	alias all-sync=all_sync && all_sync () 
	(
		_out_param "${@:-.}" | _all_sync && 
		: ) && 
	
	_all_sync () 
	(
		while read -r -- workspace ;
		do 
			ls -1 -d -- "${workspace}/*" | while read -r -- gitpath ;
			do all_pull "${gitpath}" && all_push "${gitpath}" && :; done && 
			:; 
		done && 
		: ) && 
	
	
	#: git_bike all_push [<git-dir>] [<git-dir>] ...
	alias all-push=all_push && all_push () 
	(
		echo :: pushing origin to all remotes in: "${@:-.}" :: && 
		_out_param "${@:-.}" | _all_push && 
		: ) && 
	
	_all_push () 
	(
		: Push origin to all remotes.
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
	alias all-pull=all_pull && all_pull () 
	(
		echo :: pulling from origin and all remotes in: "${@:-.}" :: && 
		_out_param "${@:-.}" | _all_pull && 
		: ) && 
	
	_all_pull () 
	(
		: Pull from origin and all remotes.
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
	
	
	
	: :: && 
	
	alias sub-help=aliases && aliases () ( echo "$__aliases__" | _lang_tool "${@:-help_alias}" && : ) && 
	local __aliases_ende__="$(alias)" && 
	local __aliases__="$(echo "$__aliases_ende__" | _set_tools diff "$__aliases_home__")" && 
	eval "
		{ $(aliases cat | SP=';' _lang_tool alias_un) :; } && 
		$(aliases cat | SP='&&' _lang_tool alias_fn)
		$(aliases cat | SP='&&' _lang_tool alias_hp)
		: " && 
	help () ( sub-help help_alias "$@" ) && 
	
	: :: && 
	
	"$@" && 
	: ) && 



# : \
git_bike "$@" && :




###	alias to fn must having `function` mark,
###	 or if already having `alias foo-a='foo_a'`,
###	 then the define like `foo-a () ( foo_a )` could
###	 immediately become `foo_a () ( foo_a )`,
###	 and that must making problem(s);
###	and if define like `function foo-a () ( foo_a )`, the `foo-a` in it
###	 won't be replaced implicitly, because the
###	 implicitly-replacement of the alias only effected on
###	 the first word in code.
###	see: https://stackoverflow.com/questions/79966887/how-could-this-dash-style-named-function-makes-infinity-calling-in-bash



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
#|	:: updating in `/mnt/e/rimeweb.pwa-src/my_rime.git` ::
#|	:: done for repo `my_rime.git`. ::

#|	$ git-bike auto-clone https://github.com/gurecn/YuyanIme.git --mirror
#|	:: git cloning in shallow mode (i.e.: depth 1) ::
#|	Cloning into bare repository 'YuyanIme.git'...
#|	remote: Enumerating objects: 295, done.
#|	remote: Counting objects: 100% (295/295), done.
#|	remote: Compressing objects: 100% (220/220), done.
#|	remote: Total 295 (delta 121), reused 210 (delta 45), pack-reused 0 (from 0)
#|	Receiving objects: 100% (295/295), 1.47 MiB | 18.00 KiB/s, done.
#|	Resolving deltas: 100% (121/121), done.
#|	:: change workdir to `YuyanIme.git` from `/mnt/e/yuyanime.hanzi-src` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` ::
#|	repochk: `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` is shallow repository ~ true
#|	remote: Enumerating objects: 1514, done.
#|	remote: Counting objects: 100% (1429/1429), done.
#|	remote: Compressing objects: 100% (777/777), done.
#|	Rremote: Total 1386 (delta 707), reused 1236 (delta 601), pack-reused 0 (from 0)
#|	Receiving objects: 100% (1386/1386), 169.91 KiB | 135.00 KiB/s, done.
#|	Resolving deltas: 100% (707/707), completed with 21 local objects.
#|	:: updating in `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` ::
#|	:: done for repo `YuyanIme.git`. ::

#|	$ git-bike bare-play up
#|	repochk: `/mnt/e/rufus.usbfldr-src/rufus.git` is bare repository ~ true
#|	:: executing: `checkout --detach` in '../tree/master' ::
#|	HEAD is now at eedeaea7 [misc] fix multiple small issues
#|	upper: detached ../tree/master
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
#|	tried: 1 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
#|	tried: 2 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21298 ms: Could not connect to server
#|	tried: 3 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
#|	tried: 4 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21361 ms: Could not connect to server
#|	tried: 5 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21605 ms: Could not connect to server
#|	tried: 6 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
#|	tried: 7 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21470 ms: Could not connect to server
#|	tried: 8 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21588 ms: Could not connect to server
#|	tried: 9 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21308 ms: Could not connect to server
#|	tried: 10 for remote update
#|	fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
#|	3 after 21336 ms: Could not connect to server
#|	tried: 11 for remote update
#|	upper: updated in '.../rufus.usbfldr-src/rufus.git' for remote(s)
#|	:: executing: `checkout master` in '../tree/master' ::
#|	Switched to branch 'master'
#|	upper: checkouted ../tree/master as master


#|	$ git-bike help ac
#|	sub command(s) here:
#|	- ac: means 'auto_clone'.
#|	- all-pull: means 'all_pull'.
#|	- all-push: means 'all_push'.
#|	- all-sync: means 'all_sync'.
#|	- auto-clone: means 'auto_clone'.
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- repo-chk: means 'repo_chk'.
#|	- sub-help: means 'aliases'.
#|	
#|	sub command: ac
#|	
#|	Usage:
#|		 git-bike auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]
#|	
#|	This tool is for when you having a bad internet to your
#|	 remote repo. It will making a depth=1 shallow clone at the
#|	 first and then unshallow it, also at the end update it once
#|	 to make your local repo sync the newest records as far as it could.
#|	 All of the downloading works can auto-retry while it failed.
#|	
#|	Demo:
#|	- git-bike auto-clone https://github.com/LibreService/my_rime.git --mirror
#|	- git-bike auto-clone https://github.com/gurecn/YuyanIme.git --mirror
#|	- git-bike auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git
#|	- git-bike auto-clone --mirror -- https://github.com/crynta/terax-ai.git
#|	- git-bike auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass
#|	
#|	See help:
#|	- git-bike help auto-clone
#|	- git-bike help ac
#|	

#|	$ git-bike help bare-play up
#|	sub command(s) here:
#|	- ac: means 'auto_clone'.
#|	- all-pull: means 'all_pull'.
#|	- all-push: means 'all_push'.
#|	- all-sync: means 'all_sync'.
#|	- auto-clone: means 'auto_clone'.
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- repo-chk: means 'repo_chk'.
#|	- sub-help: means 'aliases'.
#|	
#|	sub command: bare-play up
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	
#|	Using for update bare repo. It will detach worktree dir(s)
#|	 which by branch(es), then remote update in automatically retrying,
#|	 then checkout these worktree dir(s) backing to their branch(es)
#|	
#|	Bare dir here MUST in a special named dir like: 'name.comments-src'. And:
#|	- path of worktree dir from branch must be like: 'name.comments-src/tree/<branch-name>'
#|	- path of worktree dir from tag must be like: 'name.comments-src/tags/<tag-name>'
#|	
#|	Demo:
#|	- git-bike bare-play up
#|	- git-bike bare-play up origin
#|	- git-bike bare-play up github
#|	- git-bike bare-play up disroot
#|	
#|	See help:
#|	- git-bike help bare-play update
#|	- git-bike help bare-play up
#|	- git-bike help bp up
#|	- git-bike bp help up
#|	

#|	$ git-bike help bp up
#|	sub command(s) here:
#|	- ac: means 'auto_clone'.
#|	- all-pull: means 'all_pull'.
#|	- all-push: means 'all_push'.
#|	- all-sync: means 'all_sync'.
#|	- auto-clone: means 'auto_clone'.
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- repo-chk: means 'repo_chk'.
#|	- sub-help: means 'aliases'.
#|	
#|	sub command: bp up
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	
#|	Using for update bare repo. It will detach worktree dir(s)
#|	 which by branch(es), then remote update in automatically retrying,
#|	 then checkout these worktree dir(s) backing to their branch(es)
#|	
#|	Bare dir here MUST in a special named dir like: 'name.comments-src'. And:
#|	- path of worktree dir from branch must be like: 'name.comments-src/tree/<branch-name>'
#|	- path of worktree dir from tag must be like: 'name.comments-src/tags/<tag-name>'
#|	
#|	Demo:
#|	- git-bike bare-play up
#|	- git-bike bare-play up origin
#|	- git-bike bare-play up github
#|	- git-bike bare-play up disroot
#|	
#|	See help:
#|	- git-bike help bare-play update
#|	- git-bike help bare-play up
#|	- git-bike help bp up
#|	- git-bike bp help up
#|	

#| $ git-bike help bp wt
#| sub command(s) here:
#| - ac: means 'auto_clone'.
#| - all-pull: means 'all_pull'.
#| - all-push: means 'all_push'.
#| - all-sync: means 'all_sync'.
#| - auto-clone: means 'auto_clone'.
#| - bare-play: means 'bare_play'.
#| - bp: means 'bare_play'.
#| - repo-chk: means 'repo_chk'.
#| - sub-help: means 'aliases'.
#| 
#| sub command: bp wt
#| repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#| 
#| Using for create/delete worktree(s) of bare repo. It will
#|  search from branches/tags then run worktree add/remove to those object(s)
#| 
#| Bare dir here MUST in a special named dir like: 'name.comments-src', then:
#| - the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
#| - the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'
#| 
#| Demo:
#| - git-bike bare-play worktree add tree master
#| - git-bike bare-play worktree rm tree master
#| - git-bike bare-play worktree add tags v1.0.1
#| - git-bike bare-play worktree rm tags v1.0.1
#| - git-bike bare-play wt a tags v1.16.1
#| - git-bike bare-play wt a tree master
#| 
#| See help:
#| - git-bike help bare-play worktree
#| - git-bike help bare-play wt
#|	- git-bike help bp wt
#|	- git-bike bp help wt
#| 

#|	$ git-bike bp wt a tags v1.61.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	error: malformed object name v1.61.1
#|	$ echo $?
#|	129

#|	$ git-bike bp wt a tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	- v1.16.1
#|	- v1.17.0-rc.1
#|	- v1.17.0-rc.2
#|	:: executing: worktree add ../tags/v1.16.1 v1.16.1 ::
#|	Preparing worktree (detached HEAD f4bb1ded)
#|	Updating files: 100% (652/652), done.
#|	HEAD is now at f4bb1ded Tag v1.16.1 (#3304)
#|	v1.16.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.1 v1.17.0-rc.1 ::
#|	Preparing worktree (detached HEAD bacb2454)
#|	Updating files: 100% (687/687), done.
#|	HEAD is now at bacb2454 Tag v1.17.0-rc.1
#|	v1.16.1/
#|	v1.17.0-rc.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.2 v1.17.0-rc.2 ::
#|	Preparing worktree (detached HEAD d28b405b)
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at d28b405b Tag v1.17.0-rc.2
#|	v1.16.1/
#|	v1.17.0-rc.1/
#|	v1.17.0-rc.2/
#|	$ git-bike bp wt a tree master
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained branches:
#|	- master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at f25fc7b4 fix: restore clip flag through fuzzy search in show command (#3466)
#|	master/

#|	$ git-bike bp help wt
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	sub command(s) here:
#|	- sub-help: means 'aliases'.
#|	- up: means 'update'.
#|	- wt: means 'worktree'.
#|	
#|	sub command: wt
#|	
#|	Using for create/delete worktree(s) of bare repo. It will
#|	 search from branches/tags then run worktree add/remove to those object(s)
#|	
#|	Bare dir here MUST in a special named dir like: 'name.comments-src', then:
#|	- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
#|	- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'
#|	
#|	Demo:
#|	- git-bike bare-play worktree add tree master
#|	- git-bike bare-play worktree rm tree master
#|	- git-bike bare-play worktree add tags v1.0.1
#|	- git-bike bare-play worktree rm tags v1.0.1
#|	- git-bike bare-play wt a tags v1.16.1
#|	- git-bike bare-play wt a tree master
#|	
#|	See help:
#|	- git-bike help bare-play worktree
#|	- git-bike help bare-play wt
#|	- git-bike help bp wt
#|	- git-bike bp help wt
#|	



