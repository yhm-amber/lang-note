#!/usr/bin/env bash

libs () ( Libs "$@" ) && 
Libs () 
{
	subs () 
	(
		lang () ( _lang_tool "$@" && : ) && 
		frames () ( PKG_SUBS="${PKG_SUBSLANG:-${PKG_SUBS:-subs lang}}" _frame_subs "$@" && : ) && 
		kwargs () ( _frame_kwargs "$@" && : ) && 
		: :: && 
		Subs "$@" && 
		: ) && 
	Subs () 
	{
		#.	__a__="$(alias)"
		#.	alias a=a b=b
		#.	alias | _set_tool diff "$__a__"
		#.	_set_tool diff "$__a__" <(alias)
		#:>	out: `alias a='a'` and `alias b='b'`
		_set_tool () 
		(
			diff () 
			(
				grep -x -F -f <( echo "$1" ) -v -- "${2:--}" && 
				: ) && 
			: :: && 
			"$@" && 
			: ) && 
		
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
		
		
		#. eval "$(_frame_subs codes_head)" && 
		#. eval "$(_frame_subs codes_tail)" && 
		_frame_subs () 
		(
			PKG_SUBS="${PKG_SUBSLANG:-${PKG_SUBS:-Subs _lang_tool}}" && 
			NAMEMARK_MORE="${NAMEMARK_MORE:-${MARK_MORE:-}}" && 
			
			: 亓可别名 去别承体 && 
			: 亓可助令 略别详体 && 
			
			codes_head () 
			(
				echo '
					{
						! { &>/dev/null local ; } || 
						{
							local __aliases_home__'"$NAMEMARK_MORE"' ;
							local __aliases_ende__'"$NAMEMARK_MORE"' ;
							local __aliases__'"$NAMEMARK_MORE"' ;
						} ;
						:; 
					} && 
					__aliases_home__'"$NAMEMARK_MORE"'="$(alias)" && 
					: ' && 
				: ) && 
			codes_tail () 
			(
				echo '
					alias sub-help=aliases && aliases () ( echo "$__aliases__'"$NAMEMARK_MORE"'" | '"${PKG_SUBS}"' "${@:-help_alias}" && : ) && 
					__aliases_ende__'"$NAMEMARK_MORE"'="$(alias)" && 
					__aliases__'"$NAMEMARK_MORE"'="$(
						echo "$__aliases_ende__'"$NAMEMARK_MORE"'" | 
							'"${PKG_SUBS}"' _set_tool diff "$__aliases_home__'"$NAMEMARK_MORE"'" | 
							cat -)" && 
					eval "
						{ $(aliases cat | SP='"';'"' '"${PKG_SUBS}"' alias_un) :; } && 
						$(aliases cat | SP='"'&&'"' '"${PKG_SUBS}"' alias_fn)
						$(aliases cat | SP='"'&&'"' '"${PKG_SUBS}"' alias_hp)
						: " && 
					help () ( sub-help help_alias "$@" ) && 
					: ' && 
				: ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		#. eval "$(_frame_kwargs as_bool SHOW_HINTS y)" && 
		#. eval "$(_frame_kwargs as_bool IS_BARE '')" && 
		_frame_kwargs () 
		(
			as_bool () 
			(
				: 其音嵌之 其出用之 && 
				local NAME_EMBEDDED="${1:-${NAME_EMBEDDED:-}}" && 
				local BOOL_DEFAULT="${2:-${BOOL_DEFAULT:-}}" && 
				echo '
					case "$(echo "${'"$NAME_EMBEDDED"':-'"$BOOL_DEFAULT"'}" | tr '"'"'[:lower:]'"'"' '"'"'[:upper:]'"'"')" 
					in 
						(Y|YES|T|TRUE|O|ON|OK) local __'"$NAME_EMBEDDED"'__=true ;; 
						(N|NO|F|FALSE|X|OFF|NOT) local __'"$NAME_EMBEDDED"'__=false ;; 
						(_) 1>&2 echo unknown kwargs '"$NAME_EMBEDDED"': "'"'"'${'"$NAME_EMBEDDED"'}'"'"'": only support true/false. ; return 13 ;; 
					esac && 
					: ' && 
				: ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		: :: && 
		"$@" && 
		:;
	} && 
	
	_cmnd_tools () 
	(
		_returns () ( return $1 ) && 
		_booled_returns () ( ! _returns $1 ) && 
		
		_std_exec () 
		(
			#. (echo true | _cmnd_tools _std_exec once) && echo a || echo x
			#. echo true | _cmnd_tools _std_exec once echo status is:
			once () 
			(
				read -r -- xs && 
				"$@" ${xs} && 
				: ) && 
			
			#. echo 'true' | _cmnd_tools _std_exec lines
			lines () 
			(
				while read -r -- line ;
				do "$@" $line && :; done && 
				: ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		#. eval "$(FD_TTY=9 _cmnd_tools _retry_asking init_codes)" && 
		#. eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && 
		_retry_asking () 
		(
			PKG_ASKING="${PKG_ASKING:-_cmnd_tools _retry_asking}" && 
			FD_TTY="${FD_TTY:-${TTY_FD:-9}}" && 
			
			: 其尝适询 && 
			__chunk_asker () 
			(
				echo '
					0<&'"$FD_TTY"' read -p ":: try-asking: How many times you want to retry then ? :: " -r -- _rests_tryasking && 
					echo :: try-asking: you inputed "'"'"'$_rests_tryasking'"'"'" as "$((_rests_tryasking--))". && 
					: ' && 
				: ) && 
			__chunk_verifier () 
			(
				echo '
					echo :: try-asking: rested times of push trying: "$((_rests_tryasking))". && 
					if _cmnd_tools _booled_returns "$((_rests_tryasking < 0))" ; 
						then echo :: try-asking: Break. ; break ;
						else echo :: try-asking: Then: "$((--_rests_tryasking))" ;
					fi && 
					: ' && 
				: ) && 
			
			init_codes () 
			(
				echo '
					local _rests_tryasking="${MAXTRY_ASKING:-${ASKING_MAXTRY:-0}}" && 
					: ' && 
				: ) && 
			body_codes () 
			(
				echo '
					if _cmnd_tools _booled_returns "$((_rests_tryasking == 0))" ; 
						then eval "$('"${PKG_ASKING}"' __chunk_asker)" ; eval "$('"${PKG_ASKING}"' __chunk_verifier)" ;
						else eval "$('"${PKG_ASKING}"' __chunk_verifier)" ;
					fi && : ' && 
				: ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	_param_tools () 
	(
		params_out () 
		(
			for x in "$@" ;
			do "${OUTER_FN:-echo}" "${x}" && :; done && 
			: ) && 
		
		params_take () 
		(
			head () ( echo "$1" && : ) && 
			tail () ( shift 1 && params_out "$@" && : ) && 
			home () ( params_out "$@" | head -n "$(($# - 1))" && : ) && 
			ende () ( shift "$(($# - 1))" && params_out "$@" && : ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		flatten_line () 
		(
			while read -r -- line ;
			do OUTER_FN="${FLATTER_FN:-echo}" "${@:-params_out}" $line && :; done && 
			: ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	
	_ctrl_tools () 
	(
		#. ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | ELLIPSIS_SHOW=y LINES_MAX=2 _ctrl_tools _wait_outs    #> out 1, ::2, ... after 10 sec. waites.
		#. ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | ELLIPSIS_SHOW=y LINES_MAX=2 _ctrl_tools _wait_outs :: #> out ::2, ::3, ... after 10 sec. waites.
		#. ( echo 1 ; echo ::2 ; echo ::3 ; echo ::4 ; echo 5 ; sleep 10 ) | ELLIPSIS_SHOW=x LINES_MAX=2 _ctrl_tools _wait_outs :: #> out ::2, ::3 after 10 sec. waites.
		_wait_outs () 
		(
			PAT="$*" ELLIPSIS_SHOW="${ELLIPSIS_SHOW:-Yes}" awk -v max="${LINES_MAX:-6}" -- ' 
			BEGIN { pat = ENVIRON["PAT"] ; ell_show = toupper(ENVIRON["ELLIPSIS_SHOW"]) ~ /^(Y|YES|T|TRUE)$/ }
			$0 ~ pat { if (c < max) { a[++c] = $0 } else if (ell_show && c == max) { a[++c] = "..." } else { next } }
			END { for (i = 1; i < 1 + c; i++) print a[i] }' && 
			: ) && 
		
		#. ( echo a ; echo b ; sleep 3 ; echo c ) | FD_TEE=2 _ctrl_tools _wait_tee awk -- '{ print "xx", $0 } BEGIN { print "ABC:" }'
		_wait_tee () 
		(
			echo "$( { 1>&"${FD_TEE:-${TEE_FD:-${TEETO_FD:-2}}}" echo "$( { tee >(1>&3 "$@") 1>&4 ; } 3>&1 )" ; } 4>&1 )" && 
			: ) && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	: :: && 
	"$@" && 
	:;
} && 


eval "$(MARK_MORE=GIT_BENCH PKG_SUBS='libs subs lang' libs subs frames codes_head)" && 

git_aide__helper__ () 
(
	echo && 
	echo 'Git Aide Player (also names 'git bench/bike') is an assistant for git to give levers/wheels with its helpdocs.' && 
	echo ' It'"'"'s also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names' && 
	echo ' as function with a helpdocs feature supported.' && 
	echo && 
	echo 'See help:' && 
	echo '- git-aide help' && 
	echo '- git-aide help git-aide' && 
	echo '- git-aide help git-bench' && 
	echo '- git-aide help git-bike' && 
	echo '- git-aide help gp' && 
	echo '- help git-aide' && 
	echo '- help git-bench' && 
	echo '- help git-bike' && 
	echo '- help gp' && 
	echo && 
	: ) && 
alias gp=git_player git-bike=git_aide git-bench=git_aide git-aide=git_aide git-player=git_player git_player=git_aide && git_aide () 
(
	# Libs Subs : && 
	Libs : && 
	
	eval "$(subs frames codes_head)" && 
	
	#. repo_chk shallow . && git fetch --unshallow --all
	#. (repo_chk shallow . echo | _cmnd_tools _std_exec once) && git fetch --unshallow --all
	repo_chk__helper__ () 
	(
		echo && 
		echo '(TODO...)' && 
		echo && 
		: ) && 
	alias rc=repo_chk repo-check=repo_chk repo-chk=repo_chk && repo_chk () 
	(
		eval "$(subs frames codes_head)" && 
		
		eval "$(subs kwargs as_bool SHOW_HINTS yes)" && 
		
		alias gitdir=gitdir && gitdir () 
		(
			{ cd "${1:-.}" && shift 1 ; } && 
			git rev-parse --is-inside-git-dir | 
				tee >( "${__SHOW_HINTS__}" && 1>&2 _cmnd_tools _std_exec once echo repochk: "\`$PWD\`" 'is inside gitdir ~' ) | 
				_cmnd_tools _std_exec once "$@" && 
			: ) && 
		
		alias worktree=worktree && worktree () 
		(
			{ cd "${1:-.}" && shift 1 ; } && 
			git rev-parse --is-inside-work-tree | 
				tee >( "${__SHOW_HINTS__}" && 1>&2 _cmnd_tools _std_exec once echo repochk: "\`$PWD\`" 'is inside worktree ~' ) | 
				_cmnd_tools _std_exec once "$@" && 
			: ) && 
		
		alias bare=bare && bare () 
		(
			{ cd "${1:-.}" && shift 1 ; } && 
			git rev-parse --is-bare-repository | 
				tee >( "${__SHOW_HINTS__}" && 1>&2 _cmnd_tools _std_exec once echo repochk: "\`$PWD\`" 'is bare repository ~' ) | 
				_cmnd_tools _std_exec once "$@" && 
			: ) && 
		
		alias shallow=shallow && shallow () 
		(
			{ cd "${1:-.}" && shift 1 ; } && 
			git rev-parse --is-shallow-repository | 
				tee >( "${__SHOW_HINTS__}" && 1>&2 _cmnd_tools _std_exec once echo repochk: "\`$PWD\`" 'is shallow repository ~' ) | 
				_cmnd_tools _std_exec once "$@" && 
			: ) && 
		
		: :: && 
		
		eval "$(subs frames codes_tail)" && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#: ...
	clone_play__helper__ () 
	(
		echo && 
		echo '(TODO...)' && 
		echo && 
		: ) && 
	alias cp=clone_play clone-play=clone_play && clone_play () 
	(
		eval "$(subs frames codes_head)" && 
		
		#: OPTS_CLONE='<git-clone-options>' git-aide cp multi-clone <working-dir> [<local-dir>]:<remote-link> [[<local-dir>]:<remote-link> ...]
		#. OPTS_CLONE=--bare git-aide cp m . mabin.sp-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git pure.lexi-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git
		multi_clone__helper__ () 
		(
			echo && 
			echo '(TODO...)' && 
			echo && 
			: ) && 
		alias m=multi_clone mc=multi_clone multi-clone=multi_clone && multi_clone () 
		(
			local working_dir="$1" && shift && 
			_param_tools params_out "$@" | 
				WORKING_PATH="${working_dir}" OPTS_CLONE="${OPTS_CLONE}" _multi_clone | 
				cat - && 
			: ) && 
		_multi_clone () 
		(
			cd "${WORKING_PATH:-.}" && 
			while IFS=: read -r -- landing_path remote_link ;
			do 
				echo :: executing: '`'.aide cp auto-clone ${OPTS_CLONE} -- "'${remote_link}'" ${landing_path}'`' in "'${PWD}'" :: && 
				auto_clone ${OPTS_CLONE} -- "${remote_link}" ${landing_path} && 
				:; 
			done && 
			: ) && 
		
		#: git-aide cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]
		auto_clone__helper__ () 
		(
			echo && 
			echo 'Usage:' && 
			echo $'\t' 'git-aide cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]' && 
			echo && 
			echo 'This tool is for when you having a bad internet to your' && 
			echo ' remote repo. It will making a depth=1 shallow clone at the' && 
			echo ' first and then unshallow it, also at the end update it once' && 
			echo ' to make your local repo sync the newest records as far as it could.' && 
			echo ' All of the downloading works can auto-retry while it failed.' && 
			echo && 
			echo 'Demo:' && 
			echo '- git-aide cp auto-clone https://github.com/LibreService/my_rime.git --mirror' && 
			echo '- git-aide cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror' && 
			echo '- git-aide cp auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git' && 
			echo '- git-aide cp auto-clone --mirror -- https://github.com/crynta/terax-ai.git' && 
			echo '- git-aide cp auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass' && 
			echo && 
			echo 'See help:' && 
			echo '- git-aide help cp auto-clone' && 
			echo '- git-aide help cp ac' && 
			echo '- git-aide cp help ac' && 
			echo && 
			: ) && 
		alias a=auto_clone ac=auto_clone auto-clone=auto_clone && auto_clone () 
		(
			echo :: git cloning in shallow '(depth 1)' mode :: && 
			while ! ( git clone --progress --depth 1 --no-single-branch "$@" 2>&1 && : ) ;
			do 1>&2 echo tried: "$((++try_clone))" for clone && :; done | 
				tee >(cat 1>&2) | 
				#::	will only out 3 lines (which has "'")
				#;;	 after keep waiting until EOF
				ELLIPSIS_SHOW=x LINES_MAX=3 _ctrl_tools _wait_outs "'" | 
				#::	Just a head -n 1 alternative
				#;;	 but with no SIGPIPE to avoid pipe-broken.
				ELLIPSIS_SHOW=x LINES_MAX=1 _ctrl_tools _wait_outs 'Cloning into' | 
				_param_tools flatten_line params_out | 
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
						SHOW_MORE_HINTS=y sync_play base_upgrade . && 
						# while ! ( git remote update && : ) ;
						# do 1>&2 echo tried: "$((++try_update))" for remote update && :; done && 
						: ) && 
					echo :: done for repo "\`${out_dir}\`". :: && 
					: ) && 
				break ; done
			: ) && 
		
		: :: && 
		
		eval "$(subs frames codes_tail)" && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#: ...
	bare_play__helper__ () 
	(
		echo && 
		echo '(TODO...)' && 
		echo && 
		: ) && 
	alias bp=bare_play bare-play=bare_play && bare_play () 
	(
		repo_chk bare . || return 4 ;
		
		: "Bare dir in a special named dir like 'name.comments-src' then:" && 
		: "- path of worktree dir from branch like 'name.comments-src/tree/<branch-name>'" && 
		: "- path of worktree dir from tag like 'name.comments-src/tags/<tag-name>'" && 
		
		eval "$(subs frames codes_head)" && 
		
		#. git-aide bare-play up
		#. git-aide bare-play up origin
		#. git-aide bare-play up github
		#. git-aide bare-play up disroot
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
			echo '- git-aide bare-play up' && 
			echo '- git-aide bare-play up origin' && 
			echo '- git-aide bare-play up github' && 
			echo '- git-aide bare-play up disroot' && 
			echo && 
			echo 'See help:' && 
			echo '- git-aide help bare-play update' && 
			echo '- git-aide help bare-play up' && 
			echo '- git-aide help bp up' && 
			echo '- git-aide bp help up' && 
			echo && 
			: ) && 
		alias up=update && update () 
		(
			_find_in () 
			(
				_path="${1}" && shift && 
				#: means run find ... just if path exists.
				{ ! ( &>/dev/null cd "$_path" ) || find -- "$_path" "$@" ; } && 
				: ) && 
			
			_find_in ../tree -maxdepth 1 -mindepth 1 -type d | 
				while read -r -- treepath ;
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
			
			_find_in ../tree -maxdepth 1 -mindepth 1 -type d | 
				while read -r -- treepath ; 
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
		
		#. git-aide bare-play worktree add tree master
		#. git-aide bare-play worktree rm tree master
		#. git-aide bare-play worktree add tags v1.0.1
		#. git-aide bare-play worktree rm tags v1.0.1
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
			echo '- git-aide bare-play worktree add tree master' && 
			echo '- git-aide bare-play worktree rm tree master' && 
			echo '- git-aide bare-play worktree add tags v1.0.1' && 
			echo '- git-aide bare-play worktree rm tags v1.0.1' && 
			echo '- git-aide bare-play wt a tags v1.16.1' && 
			echo '- git-aide bare-play wt a tree master' && 
			echo && 
			echo 'See help:' && 
			echo '- git-aide help bare-play worktree' && 
			echo '- git-aide help bare-play wt' && 
			echo '- git-aide help bp wt' && 
			echo '- git-aide bp help wt' && 
			echo && 
			: ) && 
		alias wt=worktree && worktree () 
		(
			case "$1" 
			in 
				(add|a|create|c|load|+)   __cmd_a__=add     __n_ctrl__=     && shift ;;
				(rm|remove|del|d|drop|x)  __cmd_a__=remove  __n_ctrl__=' '  && shift ;;
				(_) 1>&2 echo Unknown sub cmd a: "'$1'" && return 16 ;;
			esac && 
			
			case "$1" 
			in 
				(tags)  __cmd_b__=tag     __dir__=tags  __called__=tags      && shift ;;
				(tree)  __cmd_b__=branch  __dir__=tree  __called__=branches  && shift ;;
				(_) 1>&2 echo Unknown sub cmd b: "'$1'" && return 16 ;;
			esac && 
			
			case "${CHOOSE_MODE:-${CHOOSER:-Only}}" 
			in 
				(Only|O|o|only)  __chooser_name__=Only && __chooser () ( IN="${_name_input}" awk -- 'BEGIN { a = ENVIRON["IN"] } $0 == a' && : )  ;;
				(All|A|a|all)    __chooser_name__=All  && __chooser () ( cat - && : )  ;;
				(as|AS)          __chooser_name__=AS   && __chooser () ( awk -- "/${CHOOSE_AS:-}/" && : )  ;;
				(_) 1>&2 echo Unknown select for CHOOSER: "${CHOOSER}" '-- Must be Only/All/AS.' && return 17 ;;
			esac && 
			
			# __choose_max="${CHOOSE_MAX:-12}" && 
			
			return $( 
			shopt -u -q -- extglob ;
			{
				_name_input="$1" && shift && 
				{
					git "${__cmd_b__}" --format='%(refname:short)' --no-column --contains "$_name_input" || 
					echo $? 1>&6 ;
					:; 
				} | 
					FD_TEE=2 _ctrl_tools _wait_tee awk -- '
						{ print "-",$0 } 
						BEGIN { 
							OFS = "\t" ; 
							print "Contained '"${__called__}"': " }
						' | 
					# tee >( | ELLIPSIS_SHOW=y LINES_MAX=128 _ctrl_tools _wait_outs 1>&2) | 
					__chooser | # ELLIPSIS_SHOW=x LINES_MAX="$__choose_max" _ctrl_tools _wait_outs | 
					FD_TEE=2 _ctrl_tools _wait_tee awk -- '
						{ print "-",$0 } 
						BEGIN { 
							OFS = "\t" ; 
							print "Choosed '"${__called__}"' (choose mode: '"${__chooser_name__}"'): " }
						' | 
					# tee >( | ELLIPSIS_SHOW=x LINES_MAX="$__choose_max" _ctrl_tools _wait_outs 1>&2) | 
					{
						while read -r -- _name ;
						do 
							echo :: executing: worktree "${__cmd_a__}" "../${__dir__}/$_name" ${__n_ctrl__:-${_name}} "$@" :: && 
							git worktree "${__cmd_a__}" ../"${__dir__}"/$_name ${__n_ctrl__:-${_name}} "$@" && 
							{ ls -d -- ../"${__dir__}"/* || ls ../"${__dir__}" || ls -d -- ../* ; } && 
							:; 
						done || 
						echo $? 1>&6 ;
					} | 
					cat - 1>&7 && 
					:;
			} 6>&1 && : ) && : ) 7>&1 && 
		
		: :: && 
		
		eval "$(subs frames codes_tail)" && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	#: ...
	sync_play__helper__ () 
	(
		echo && 
		echo '(TODO...)' && 
		echo && 
		: ) && 
	alias sp=sync_play sync-play=sync_play && sync_play () 
	(
		eval "$(subs frames codes_head)" && 
		
		#: git-aide sp all-sync [<workspace> ...]
		#::	workspace: means the prefix in full name of a repo
		#..	 like it in so many hubs -- <workspace>/<reponame>. In generally
		#;;	 a 'workspace' can be the id-name of a(n) user or org.
		alias all-sync=all_sync && all_sync () 
		(
			_param_tools params_out "${@:-.}" | _all_sync && 
			: ) && 
		
		_all_sync () 
		(
			while read -r -- workspace ;
			do 
				ls -1 -d -- "${workspace}"/* | while read -r -- gitpath ;
				do all_pull "${gitpath}" && all_push "${gitpath}" && :; done && 
				:; 
			done && 
			: ) && 
		
		
		#: git-aide sp base-upgrade [<gitdir-path> ...]
		#: base_upgrade [<gitdir-path> ...]
		#: IS_BARE=true base_upgrade [<gitdir-path> ...]
		#: SHOW_MORE_HINTS=n IS_BARE=y base_upgrade [<gitdir-path> ...]
		alias base-upgrade=base_upgrade && base_upgrade () 
		(
			_param_tools params_out "${@:-.}" | IS_BARE="${IS_BARE:-}" _base_upgrade && 
			: ) && 
		
		_base_upgrade () 
		(
			while read -r -- gitdir ;
			do 
				(
					SHOW_HINTS="${SHOW_MORE_HINTS:-y}" repo_chk worktree "${gitdir}" || 
					SHOW_HINTS="${SHOW_MORE_HINTS:-y}" repo_chk gitdir "${gitdir}" && 
					: ) && 
				(
					cd "${gitdir}" && 
					if test -z "${IS_BARE:-}" ;
						then local IS_BARE="$(repo_chk bare . echo)" ;
						else local IS_BARE="${IS_BARE:-}" ;
					fi && 
					eval "$(subs kwargs as_bool IS_BARE '')" && 
					echo base_upgrade: update from remote for "'${gitdir}'" && 
					while 
					! if ! "${__IS_BARE__}" ;
						then git pull ;
						else bare_play update ;
						# else git remote update ;
					fi ;
					do 
						echo base_upgrade: tried: "$((++try_pull_base_upgrade))" for '`'"$(if ! "${__IS_BARE__}" ;
							then echo "git pull" ;
							else echo "git remote update" ;
						fi)"'`' in "'${gitdir}'" && 
						:; 
					done && 
					echo base_upgrade: updated in "'${gitdir}'" && 
					: ) && 
				:; 
			done && 
			: ) && 
		
		
		#: git-aide sp all-push [<git-dir> ...]
		alias all-push=all_push && all_push () 
		(
			echo :: pushing origin to all remotes in: "${@:-.}" :: && 
			_param_tools params_out "${@:-.}" | _all_push ${GITPUSH_FLAGS:--v} && 
			: ) && 
		
		_all_push () 
		(
			: Push origin to all remotes.
			while read -r -- gitdir ;
			do 
				(
					repo_chk worktree "${gitdir}" || 
					repo_chk gitdir "${gitdir}" && 
					: ) && 
				local checked_bare="$(repo_chk bare "${gitdir}" echo)" && 
				SHOW_MORE_HINTS=no IS_BARE="$checked_bare" base_upgrade "${gitdir}" && 
				(
					cd "${gitdir}" && 
					echo :: pushing all remotes in "'${gitdir}'" :: && 
					git remote | while read -r -- git_remote ;
					do 
						echo working: push to remote "'${git_remote}'" for "'${gitdir}'" && 
						eval "$(_cmnd_tools _retry_asking init_codes)" && 
						while 
						! if ! "${checked_bare}" && : 其令选行 ;
							then git push "$@" --branches -- "${git_remote}" ;
							else git push "$@" -- "${git_remote}" 'refs/heads/*:refs/heads/*' ;
						fi ;
						do 
							: 此下 乃复试探 有询 && 
							: 其尝回显 && 
							echo tried: "$((++try_push))" for '`'"$(if ! "${checked_bare}" && : 其显选出 ;
								then echo "git push $* --branches -- ${git_remote}" ;
								else echo "git push $* -- ${git_remote} 'refs/heads/*:refs/heads/*'" ;
							fi)"'`' in "'${gitdir}'" && 
							: 其尝适询 && 
							eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && 
							:; 
						done && 
						:; 
					done && 
					echo :: pushed all remotes in "'${gitdir}'" :: && 
					: ) && 
				:; 
			done && 
			echo && 
			: 使其询必曰问之 && 
			: ) 9</dev/tty && 
		
		
		#: git-aide sp all-pull [<git-dir> ...]
		alias all-pull=all_pull && all_pull () 
		(
			echo :: pulling from origin and all remotes in: "${@:-.}" :: && 
			_param_tools params_out "${@:-.}" | _all_pull ${GITPULL_FLAGS:--v} && 
			: ) && 
		
		_all_pull () 
		(
			: Pull from origin and all remotes.
			while read -r -- gitdir ;
			do 
				(
					repo_chk worktree "${gitdir}" || 
					repo_chk gitdir "${gitdir}" && 
					: ) && 
				local checked_bare="$(repo_chk bare "${gitdir}" echo)" && 
				SHOW_MORE_HINTS=no IS_BARE="$checked_bare" base_upgrade "${gitdir}" && 
				(
					cd "${gitdir}" && 
					echo :: pulling all remotes in "'${gitdir}'" :: && 
					git remote | while read -r -- git_remote ;
					do 
						local _symbref_head="$(git symbolic-ref -- HEAD)" && 
						echo working: pull from remote "'${git_remote}'" for "'${gitdir}'" && 
						eval "$(_cmnd_tools _retry_asking init_codes)" && 
						while 
						! if ! "${checked_bare}" && : 其令选行 ;
							then git fetch "$@" -- "${git_remote}" 'refs/heads/*:refs/heads/*' '^'"${_symbref_head}" ;
							else git fetch "$@" -- "${git_remote}" 'refs/heads/*:refs/heads/*' ;
						fi ;
						do 
							: 此下 乃复试探 有询 && 
							: 其尝回显 && 
							echo tried: "$((++try_pull))" for '`'"$(if ! "${checked_bare}" && : 其显选出 ;
								then echo "git fetch $* -- ${git_remote} 'refs/heads/*:refs/heads/*' '^${_symbref_head}'" ;
								else echo "git fetch $* -- ${git_remote} 'refs/heads/*:refs/heads/*'" ;
							fi)"'`' in "'${gitdir}'" && 
							: 其尝适询 && 
							eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && 
							:; 
						done && 
						:; 
					done && 
					echo :: pulled all remotes in "'${gitdir}'" :: && 
					: ) && 
				:; 
			done && 
			echo && 
			: 使其询必曰问之 && 
			: ) 9</dev/tty && 
		
		: :: && 
		
		eval "$(subs frames codes_tail)" && 
		
		: :: && 
		"$@" && 
		: ) && 
	
	
	: :: && 
	
	eval "$(subs frames codes_tail)" && 
	
	: :: && 
	
	"$@" && 
	: ) && 

eval "$(MARK_MORE=GIT_BENCH PKG_SUBS='libs subs lang' libs subs frames codes_tail)" && 

# : \
git_aide "$@" && :




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

## pull/push --all
#  - in push: Push all branches
#  - in pull: Fetch all remotes

# git symbolic-ref HEAD #: 查 HEAD 指向、用 cat ./HEAD 也能看到相应信息
# git symbolic-ref HEAD refs/heads/some-other-branch #: 变 HEAD 指向
# git config --global -- alias.aide "!/usr/bin/env bash ~/.local/git-aide.sh"

#### demo -----------------------

#|	$ git-aide cp auto-clone https://github.com/LibreService/my_rime.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
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

#|	$ git-aide cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
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

#|	$ git-aide bare-play up
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


#|	$ git-aide help cp ac
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.
#|	
#|	sub command: cp ac
#|	
#|	Usage:
#|		 git-aide cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]
#|	
#|	This tool is for when you having a bad internet to your
#|	 remote repo. It will making a depth=1 shallow clone at the
#|	 first and then unshallow it, also at the end update it once
#|	 to make your local repo sync the newest records as far as it could.
#|	 All of the downloading works can auto-retry while it failed.
#|	
#|	Demo:
#|	- git-aide cp auto-clone https://github.com/LibreService/my_rime.git --mirror
#|	- git-aide cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
#|	- git-aide cp auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git
#|	- git-aide cp auto-clone --mirror -- https://github.com/crynta/terax-ai.git
#|	- git-aide cp auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass
#|	
#|	See help:
#|	- git-aide help cp auto-clone
#|	- git-aide help cp ac
#|	- git-aide cp help ac
#|	

#|	$ git-aide help bare-play up
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.
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
#|	- git-aide bare-play up
#|	- git-aide bare-play up origin
#|	- git-aide bare-play up github
#|	- git-aide bare-play up disroot
#|	
#|	See help:
#|	- git-aide help bare-play update
#|	- git-aide help bare-play up
#|	- git-aide help bp up
#|	- git-aide bp help up
#|	

#|	$ git-aide help bp up
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.
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
#|	- git-aide bare-play up
#|	- git-aide bare-play up origin
#|	- git-aide bare-play up github
#|	- git-aide bare-play up disroot
#|	
#|	See help:
#|	- git-aide help bare-play update
#|	- git-aide help bare-play up
#|	- git-aide help bp up
#|	- git-aide bp help up
#|	

#|	$ git-aide help bp wt
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.
#|	
#|	sub command: bp wt
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	
#|	Using for create/delete worktree(s) of bare repo. It will
#|	 search from branches/tags then run worktree add/remove to those object(s)
#|	
#|	Bare dir here MUST in a special named dir like: 'name.comments-src', then:
#|	- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
#|	- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'
#|	
#|	Demo:
#|	- git-aide bare-play worktree add tree master
#|	- git-aide bare-play worktree rm tree master
#|	- git-aide bare-play worktree add tags v1.0.1
#|	- git-aide bare-play worktree rm tags v1.0.1
#|	- git-aide bare-play wt a tags v1.16.1
#|	- git-aide bare-play wt a tree master
#|	
#|	See help:
#|	- git-aide help bare-play worktree
#|	- git-aide help bare-play wt
#|	- git-aide help bp wt
#|	- git-aide bp help wt
#|	

#|	$ git-aide bp wt a tags v1.61.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	error: malformed object name v1.61.1
#|	$ echo $?
#|	129

#|	$ CHOOSE_MODE=All git-aide bp wt a tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed branches (choose mode: All):
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	:: executing: worktree add ../tags/v1.16.1 v1.16.1 ::
#|	Preparing worktree (detached HEAD f4bb1ded)
#|	Updating files: 100% (652/652), done.
#|	HEAD is now at f4bb1ded Tag v1.16.1 (#3304)
#|	../tags/v1.16.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.1 v1.17.0-rc.1 ::
#|	Preparing worktree (detached HEAD bacb2454)
#|	Updating files: 100% (687/687), done.
#|	HEAD is now at bacb2454 Tag v1.17.0-rc.1
#|	../tags/v1.16.1/
#|	../tags/v1.17.0-rc.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.2 v1.17.0-rc.2 ::
#|	Preparing worktree (detached HEAD d28b405b)
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at d28b405b Tag v1.17.0-rc.2
#|	../tags/v1.16.1/
#|	../tags/v1.17.0-rc.1/
#|	../tags/v1.17.0-rc.2/
#|	$ CHOOSE_MODE=All git-aide bp wt x tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed tags (choose mode: All):
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	:: executing: worktree remove ../tags/v1.16.1 ::
#|	../tags/v1.17.0-rc.1/
#|	../tags/v1.17.0-rc.2/
#|	:: executing: worktree remove ../tags/v1.17.0-rc.1 ::
#|	../tags/v1.17.0-rc.2/
#|	:: executing: worktree remove ../tags/v1.17.0-rc.2 ::
#|	ls: cannot access '../tags/*': No such file or directory

#|	$ CHOOSE_MODE=Only git-aide bp wt a tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed tags (choose mode: Only):
#|	-	v1.16.1
#|	:: executing: worktree add ../tags/v1.16.1 v1.16.1 ::
#|	Preparing worktree (detached HEAD f4bb1ded)
#|	Updating files: 100% (652/652), done.
#|	HEAD is now at f4bb1ded Tag v1.16.1 (#3304)
#|	../tags/v1.16.1/
#|	$ git-aide bp wt a tree master
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained branches:
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at f25fc7b4 fix: restore clip flag through fuzzy search in show command (#3466)
#|	../tree/master/

#|	$ git-aide bp help wt
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
#|	- git-aide bare-play worktree add tree master
#|	- git-aide bare-play worktree rm tree master
#|	- git-aide bare-play worktree add tags v1.0.1
#|	- git-aide bare-play worktree rm tags v1.0.1
#|	- git-aide bare-play wt a tags v1.16.1
#|	- git-aide bare-play wt a tree master
#|	
#|	See help:
#|	- git-aide help bare-play worktree
#|	- git-aide help bare-play wt
#|	- git-aide help bp wt
#|	- git-aide bp help wt
#|	

#|	$ git-aide bp wt a tree master
#|	repochk: `/mnt/e/gopass.passwd-srcs/browser-ext/gopassbridge.git` is bare repository ~ true
#|	Contained branches:
#|	-	dependabot/github_actions/actions/checkout-7
#|	-	dependabot/github_actions/codecov/codecov-action-7
#|	-	dependabot/tools-e50eacec07
#|	-	master
#|	Choosed branches (choose mode: Only):
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (91/91), done.
#|	HEAD is now at 5da4522 Merge pull request #342 from gopasspw/dependabot/tools-48090d0390
#|	../tree/master/

#|	$ git-aide ac https://github.com/t8y2/dbx.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'dbx.git'...
#|	remote: Enumerating objects: 24035, done.
#|	remote: Counting objects: 100% (24035/24035), done.
#|	remote: Compressing objects: 100% (11838/11838), done.
#|	remote: Total 24035 (delta 15543), reused 18741 (delta 10815), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24035/24035), 31.32 MiB | 47.00 KiB/s, done.
#|	Resolving deltas: 100% (15543/15543), done.
#|	:: change workdir to `dbx.git` from `/mnt/e/dbx.sqlclient.ai-src` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/dbx.sqlclient.ai-src/dbx.git` ::
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/t8y2/dbx.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	remote: Enumerating objects: 29539, done.
#|	remote: Counting objects: 100% (25803/25803), done.
#|	remote: Compressing objects: 100% (14807/14807), done.
#|	error: RPC failed; curl 56 Recv failure: Connection was reset
#|	error: 4027 bytes of body are still expected
#|	fetch-pack: unexpected disconnect while reading sideband packet
#|	fatal: early EOF
#|	fatal: fetch-pack: invalid index-pack output
#|	tried: 2 for unshallow
#|	remote: Enumerating objects: 29558, done.
#|	remote: Counting objects: 100% (25875/25875), done.
#|	remote: Compressing objects: 100% (14815/14815), done.
#|	error: RPC failed; curl 18 transfer closed with outstanding read data remaining
#|	error: 2977 bytes of body are still expected
#|	fetch-pack: unexpected disconnect while reading sideband packet
#|	fatal: early EOF
#|	fatal: fetch-pack: invalid index-pack output
#|	tried: 3 for unshallow
#|	remote: Enumerating objects: 29579, done.
#|	remote: Counting objects: 100% (25887/25887), done.
#|	remote: Compressing objects: 100% (14828/14828), done.
#|	remote: Total 24629 (delta 14265), reused 19298 (delta 9413), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24629/24629), 254.68 MiB | 77.00 KiB/s, done.
#|	Resolving deltas: 100% (14265/14265), completed with 571 local objects.
#|	From https://github.com/t8y2/dbx
#|	 * [new ref]           refs/pull/2155/head  -> refs/pull/2155/head
#|	 * [new ref]           refs/pull/2155/merge -> refs/pull/2155/merge
#|	 * [new ref]           refs/pull/2156/head  -> refs/pull/2156/head
#|	 * [new ref]           refs/pull/2156/merge -> refs/pull/2156/merge
#|	:: updating in `/mnt/e/dbx.sqlclient.ai-src/dbx.git` ::
#|	fatal: unable to access 'https://github.com/t8y2/dbx.git/': Failed to connect to github.com port 443 after 21398 ms: Could not connect to server
#|	tried: 1 for remote update
#|	remote: Enumerating objects: 25, done.
#|	remote: Counting objects: 100% (21/21), done.
#|	remote: Compressing objects: 100% (10/10), done.
#|	remote: Total 25 (delta 12), reused 11 (delta 11), pack-reused 4 (from 1)
#|	Unpacking objects: 100% (25/25), 26.46 KiB | 13.00 KiB/s, done.
#|	From https://github.com/t8y2/dbx
#|	   b951d3a5..7a21f258  main       -> main
#|	:: done for repo `dbx.git`. ::
#|	$ git-aide bp wt a tags v0.5.41
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained tags:
#|	-	agents-latest
#|	-	agents-v0.2.39
#|	-	packages-v0.4.17
#|	-	v0.5.41
#|	Choosed tags (choose mode: Only):
#|	-	v0.5.41
#|	:: executing: worktree add ../tags/v0.5.41 v0.5.41 ::
#|	Preparing worktree (detached HEAD ba872303)
#|	Updating files: 100% (1656/1656), done.
#|	HEAD is now at ba872303 feat(release): bump app version to 0.5.41
#|	../tags/v0.5.41/
#|	$ git-aide bp wt a tree main
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained branches:
#|	-	main
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree add ../tree/main main ::
#|	Preparing worktree (checking out 'main')
#|	Updating files: 100% (1656/1656), done.
#|	HEAD is now at 7a21f258 feat(sqlCompletion): support SELECT list expand-all-fields completion (#2155)
#|	../tree/main/
#|	$ git-aide bp wt x tree main
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained branches:
#|	-	main
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree remove ../tree/main ::
#|	ls: cannot access '../tree/*': No such file or directory

#|	$ git-aide bp wt a tags v3.1.5
#|	repochk: `/mnt/e/xed.repoctl.editor.android-src/Xed-Editor.git` is bare repository ~ true
#|	Contained tags:
#|	-	sdk-latest
#|	-	v3.1.5
#|	-	v3.1.7
#|	-	v3.1.8
#|	-	v3.1.9
#|	-	v3.2.1
#|	-	v3.2.3
#|	-	v3.2.4
#|	-	v3.2.5
#|	-	v3.2.6
#|	-	v3.2.7
#|	-	v3.2.9
#|	-	v3.3.1
#|	-	v3.3.2
#|	-	v3.3.3
#|	-	v3.3.4
#|	Choosed tags (choose mode: Only):
#|	-	v3.1.5
#|	:: executing: worktree add ../tags/v3.1.5 v3.1.5 ::
#|	Preparing worktree (detached HEAD 3dd223437)
#|	Updating files: 100% (715/715), done.
#|	HEAD is now at 3dd223437 Update network_security_config.xml
#|	../tags/v3.1.5/

#|	$ . ~/git-aide.sh && git-aide sp all-sync
#|	:: pulling from origin and all remotes in: ./pure.lexicals/ ::
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is inside worktree ~ true
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is bare repository ~ false
#|	base_upgrade: update from remote for './pure.lexicals/'
#|	remote: Enumerating objects: 39, done.
#|	remote: Counting objects: 100% (39/39), done.
#|	remote: Compressing objects: 100% (28/28), done.
#|	remote: Total 28 (delta 18), reused 0 (delta 0), pack-reused 0 (from 0)
#|	Unpacking objects: 100% (28/28), 6.46 KiB | 2.00 KiB/s, done.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	   d536247..8fbcd08  main       -> origin/main
#|	Updating d536247..8fbcd08
#|	Fast-forward
#|	 .notes/sh3rrs/Subs/.demo/git-aide.sh               | 90 ++++++++++++++--------
#|	 .../readme"                                        | 16 +++-
#|	 2 files changed, 75 insertions(+), 31 deletions(-)
#|	base_upgrade: updated in './pure.lexicals/'
#|	:: pulling all remotes in './pure.lexicals/' ::
#|	working: pull from remote 'disroot' for './pure.lexicals/'
#|	POST git-upload-pack (165 bytes)
#|	working: pull from remote 'origin' for './pure.lexicals/'
#|	POST git-upload-pack (165 bytes)
#|	:: pulled all remotes in './pure.lexicals/' ::
#|	
#|	:: pushing origin to all remotes in: ./pure.lexicals/ ::
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is inside worktree ~ true
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is bare repository ~ false
#|	base_upgrade: update from remote for './pure.lexicals/'
#|	Already up to date.
#|	base_upgrade: updated in './pure.lexicals/'
#|	:: pushing all remotes in './pure.lexicals/' ::
#|	working: push to remote 'disroot' for './pure.lexicals/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	Enumerating objects: 468, done.
#|	Counting objects: 100% (468/468), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (191/191), done.
#|	Writing objects: 100% (453/453), 132.51 KiB | 2.28 MiB/s, done.
#|	Total 453 (delta 306), reused 398 (delta 261), pack-reused 0 (from 0)
#|	POST git-receive-pack (135873 bytes)
#|	remote: Resolving deltas: 100% (306/306), completed with 11 local objects.
#|	remote: Checking connectivity: 453, done.
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	   d89077d..8fbcd08  main -> main
#|	updating local tracking ref 'refs/remotes/disroot/main'
#|	working: push to remote 'origin' for './pure.lexicals/'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/origin/main'
#|	Everything up-to-date
#|	:: pushed all remotes in './pure.lexicals/' ::
#|	
#|	:: pulling from origin and all remotes in: ./pure.lexicals.git/ ::
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is bare repository ~ true
#|	base_upgrade: update from remote for './pure.lexicals.git/'
#|	Fetching origin
#|	remote: Enumerating objects: 32, done.
#|	remote: Counting objects: 100% (32/32), done.
#|	remote: Compressing objects: 100% (21/21), done.
#|	remote: Total 21 (delta 14), reused 0 (delta 0), pack-reused 0 (from 0)
#|	Unpacking objects: 100% (21/21), 4.87 KiB | 2.00 KiB/s, done.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	   1f2f05a..8fbcd08  main       -> main
#|	Fetching disroot
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	   d89077d..8fbcd08  main       -> disroot/main
#|	Fetching dr
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	   d89077d..8fbcd08  main       -> dr/main
#|	base_upgrade: updated in './pure.lexicals.git/'
#|	:: pulling all remotes in './pure.lexicals.git/' ::
#|	working: pull from remote 'disroot' for './pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> disroot/main
#|	working: pull from remote 'dr' for './pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'origin' for './pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in './pure.lexicals.git/' ::
#|	
#|	:: pushing origin to all remotes in: ./pure.lexicals.git/ ::
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/repos-testing/pure.lexicals.git` is bare repository ~ true
#|	base_upgrade: update from remote for './pure.lexicals.git/'
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 + 8fbcd08...d89077d disroot/main -> disroot/main  (forced update)
#|	Fetching disroot
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	   d89077d..8fbcd08  main       -> disroot/main
#|	Fetching dr
#|	base_upgrade: updated in './pure.lexicals.git/'
#|	:: pushing all remotes in './pure.lexicals.git/' ::
#|	working: push to remote 'disroot' for './pure.lexicals.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/disroot/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for './pure.lexicals.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for './pure.lexicals.git/'
#|	fatal: --mirror can't be combined with refspecs
#|	tried: 1 for `git push -v -- origin 'refs/heads/*:refs/heads/*'` in './pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	:: try-asking: rested times of push trying: -1.
#|	:: try-asking: Break.
#|	:: pushed all remotes in './pure.lexicals.git/' ::
#|	

#|	$ git-aide help
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.

#|	$ git-aide help git-aide
#|	sub command(s) here:
#|	- bare-play: means 'bare_play'.
#|	- bp: means 'bare_play'.
#|	- clone-play: means 'clone_play'.
#|	- cp: means 'clone_play'.
#|	- rc: means 'repo_chk'.
#|	- repo-check: means 'repo_chk'.
#|	- repo-chk: means 'repo_chk'.
#|	- sp: means 'sync_play'.
#|	- sub-help: means 'aliases'.
#|	- sync-play: means 'sync_play'.
#|	
#|	sub command: git-aide
#|	
#|	Git Aide Player (also names 'git bench/bike') is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-aide help
#|	- git-aide help git-aide
#|	- git-aide help git-bench
#|	- git-aide help git-bike
#|	- git-aide help gp
#|	- help git-aide
#|	- help git-bench
#|	- help git-bike
#|	- help gp
#|	

#|	$ help git-aide
#|	sub command(s) here:
#|	- git-aide: means 'git_aide'.
#|	- git-bench: means 'git_aide'.
#|	- git-bike: means 'git_aide'.
#|	- git-player: means 'git_aide'.
#|	- gp: means 'git_aide'.
#|	- sub-help: means 'aliases'.
#|	
#|	sub command: git-aide
#|	
#|	Git Aide Player (also names 'git bench/bike') is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-aide help
#|	- git-aide help git-aide
#|	- git-aide help git-bench
#|	- git-aide help git-bike
#|	- git-aide help gp
#|	- help git-aide
#|	- help git-bench
#|	- help git-bike
#|	- help gp
#|	

#|	$ help gp
#|	sub command(s) here:
#|	- git-aide: means 'git_aide'.
#|	- git-bench: means 'git_aide'.
#|	- git-bike: means 'git_aide'.
#|	- git-player: means 'git_aide'.
#|	- gp: means 'git_aide'.
#|	- sub-help: means 'aliases'.
#|	
#|	sub command: gp
#|	
#|	Git Aide Player (also names 'git bench/bike') is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-aide help
#|	- git-aide help git-aide
#|	- git-aide help git-bench
#|	- git-aide help git-bike
#|	- git-aide help gp
#|	- help git-aide
#|	- help git-bench
#|	- help git-bike
#|	- help gp
#|	

#|	$ . ~/git-aide.sh && OPTS_CLONE=--bare git-aide cp m . mabin.sp-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git pure.lexi-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git :https://github.com/yhm-amber/lang-note.git
#|	:: executing: `.aide cp auto-clone --bare -- 'https://github.com/pure-symbols/mabynogion.spells.git' mabin.sp-src/mabynogion.spells.git` in '/mnt/e/repos' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'mabin.sp-src/mabynogion.spells.git'...
#|	remote: Enumerating objects: 80, done.
#|	remote: Counting objects: 100% (80/80), done.
#|	remote: Compressing objects: 100% (73/73), done.
#|	remote: Total 80 (delta 0), reused 38 (delta 0), pack-reused 0 (from 0)
#|	Receiving objects: 100% (80/80), 68.97 KiB | 105.00 KiB/s, done.
#|	:: change workdir to `mabin.sp-src/mabynogion.spells.git` from `/mnt/e/repos` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` ::
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21342 ms: Could not connect to server
#|	tried: 1 for unshallow
#|	remote: Enumerating objects: 710, done.
#|	remote: Counting objects: 100% (710/710), done.
#|	remote: Compressing objects: 100% (387/387), done.
#|	remote: Total 645 (delta 381), reused 455 (delta 248), pack-reused 0 (from 0)
#|	Receiving objects: 100% (645/645), 171.43 KiB | 816.00 KiB/s, done.
#|	Resolving deltas: 100% (381/381), completed with 54 local objects.
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` ::
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is bare repository ~ true
#|	base_upgrade: update from remote for '.'
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../mabin.sp-src/mabynogion.spells.git' for remote(s)
#|	base_upgrade: updated in '.'
#|	:: done for repo `mabin.sp-src/mabynogion.spells.git`. ::
#|	:: executing: `.aide cp auto-clone --bare -- 'https://github.com/pure-symbols/pure.lexicals.git' pure.lexi-src/pure.lexicals.git` in '/mnt/e/repos' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'pure.lexi-src/pure.lexicals.git'...
#|	remote: Enumerating objects: 972, done.
#|	remote: Counting objects: 100% (972/972), done.
#|	remote: Compressing objects: 100% (728/728), done.
#|	remote: Total 972 (delta 11), reused 904 (delta 9), pack-reused 0 (from 0)
#|	Receiving objects: 100% (972/972), 50.83 MiB | 104.00 KiB/s, done.
#|	Resolving deltas: 100% (11/11), done.
#|	:: change workdir to `pure.lexi-src/pure.lexicals.git` from `/mnt/e/repos` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` ::
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is shallow repository ~ true
#|	remote: Enumerating objects: 13742, done.
#|	remote: Counting objects: 100% (13742/13742), done.
#|	remote: Compressing objects: 100% (4297/4297), done.
#|	remote: Total 13370 (delta 8513), reused 13080 (delta 8304), pack-reused 0 (from 0)
#|	Receiving objects: 100% (13370/13370), 10.43 MiB | 2.63 MiB/s, done.
#|	Resolving deltas: 100% (8513/8513), completed with 182 local objects.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` ::
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is bare repository ~ true
#|	base_upgrade: update from remote for '.'
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.lexi-src/pure.lexicals.git' for remote(s)
#|	base_upgrade: updated in '.'
#|	:: done for repo `pure.lexi-src/pure.lexicals.git`. ::
#|	:: executing: `.aide cp auto-clone --bare -- 'https://github.com/yhm-amber/lang-note.git' ` in '/mnt/e/repos' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'lang-note.git'...
#|	remote: Enumerating objects: 279, done.
#|	remote: Counting objects: 100% (279/279), done.
#|	remote: Compressing objects: 100% (215/215), done.
#|	remote: Total 279 (delta 8), reused 239 (delta 4), pack-reused 0 (from 0)
#|	Receiving objects: 100% (279/279), 838.62 KiB | 149.00 KiB/s, done.
#|	Resolving deltas: 100% (8/8), done.
#|	:: change workdir to `lang-note.git` from `/mnt/e/repos` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/repos/lang-note.git` ::
#|	repochk: `/mnt/e/repos/lang-note.git` is shallow repository ~ true
#|	remote: Enumerating objects: 4105, done.
#|	remote: Counting objects: 100% (4105/4105), done.
#|	remote: Compressing objects: 100% (1590/1590), done.
#|	Rremote: Total 3950 (delta 2295), reused 3772 (delta 2184), pack-reused 0 (from 0)
#|	Receiving objects: 100% (3950/3950), 732.22 KiB | 616.00 KiB/s, done.
#|	Resolving deltas: 100% (2295/2295), completed with 102 local objects.
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/e/repos/lang-note.git` ::
#|	repochk: `/mnt/e/repos/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/e/repos/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/repos/lang-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for '.'
#|	repochk: `/mnt/e/repos/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../test/lang-note.git' for remote(s)
#|	base_upgrade: updated in '.'
#|	:: done for repo `lang-note.git`. ::



