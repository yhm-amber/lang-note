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
		_set_tool () 
		(
			#.	__a__="$(alias)"
			#.	alias a=a b=b
			#.	alias | _set_tool diff "$__a__"
			#.	_set_tool diff "$__a__" <(alias)
			#:>	out: `alias a='a'` and `alias b='b'`
			diff () 
			(
				grep -x -F -f <( echo "$1" ) -v -- "${2:--}" && 
				: ) && 
			: :: && 
			
			#.	( echo a ; echo b ; echo c ) | _set_tool intersect $'c\nd\ne'
			#:>	out: `c`
			intersect () 
			(
				grep -x -F -f <( echo "$1" ) -- "${2:--}" && 
				: ) && 
			
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
					awk '{print} BEGIN { print "'"${SUB_HINTS:-sub command(s) here:}"'" }'
					cat - && 
				#: only run if having args ...
				for _ in "$@" ;
				do 
					echo && 
					echo your command: "$@" && 
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
			
			alias_nm () 
			(
				cat - | 
					SPACE_CHR="${IFS}" trim_line | 
					awk '{sub(/^alias /, ""); print}' | 
					while IFS== read -r -- a b ;
					do 
						echo "$(echo $a)" && 
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
			
			_HELP_BODY_SUBS="SUB_HINTS='${SUB_HINTS:-}' "'sub-help help_alias "$@"' && 
			_HELP_BODY_BUTN='builtin help "$@"' && 
			case "$(echo "${EVAL_PLACE:-inside}" | tr -- '[:upper:]' '[:lower:]')" 
			in 
				(i|in|inside|inner)      _help_ctrl='i'  ;; 
				(o|out|outside|outter)   _help_ctrl=''   ;; 
				(_) 1>&2 echo '[ERROR]: subs: frames: EVAL_PLACE: only support `inside` or `outside`.' ; return 7 ;; 
			esac && 

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
					alias sub-help=aliases && aliases () 
					( echo "$__aliases__'"$NAMEMARK_MORE"'" | '"${PKG_SUBS}"' "${@:-help_alias}" && : ) && 
					
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
					
					help () 
					( 
						for _ in '"$_help_ctrl"' $(echo "$1" | '"${PKG_SUBS}"' _set_tool intersect "$(aliases cat | '"${PKG_SUBS}"' alias_nm)") ;
						do 
							{ '"{ ${_HELP_BODY_SUBS} ; } || { ${_HELP_BODY_BUTN} ; }"' ; } ;
						return $? ; done && 
						{ '"{ ${_HELP_BODY_BUTN} ; }"' ; } ; return $? && 
						: ) && 
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
		_curr_dir () ( cd "$1" && basename "$(shift ; pwd "$@")" ) && 

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
			__chunk_asktiming () 
			(
				echo '
					_cmnd_tools _booled_returns "$((_rests_tryasking == 0))" && 
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
					if eval "$('"${PKG_ASKING}"' __chunk_asktiming)" ; 
					then 
						eval "$('"${PKG_ASKING}"' __chunk_asker)" && 
						(
							eval "$('"${PKG_ASKING}"' __chunk_asktiming)" && 
							eval "$('"${PKG_ASKING}"' __chunk_verifier)" && 
							: ) && 
						:; 
					else 
						eval "$('"${PKG_ASKING}"' __chunk_verifier)" && 
						:; 
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
		params_roll () 
		(
			for x in "$@" ;
			do "${OUTER_FN:-echo}" "${x}" && :; done && 
			: ) && 
		
		params_take () 
		(
			head () ( echo "$1" && : ) && 
			tail () ( shift 1 && params_roll "$@" && : ) && 
			home () ( params_roll "$@" | head -n "$(($# - 1))" && : ) && 
			ende () ( shift "$(($# - 1))" && params_roll "$@" && : ) && 
			: :: && 
			"$@" && 
			: ) && 
		
		flatten_line () 
		(
			while read -r -- line ;
			do OUTER_FN="${FLATTER_FN:-echo}" "${@:-params_roll}" $line && :; done && 
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


eval "$(SUB_HINTS='git-deck alias(es) here:' EVAL_PLACE=out MARK_MORE=GIT_DECKS PKG_SUBS='libs subs lang' libs subs frames codes_head)" && 

git_decks__helper__ () 
(
	echo && 
	echo 'The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs.' && 
	echo ' It'"'"'s also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names' && 
	echo ' as function with a helpdocs feature supported.' && 
	echo && 
	echo 'See help:' && 
	echo '- git-deck help' && 
	echo '- git-deck help git-deck' && 
	echo '- git-deck help gd' && 
	echo '- help git-deck' && 
	echo '- help gd' && 
	echo && 
	: ) && 
alias gd=git_decks git-deck=git_decks git-decks=git_decks && git_decks () 
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
		
		#: OPTS_CLONE='<git-clone-options>' git-deck cp multi-clone <working-dir> [<local-dir>]:<remote-link> [[<local-dir>]:<remote-link> ...]
		#. OPTS_CLONE=--bare git-deck cp m . mabin.sp-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git pure.lexi-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git
		multi_clone__helper__ () 
		(
			echo && 
			echo '(TODO...)' && 
			echo && 
			: ) && 
		alias m=multi_clone mc=multi_clone multi-clone=multi_clone && multi_clone () 
		(
			local working_dir="$1" && shift && 
			_param_tools params_roll "$@" | 
				WORKING_PATH="${working_dir}" OPTS_CLONE="${OPTS_CLONE}" _multi_clone | 
				cat - && 
			: ) && 
		_multi_clone () 
		(
			cd "${WORKING_PATH:-.}" && 
			while IFS=: read -r -- landing_path remote_link ;
			do 
				echo :: executing: '`'.decks cp auto-clone ${OPTS_CLONE} -- "'${remote_link}'" ${landing_path}'`' at "'${PWD}'" :: && 
				auto_clone ${OPTS_CLONE} -- "${remote_link}" ${landing_path} && 
				:; 
			done && 
			: ) && 
		
		#: git-deck cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]
		#. MAXTRY_ASKING=999 git-deck cp a https://github.com/denoland/deno.git --mirror
		#. MAXTRY_ASKING=999 git-deck cp a https://github.com/osquery/osquery.git --mirror
		auto_clone__helper__ () 
		(
			echo && 
			echo 'Usage:' && 
			echo $'\t' 'git-deck cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]' && 
			echo && 
			echo 'This tool is for when you having a bad internet to your' && 
			echo ' remote repo. It will making a depth=1 shallow clone at the' && 
			echo ' first and then unshallow it, also at the end update it once' && 
			echo ' to make your local repo sync the newest records as far as it could.' && 
			echo ' All of the downloading works can auto-retry while it failed.' && 
			echo && 
			echo 'Demo:' && 
			echo '- git-deck cp auto-clone https://github.com/LibreService/my_rime.git --mirror' && 
			echo '- git-deck cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror' && 
			echo '- git-deck cp auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git' && 
			echo '- git-deck cp auto-clone --mirror -- https://github.com/crynta/terax-ai.git' && 
			echo '- git-deck cp auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass' && 
			echo && 
			echo 'See help:' && 
			echo '- git-deck help cp auto-clone' && 
			echo '- git-deck help cp ac' && 
			echo '- git-deck cp help ac' && 
			echo && 
			: ) && 
		alias a=auto_clone ac=auto_clone auto-clone=auto_clone && auto_clone () 
		(
			echo :: git cloning in shallow '(depth 1)' mode :: && 
			eval "$(_cmnd_tools _retry_asking init_codes)" && : 其尝适询 && 
			while ! ( git clone --progress --depth 1 --no-single-branch "$@" 2>&1 && : ) ;
			do 
				1>&2 echo tried: "$((++try_clone))" for clone && 
				eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && : 其尝适询 && 
				:; 
			done | 
				tee >(cat 1>&2) | 
				#::	will only out 3 lines (which has "'")
				#;;	 after keep waiting until EOF
				ELLIPSIS_SHOW=x LINES_MAX=3 _ctrl_tools _wait_outs "'" | 
				#::	Just a head -n 1 alternative
				#;;	 but with no SIGPIPE to avoid pipe-broken.
				ELLIPSIS_SHOW=x LINES_MAX=1 _ctrl_tools _wait_outs 'Cloning into' | 
				_param_tools flatten_line params_roll | 
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
				break ; done && 
			echo && 
			: 使其询必曰问之 && 
			: ) 9</dev/tty && 
		
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
		
		#. git-deck bare-play up
		#. git-deck bare-play up origin
		#. git-deck bare-play up github
		#. git-deck bare-play up disroot
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
			echo '- git-deck bare-play up' && 
			echo '- git-deck bare-play up origin' && 
			echo '- git-deck bare-play up github' && 
			echo '- git-deck bare-play up disroot' && 
			echo && 
			echo 'See help:' && 
			echo '- git-deck help bare-play update' && 
			echo '- git-deck help bare-play up' && 
			echo '- git-deck help bp up' && 
			echo '- git-deck bp help up' && 
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
		
		#. git-deck bp wts init tree:master tags:v1.0.1 ...
		#. git-deck bp wts drop tree:master tags:v1.0.1 ...
		#. (cd deno.git && git-deck bp wts i tree:main tags:v2.9.2)
		#. (cd deno.git && git-deck bp wts x tree:main tags:v2.9.2)
		#. (cd osquery.git && git-deck bp wts i tree:master tags:5.23.1)
		#. (cd osquery.git && git-deck bp wts x tree:master tags:5.23.1)
		alias wts=worktrees && worktrees () 
		(
			case "$1" 
			in 
				(i|in|init)  __cmd_sub__=add  && shift ;;
				(x|rm|drop)  __cmd_sub__=rm   && shift ;;
				(_) 1>&2 echo Unknown sub cmd in worktrees: "'$1'" && return 16 ;;
			esac && 
			
			_param_tools params_roll "$@" | while IFS=: read -r -- _type _name ;
			do 
				echo :: executing: '`'"CHOOSE_MODE='${CHOOSE_MODE:-Only}' .decks bp worktree ${__cmd_sub__} $_type $_name"'`' at "'${PWD}'" :: && 
				CHOOSE_MODE="${CHOOSE_MODE:-Only}" worktree "${__cmd_sub__}" "$_type" "$_name" && 
				:; 
			done && 
			
			# eval "$(subs frames codes_head)" && 
			# 
			# alias i=init in=init && init () 
			# (
			# 	_param_tools params_roll "$@" | _init && 
			# 	: ) && 
			# _init () 
			# (
			# 	while IFS=: read -r -- _type _name ;
			# 	do CHOOSE_MODE="${CHOOSE_MODE:-Only}" worktree add "${_type}" "${_name}" && :; done && 
			# 	: ) && 
			# 
			# alias x=drop rm=drop && drop () 
			# (
			# 	_param_tools params_roll "$@" | _drop && 
			# 	: ) && 
			# _drop () 
			# (
			# 	while IFS=: read -r -- _type _name ;
			# 	do CHOOSE_MODE="${CHOOSE_MODE:-Only}" worktree rm "${_type}" "${_name}" && :; done && 
			# 	: ) && 
			# 
			# : :: && 
			# 
			# eval "$(subs frames codes_tail)" && 
			# 
			# : :: && 
			# "$@" && 
			: ) && 
		
		#. git-deck bare-play worktree add tree master
		#. git-deck bare-play worktree rm tree master
		#. git-deck bare-play worktree add tags v1.0.1
		#. git-deck bare-play worktree rm tags v1.0.1
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
			echo '- git-deck bare-play worktree add tree master' && 
			echo '- git-deck bare-play worktree rm tree master' && 
			echo '- git-deck bare-play worktree add tags v1.0.1' && 
			echo '- git-deck bare-play worktree rm tags v1.0.1' && 
			echo '- git-deck bare-play wt a tags v1.16.1' && 
			echo '- git-deck bare-play wt a tree master' && 
			echo && 
			echo 'See help:' && 
			echo '- git-deck help bare-play worktree' && 
			echo '- git-deck help bare-play wt' && 
			echo '- git-deck help bp wt' && 
			echo '- git-deck bp help wt' && 
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
		
		#: git-deck sp remotes add <dir-path> <name>:<URL> [<name>:<URL> ...]
		#: git-deck sp remotes rn <dir-path> <name-old>:<name-new> [<name-old>:<name-new> ...]
		#: git-deck sp remotes rm <dir-path> <name> [<name> ...]
		alias rmts=remotes && remotes () 
		(
			case "$1" 
			in 
				(a|add|+)      __cmd_sub__=add     && shift ;;
				(rn|rename|r)  __cmd_sub__=rename  && shift ;;
				(rm|remove|x)  __cmd_sub__=remove  && shift ;;
				(_) 1>&2 echo Unknown sub cmd: "'$1'" && return 16 ;;
			esac && 
			
			_dir_path="${1:-.}" && shift && 
			OPTS_REMOTE="${OPTS_REMOTE:-}" && 
			
			cd "$_dir_path" && 
			
			_param_tools params_roll "$@" | while IFS=: read -r -- a b ;
			do 
				echo :: executing: '`'"git remote ${__cmd_sub__} $OPTS_REMOTE -- ${a} ${b}"'`' at "'${PWD}'" :: && 
				git remote "${__cmd_sub__}" $OPTS_REMOTE -- ${a} ${b} && 
				:; 
			done && 
			(
				echo ::: Current Remotes Show ::: && 
				git remote --verbose show && 
				: ) && 
			# git remote --verbose show | awk -- 'BEGIN { print "::: Current Remotes Show :::" } NR' && 
			echo && 
			: ) && 
		
		
		#: git-deck sp all-sync [<workspace> ...]
		#::	workspace: means the prefix in full name of a repo
		#..	 like it in so many hubs -- <workspace>/<reponame>. In generally
		#;;	 a 'workspace' can be the id-name of a(n) user or org.
		all_sync__helper__ () 
		(
			echo && 
			echo 'Usage:' && 
			echo $'\t' 'git-deck sp all-sync [<workspace> ...]' && 
			echo && 
			echo '... (TODO) ...' && 
			echo && 
			echo 'Demo:' && 
			echo '- git-deck sp all-sync *  # in a dir has only workspace dirs.' && 
			echo '- MAXTRY_ASKING=9 git-deck sp all-sync *  # To taking control if net is not very good.' && 
			echo && 
			echo '... (TODO) ...' && 
			echo && 
			: ) && 
		alias all-sync=all_sync && all_sync () 
		(
			_param_tools params_roll "${@:-.}" | _all_sync && 
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
		
		
		#: git-deck sp base-upgrade [<gitdir-path> ...]
		#: base_upgrade [<gitdir-path> ...]
		#: IS_BARE=true base_upgrade [<gitdir-path> ...]
		#: SHOW_MORE_HINTS=n IS_BARE=y base_upgrade [<gitdir-path> ...]
		alias up=base_upgrade base-upgrade=base_upgrade && base_upgrade () 
		(
			_param_tools params_roll "${@:-.}" | IS_BARE="${IS_BARE:-}" _base_upgrade && 
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
					echo base_up: update from remote for "'${gitdir}'" && 
					while 
					! if ! "${__IS_BARE__}" ;
						then git pull ;
						else bare_play update ;
						# else git remote update ;
					fi ;
					do 
						echo base_up: tried: "$((++try_pull_base_upgrade))" for '`'"$(if ! "${__IS_BARE__}" ;
							then echo "git pull" ;
							else echo "git remote update" ;
						fi)"'`' in "'${gitdir}'" && 
						:; 
					done && 
					echo base_up: updated in "'${gitdir}'" && 
					: ) && 
				:; 
			done && 
			: ) && 
		
		#: Pushing full to a remote.
		#: push_full <git-remote> <git-dir>
		#. push_full "${git_remote}" "${gitdir}"
		#. push_full "${git_remote}" . && 
		#. git-deck sp push-full dr .
		alias push-full=push_full && push_full () 
		(
			local _git_remote="${1:-}" && shift && 
			local _gitdir="${1:-.}" && { shift ; : ; } && 
			cd "${_gitdir}" && 
			# local _symbref_head="$(git symbolic-ref -- HEAD)" && 
			if test -z "${IS_BARE:-}" ;
				then local IS_BARE="$(repo_chk bare . echo)" ;
				else local IS_BARE="${IS_BARE:-}" ;
			fi && 
			eval "$(_cmnd_tools _retry_asking init_codes)" && 
			echo working: push to remote "'${_git_remote}'" for "'$(_cmnd_tools _curr_dir .)'" && 
			while 
			! if ! "${IS_BARE}" && : 其令选行 ;
				then git push "$@" --branches -- "${_git_remote}" ;
				else git push "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' ;
			fi ;
			do 
				: 此下 乃复试探 有询 && 
				: 其尝回显 && 
				1>&2 echo tried: "$((++try_push))" for '`'"$(if ! "${IS_BARE}" && : 其显选出 ;
					then echo "git push $* --branches -- ${_git_remote}" ;
					else echo "git push $* -- ${_git_remote} 'refs/heads/*:refs/heads/*'" ;
				fi)"'`' in "'$(_cmnd_tools _curr_dir .)'" && 
				: 其尝适询 && 
				eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && 
				:; 
			done && 
			echo && 
			: 使其询必曰问之 && 
			: ) 9</dev/tty && 
		
		#: Pulling full from a remote.
		#: pull_full <git-remote> <git-dir>
		#. pull_full "${git_remote}" "${gitdir}"
		#. pull_full "${git_remote}" . && 
		#. git-deck sp pull-full dr .
		alias pull-full=pull_full && pull_full () 
		(
			local _git_remote="${1:-}" && shift && 
			local _gitdir="${1:-.}" && { shift ; : ; } && 
			cd "${_gitdir}" && 
			local _symbref_head="$(git symbolic-ref -- HEAD)" && 
			if test -z "${IS_BARE:-}" ;
				then local IS_BARE="$(repo_chk bare . echo)" ;
				else local IS_BARE="${IS_BARE:-}" ;
			fi && 
			eval "$(_cmnd_tools _retry_asking init_codes)" && 
			echo working: pull from remote "'${_git_remote}'" for "'$(_cmnd_tools _curr_dir .)'" && 
			while 
			! if ! "${IS_BARE}" && : 其令选行 ;
				then git fetch "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' '^'"${_symbref_head}" ;
				else git fetch "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' ;
			fi ;
			do 
				: 此下 乃复试探 有询 && 
				: 其尝回显 && 
				1>&2 echo tried: "$((++try_pull))" for '`'"$(if ! "${IS_BARE}" && : 其显选出 ;
					then echo "git fetch $* -- ${_git_remote} 'refs/heads/*:refs/heads/*' '^${_symbref_head}'" ;
					else echo "git fetch $* -- ${_git_remote} 'refs/heads/*:refs/heads/*'" ;
				fi)"'`' in "'$(_cmnd_tools _curr_dir .)'" && 
				: 其尝适询 && 
				eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && 
				:; 
			done && 
			echo && 
			: 使其询必曰问之 && 
			: ) 9</dev/tty && 
		
		#: git-deck sp all-push [<git-dir> ...]
		alias all-push=all_push && all_push () 
		(
			echo :: pushing origin to all remotes in: "${@:-.}" :: && 
			_param_tools params_roll "${@:-.}" | _all_push ${GITPUSH_FLAGS:--v} && 
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
						push_full "${git_remote}" . && 
						:; 
					done && 
					echo :: pushed all remotes in "'${gitdir}'" :: && 
					: ) && 
				:; 
			done && 
			echo && 
			: ) && 
		
		#: git-deck sp all-pull [<git-dir> ...]
		alias all-pull=all_pull && all_pull () 
		(
			echo :: pulling from origin and all remotes in: "${@:-.}" :: && 
			_param_tools params_roll "${@:-.}" | _all_pull ${GITPULL_FLAGS:--v} && 
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
						pull_full "${git_remote}" . && 
						:; 
					done && 
					echo :: pulled all remotes in "'${gitdir}'" :: && 
					: ) && 
				:; 
			done && 
			echo && 
			: ) && 
		
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

eval "$(SUB_HINTS='git-deck alias(es) here:' EVAL_PLACE=out MARK_MORE=GIT_DECKS PKG_SUBS='libs subs lang' libs subs frames codes_tail)" && 

# : \
git_decks "$@" && :




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
# git config --global -- alias.decks "!/usr/bin/env bash ~/.local/git-deck.sh"

#### demo -----------------------

#|	$ git-deck cp auto-clone https://github.com/LibreService/my_rime.git --mirror
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

#|	$ git-deck cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
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

#|	$ git-deck bare-play up
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


#|	$ git-deck help cp ac
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
#|	your command: cp ac
#|	
#|	Usage:
#|		 git-deck cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]
#|	
#|	This tool is for when you having a bad internet to your
#|	 remote repo. It will making a depth=1 shallow clone at the
#|	 first and then unshallow it, also at the end update it once
#|	 to make your local repo sync the newest records as far as it could.
#|	 All of the downloading works can auto-retry while it failed.
#|	
#|	Demo:
#|	- git-deck cp auto-clone https://github.com/LibreService/my_rime.git --mirror
#|	- git-deck cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
#|	- git-deck cp auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git
#|	- git-deck cp auto-clone --mirror -- https://github.com/crynta/terax-ai.git
#|	- git-deck cp auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass
#|	
#|	See help:
#|	- git-deck help cp auto-clone
#|	- git-deck help cp ac
#|	- git-deck cp help ac
#|	

#|	$ git-deck help bare-play up
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
#|	your command: bare-play up
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
#|	- git-deck bare-play up
#|	- git-deck bare-play up origin
#|	- git-deck bare-play up github
#|	- git-deck bare-play up disroot
#|	
#|	See help:
#|	- git-deck help bare-play update
#|	- git-deck help bare-play up
#|	- git-deck help bp up
#|	- git-deck bp help up
#|	

#|	$ git-deck help bp up
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
#|	your command: bp up
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
#|	- git-deck bare-play up
#|	- git-deck bare-play up origin
#|	- git-deck bare-play up github
#|	- git-deck bare-play up disroot
#|	
#|	See help:
#|	- git-deck help bare-play update
#|	- git-deck help bare-play up
#|	- git-deck help bp up
#|	- git-deck bp help up
#|	

#|	$ git-deck help bp wt
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
#|	your command: bp wt
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
#|	- git-deck bare-play worktree add tree master
#|	- git-deck bare-play worktree rm tree master
#|	- git-deck bare-play worktree add tags v1.0.1
#|	- git-deck bare-play worktree rm tags v1.0.1
#|	- git-deck bare-play wt a tags v1.16.1
#|	- git-deck bare-play wt a tree master
#|	
#|	See help:
#|	- git-deck help bare-play worktree
#|	- git-deck help bare-play wt
#|	- git-deck help bp wt
#|	- git-deck bp help wt
#|	

#|	$ git-deck bp wt a tags v1.61.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	error: malformed object name v1.61.1
#|	$ echo $?
#|	129

#|	$ CHOOSE_MODE=All git-deck bp wt a tags v1.16.1
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
#|	$ CHOOSE_MODE=All git-deck bp wt x tags v1.16.1
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

#|	$ CHOOSE_MODE=Only git-deck bp wt a tags v1.16.1
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
#|	$ git-deck bp wt a tree master
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained branches:
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at f25fc7b4 fix: restore clip flag through fuzzy search in show command (#3466)
#|	../tree/master/

#|	$ git-deck bp help wt
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	sub command(s) here:
#|	- sub-help: means 'aliases'.
#|	- up: means 'update'.
#|	- wt: means 'worktree'.
#|	
#|	your command: wt
#|	
#|	Using for create/delete worktree(s) of bare repo. It will
#|	 search from branches/tags then run worktree add/remove to those object(s)
#|	
#|	Bare dir here MUST in a special named dir like: 'name.comments-src', then:
#|	- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
#|	- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'
#|	
#|	Demo:
#|	- git-deck bare-play worktree add tree master
#|	- git-deck bare-play worktree rm tree master
#|	- git-deck bare-play worktree add tags v1.0.1
#|	- git-deck bare-play worktree rm tags v1.0.1
#|	- git-deck bare-play wt a tags v1.16.1
#|	- git-deck bare-play wt a tree master
#|	
#|	See help:
#|	- git-deck help bare-play worktree
#|	- git-deck help bare-play wt
#|	- git-deck help bp wt
#|	- git-deck bp help wt
#|	

#|	$ git-deck bp wt a tree master
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

#|	$ git-deck ac https://github.com/t8y2/dbx.git --mirror
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
#|	$ git-deck bp wt a tags v0.5.41
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
#|	$ git-deck bp wt a tree main
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
#|	$ git-deck bp wt x tree main
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained branches:
#|	-	main
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree remove ../tree/main ::
#|	ls: cannot access '../tree/*': No such file or directory

#|	$ git-deck bp wt a tags v3.1.5
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

#|	$ . ~/git-deck.sh && git-deck sp all-sync
#|	:: pulling from origin and all remotes in: ./pure.lexicals/ ::
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is inside worktree ~ true
#|	repochk: `/mnt/e/repos-testing/pure.lexicals` is bare repository ~ false
#|	base_up: update from remote for './pure.lexicals/'
#|	remote: Enumerating objects: 39, done.
#|	remote: Counting objects: 100% (39/39), done.
#|	remote: Compressing objects: 100% (28/28), done.
#|	remote: Total 28 (delta 18), reused 0 (delta 0), pack-reused 0 (from 0)
#|	Unpacking objects: 100% (28/28), 6.46 KiB | 2.00 KiB/s, done.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	   d536247..8fbcd08  main       -> origin/main
#|	Updating d536247..8fbcd08
#|	Fast-forward
#|	 .notes/sh3rrs/Subs/.demo/git-deck.sh               | 90 ++++++++++++++--------
#|	 .../readme"                                        | 16 +++-
#|	 2 files changed, 75 insertions(+), 31 deletions(-)
#|	base_up: updated in './pure.lexicals/'
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
#|	base_up: update from remote for './pure.lexicals/'
#|	Already up to date.
#|	base_up: updated in './pure.lexicals/'
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
#|	base_up: update from remote for './pure.lexicals.git/'
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
#|	base_up: updated in './pure.lexicals.git/'
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
#|	base_up: update from remote for './pure.lexicals.git/'
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 + 8fbcd08...d89077d disroot/main -> disroot/main  (forced update)
#|	Fetching disroot
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	   d89077d..8fbcd08  main       -> disroot/main
#|	Fetching dr
#|	base_up: updated in './pure.lexicals.git/'
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

#|	$ git-deck help
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

#|	$ gd help
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

#|	$ git-deck help git-deck
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
#|	your command: git-deck
#|	
#|	The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-deck help
#|	- git-deck help git-deck
#|	- git-deck help gd
#|	- help git-deck
#|	- help gd
#|	

#|	$ help git-deck
#|	sub command(s) here:
#|	- gd: means 'git_decks'.
#|	- git-deck: means 'git_decks'.
#|	- git-decks: means 'git_decks'.
#|	
#|	your command: git-deck
#|	
#|	The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-deck help
#|	- git-deck help git-deck
#|	- git-deck help gd
#|	- help git-deck
#|	- help gd
#|	

#|	$ help gd
#|	sub command(s) here:
#|	- gd: means 'git_decks'.
#|	- git-deck: means 'git_decks'.
#|	- git-decks: means 'git_decks'.
#|	
#|	your command: gd
#|	
#|	The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-deck help
#|	- git-deck help git-deck
#|	- git-deck help gd
#|	- help git-deck
#|	- help gd
#|	

#|	$ . ~/git-deck.sh ; help git-deck
#|	sub command(s) here:
#|	- gd: means 'git_decks'.
#|	- git-deck: means 'git_decks'.
#|	- git-decks: means 'git_decks'.
#|	
#|	your command: git-deck
#|	
#|	The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs.
#|	 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
#|	 as function with a helpdocs feature supported.
#|	
#|	See help:
#|	- git-deck help
#|	- git-deck help git-deck
#|	- git-deck help gd
#|	- help git-deck
#|	- help gd
#|	
#|	$ . ~/git-deck.sh && help :
#|	:: :
#|		Null command.
#|		
#|		No effect; the command does nothing.
#|		
#|		Exit Status:
#|		Always succeeds.
#|	$ . ~/git-deck.sh ; help true ; help false
#|	true: true
#|		Return a successful result.
#|		
#|		Exit Status:
#|		Always succeeds.
#|	false: false
#|		Return an unsuccessful result.
#|		
#|		Exit Status:
#|		Always fails.

#|	$ . ~/git-deck.sh && OPTS_CLONE=--bare git-deck cp m . mabin.sp-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git pure.lexi-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git :https://github.com/yhm-amber/lang-note.git
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/mabynogion.spells.git' mabin.sp-src/mabynogion.spells.git` in '/mnt/e/repos' ::
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
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../mabin.sp-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `mabin.sp-src/mabynogion.spells.git`. ::
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/pure.lexicals.git' pure.lexi-src/pure.lexicals.git` in '/mnt/e/repos' ::
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
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.lexi-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `pure.lexi-src/pure.lexicals.git`. ::
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/lang-note.git' ` in '/mnt/e/repos' ::
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
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/e/repos/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../test/lang-note.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `lang-note.git`. ::


#|	$ MAXTRY_ASKING=999 git-deck cp a https://github.com/denoland/deno.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'deno.git'...
#|	remote: Enumerating objects: 307976, done.
#|	remote: Counting objects: 100% (307976/307976), done.
#|	remote: Compressing objects: 100% (107364/107364), done.
#|	remote: Total 307976 (delta 235908), reused 263503 (delta 195704), pack-reused 0 (from 0)
#|	Receiving objects: 100% (307976/307976), 276.69 MiB | 7.17 MiB/s, done.
#|	Resolving deltas: 100% (235908/235908), done.
#|	Checking connectivity: 307976, done.
#|	:: change workdir to `deno.git` from `/e/iso/deno.denoland.esrt-src` to unshallow fetch ::
#|	:: unshallowing in `/e/iso/deno.denoland.esrt-src/deno.git` ::
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is shallow repository ~ true
#|	remote: Enumerating objects: 460792, done.
#|	remote: Counting objects: 100% (428882/428882), done.
#|	remote: Compressing objects: 100% (234923/234923), done.
#|	remote: Total 422883 (delta 312266), reused 285553 (delta 185975), pack-reused 0 (from 0)
#|	Receiving objects: 100% (422883/422883), 162.64 MiB | 5.07 MiB/s, done.
#|	Resolving deltas: 100% (312266/312266), completed with 3367 local objects.
#|	:: updating in `/e/iso/deno.denoland.esrt-src/deno.git` ::
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is inside worktree ~ false
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is inside gitdir ~ true
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	base_upgrade: update from remote for '.'
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	error: RPC failed; curl 56 Recv failure: Connection was reset
#|	error: 19 bytes of body are still expected
#|	fatal: expected flush after ref listing
#|	tried: 1 for remote update
#|	upper: updated in '.../deno.denoland.esrt-src/deno.git' for remote(s)
#|	base_upgrade: updated in '.'
#|	:: done for repo `deno.git`. ::
#|	
#|	$ (cd deno.git && git-deck bp wts i tree:main tags:v2.9.2)
#|	repochk: `/e/iso/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tree main` at '/e/iso/deno.denoland.esrt-src/deno.git' ::
#|	Contained branches:
#|	-	feat/check-native-tsc
#|	-	feat/graph-aware-lint
#|	-	feat/read-confine-default
#|	-	feat/write-confine-default
#|	-	main
#|	-	prototype/resource-limit-flags
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree add ../tree/main main ::
#|	Preparing worktree (checking out 'main')
#|	Updating files: 100% (14505/14505), done.
#|	HEAD is now at 786457cc2b feat: support sync-types without node_modules (#35966)
#|	../tree/main/
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tags v2.9.2` at '/e/iso/deno.denoland.esrt-src/deno.git' ::
#|	Contained tags:
#|	-	v2.9.2
#|	Choosed tags (choose mode: Only):
#|	-	v2.9.2
#|	:: executing: worktree add ../tags/v2.9.2 v2.9.2 ::
#|	Preparing worktree (detached HEAD 356c132ed6)
#|	Updating files: 100% (14484/14484), done.
#|	HEAD is now at 356c132ed6 2.9.2 (#35865)
#|	../tags/v2.9.2/

#|	$ MAXTRY_ASKING=999 git-deck cp a https://github.com/osquery/osquery.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'osquery.git'...
#|	fatal: unable to access 'https://github.com/osquery/osquery.git/': Recv failure: Connection was reset
#|	tried: 1 for clone
#|	:: try-asking: rested times of push trying: 999.
#|	:: try-asking: Then: 998
#|	Cloning into bare repository 'osquery.git'...
#|	remote: Enumerating objects: 81081, done.
#|	remote: Counting objects: 100% (81081/81081), done.
#|	remote: Compressing objects: 100% (28884/28884), done.
#|	remote: Total 81081 (delta 58491), reused 70239 (delta 49348), pack-reused 0 (from 0)
#|	Receiving objects: 100% (81081/81081), 31.19 MiB | 54.00 KiB/s, done.
#|	Resolving deltas: 100% (58491/58491), done.
#|	:: change workdir to `osquery.git` from `/e/iso/osquery.sqlsys-src` to unshallow fetch ::
#|	:: unshallowing in `/e/iso/osquery.sqlsys-src/osquery.git` ::
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is shallow repository ~ true
#|	remote: Enumerating objects: 77356, done.
#|	remote: Counting objects: 100% (67172/67172), done.
#|	remote: Compressing objects: 100% (36521/36521), done.
#|	remote: Total 65379 (delta 45613), reused 44511 (delta 27465), pack-reused 0 (from 0)
#|	Receiving objects: 100% (65379/65379), 12.23 MiB | 2.53 MiB/s, done.
#|	Resolving deltas: 100% (45613/45613), completed with 1095 local objects.
#|	:: updating in `/e/iso/osquery.sqlsys-src/osquery.git` ::
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is inside worktree ~ false
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is inside gitdir ~ true
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	upper: updated in '.../osquery.sqlsys-src/osquery.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `osquery.git`. ::
#|	
#|	$ (cd osquery.git && git-deck bp wts i tree:master tags:5.23.1)
#|	repochk: `/e/iso/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tree master` at '/e/iso/osquery.sqlsys-src/osquery.git' ::
#|	Contained branches:
#|	-	master
#|	Choosed branches (choose mode: Only):
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (2602/2602), done.
#|	HEAD is now at bf007af07 Update GitHub Actions caching strategy (#8866)
#|	../tree/master/
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tags 5.23.1` at '/e/iso/osquery.sqlsys-src/osquery.git' ::
#|	Contained tags:
#|	-	5.23.1
#|	Choosed tags (choose mode: Only):
#|	-	5.23.1
#|	:: executing: worktree add ../tags/5.23.1 5.23.1 ::
#|	Preparing worktree (detached HEAD b7538338f)
#|	Updating files: 100% (2651/2651), done.
#|	HEAD is now at b7538338f Preserve object identifiers in Windows certificates table via subject2/issuer2 (#8963)
#|	../tags/5.23.1/

#.	cd -- /mnt/.repo-syncs
#.	ASKING_MAXTRY=9999 OPTS_CLONE=--bare git-deck cp m . \
#.		mabin.ls-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git \
#.		pure.yph-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git \
#.		pure.symb-grp/pure-symbols.git:https://github.com/pure-symbols/.github.git \
#.		contain.note-src/container-note.git:https://github.com/yhm-amber/container-note.git \
#.		lang.note-src/lang-note.git:https://github.com/yhm-amber/lang-note.git \
#.		sh3rr.sh-src/sh3rr.git:https://github.com/yhm-amber/sh3rr.git \
#.		yph.m-grp/yhm-amber.git:https://github.com/yhm-amber/yhm-amber.git
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/mabynogion.spells.git' mabin.ls-src/mabynogion.spells.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 1 for clone
#|	:: try-asking: rested times of push trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 2 for clone
#|	:: try-asking: rested times of push trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 3 for clone
#|	:: try-asking: rested times of push trying: 9997.
#|	:: try-asking: Then: 9996
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 4 for clone
#|	:: try-asking: rested times of push trying: 9996.
#|	:: try-asking: Then: 9995
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21328 ms: Could not connect to server
#|	tried: 5 for clone
#|	:: try-asking: rested times of push trying: 9995.
#|	:: try-asking: Then: 9994
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21298 ms: Could not connect to server
#|	tried: 6 for clone
#|	:: try-asking: rested times of push trying: 9994.
#|	:: try-asking: Then: 9993
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	remote: Enumerating objects: 80, done.
#|	remote: Counting objects: 100% (80/80), done.
#|	remote: Compressing objects: 100% (73/73), done.
#|	remote: Total 80 (delta 0), reused 38 (delta 0), pack-reused 0 (from 0)
#|	Receiving objects: 100% (80/80), 68.97 KiB | 140.00 KiB/s, done.
#|	:: change workdir to `mabin.ls-src/mabynogion.spells.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` ::
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is shallow repository ~ true
#|	remote: Enumerating objects: 710, done.
#|	remote: Counting objects: 100% (710/710), done.
#|	remote: Compressing objects: 100% (387/387), done.
#|	remote: Total 645 (delta 381), reused 455 (delta 248), pack-reused 0 (from 0)
#|	Receiving objects: 100% (645/645), 171.43 KiB | 62.00 KiB/s, done.
#|	Resolving deltas: 100% (381/381), completed with 54 local objects.
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` ::
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `mabin.ls-src/mabynogion.spells.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/pure.lexicals.git' pure.yph-src/pure.lexicals.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'pure.yph-src/pure.lexicals.git'...
#|	remote: Enumerating objects: 972, done.
#|	remote: Counting objects: 100% (972/972), done.
#|	remote: Compressing objects: 100% (728/728), done.
#|	remote: Total 972 (delta 11), reused 904 (delta 9), pack-reused 0 (from 0)
#|	Receiving objects: 100% (972/972), 50.83 MiB | 326.00 KiB/s, done.
#|	Resolving deltas: 100% (11/11), done.
#|	:: change workdir to `pure.yph-src/pure.lexicals.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` ::
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is shallow repository ~ true
#|	remote: Enumerating objects: 13770, done.
#|	remote: Counting objects: 100% (13770/13770), done.
#|	remote: Compressing objects: 100% (4325/4325), done.
#|	remote: Total 13398 (delta 8528), reused 13080 (delta 8304), pack-reused 0 (from 0)
#|	Receiving objects: 100% (13398/13398), 10.45 MiB | 4.16 MiB/s, done.
#|	Resolving deltas: 100% (8528/8528), completed with 182 local objects.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` ::
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/pure-symbols/pure.lexicals.git/': Failed to connect to github.com port 443 after 22344 ms: Could not connect to server
#|	tried: 1 for remote update
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `pure.yph-src/pure.lexicals.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/.github.git' pure.symb-grp/pure-symbols.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'pure.symb-grp/pure-symbols.git'...
#|	remote: Enumerating objects: 87, done.
#|	remote: Counting objects: 100% (87/87), done.
#|	remote: Compressing objects: 100% (75/75), done.
#|	remote: Total 87 (delta 1), reused 53 (delta 1), pack-reused 0 (from 0)
#|	Receiving objects: 100% (87/87), 239.55 KiB | 45.00 KiB/s, done.
#|	Resolving deltas: 100% (1/1), done.
#|	:: change workdir to `pure.symb-grp/pure-symbols.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` ::
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is shallow repository ~ true
#|	remote: Enumerating objects: 487, done.
#|	remote: Counting objects: 100% (487/487), done.
#|	remote: Compressing objects: 100% (350/350), done.
#|	remote: Total 466 (delta 162), reused 324 (delta 99), pack-reused 0 (from 0)
#|	Receiving objects: 100% (466/466), 95.89 KiB | 40.00 KiB/s, done.
#|	Resolving deltas: 100% (162/162), completed with 9 local objects.
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` ::
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/pure-symbols/.github.git/': Recv failure: Connection was reset
#|	tried: 1 for remote update
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `pure.symb-grp/pure-symbols.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/container-note.git' contain.note-src/container-note.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'contain.note-src/container-note.git'...
#|	remote: Enumerating objects: 5289, done.
#|	remote: Counting objects: 100% (5289/5289), done.
#|	remote: Compressing objects: 100% (2879/2879), done.
#|	remote: Total 5289 (delta 496), reused 5053 (delta 480), pack-reused 0 (from 0)
#|	Receiving objects: 100% (5289/5289), 433.33 MiB | 3.72 MiB/s, done.
#|	Resolving deltas: 100% (496/496), done.
#|	:: change workdir to `contain.note-src/container-note.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/contain.note-src/container-note.git` ::
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21398 ms: Could not connect to server
#|	tried: 2 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21288 ms: Could not connect to server
#|	tried: 3 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21389 ms: Could not connect to server
#|	tried: 4 for unshallow
#|	remote: Enumerating objects: 25048, done.
#|	remote: Counting objects: 100% (24991/24991), done.
#|	remote: Compressing objects: 100% (9032/9032), done.
#|	remote: Total 24321 (delta 13392), reused 23417 (delta 13056), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24321/24321), 33.07 MiB | 69.00 KiB/s, done.
#|	Resolving deltas: 100% (13392/13392), completed with 163 local objects.
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/contain.note-src/container-note.git` ::
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Empty reply from server
#|	tried: 1 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21338 ms: Could not connect to server
#|	tried: 2 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21581 ms: Could not connect to server
#|	tried: 3 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 4 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 5 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21384 ms: Could not connect to server
#|	tried: 6 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 7 for remote update
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `contain.note-src/container-note.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/lang-note.git' lang.note-src/lang-note.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Failed to connect to github.com port 443 after 21339 ms: Could not connect to server
#|	tried: 1 for clone
#|	:: try-asking: rested times of push trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Failed to connect to github.com port 443 after 21365 ms: Could not connect to server
#|	tried: 2 for clone
#|	:: try-asking: rested times of push trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	remote: Enumerating objects: 279, done.
#|	remote: Counting objects: 100% (279/279), done.
#|	remote: Compressing objects: 100% (215/215), done.
#|	remote: Total 279 (delta 8), reused 239 (delta 4), pack-reused 0 (from 0)
#|	Receiving objects: 100% (279/279), 839.97 KiB | 360.00 KiB/s, done.
#|	Resolving deltas: 100% (8/8), done.
#|	:: change workdir to `lang.note-src/lang-note.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/lang.note-src/lang-note.git` ::
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Empty reply from server
#|	tried: 1 for unshallow
#|	remote: Enumerating objects: 4129, done.
#|	remote: Counting objects: 100% (4129/4129), done.
#|	remote: Compressing objects: 100% (1614/1614), done.
#|	remote: Total 3974 (delta 2306), reused 3772 (delta 2184), pack-reused 0 (from 0)
#|	Receiving objects: 100% (3974/3974), 750.11 KiB | 1004.00 KiB/s, done.
#|	Resolving deltas: 100% (2306/2306), completed with 102 local objects.
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/lang.note-src/lang-note.git` ::
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `lang.note-src/lang-note.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/sh3rr.git' sh3rr.sh-src/sh3rr.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21353 ms: Could not connect to server
#|	tried: 1 for clone
#|	:: try-asking: rested times of push trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21335 ms: Could not connect to server
#|	tried: 2 for clone
#|	:: try-asking: rested times of push trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21329 ms: Could not connect to server
#|	tried: 3 for clone
#|	:: try-asking: rested times of push trying: 9997.
#|	:: try-asking: Then: 9996
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21294 ms: Could not connect to server
#|	tried: 4 for clone
#|	:: try-asking: rested times of push trying: 9996.
#|	:: try-asking: Then: 9995
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	remote: Enumerating objects: 58, done.
#|	remote: Counting objects: 100% (58/58), done.
#|	remote: Compressing objects: 100% (43/43), done.
#|	remote: Total 58 (delta 2), reused 19 (delta 2), pack-reused 0 (from 0)
#|	Receiving objects: 100% (58/58), 145.25 KiB | 454.00 KiB/s, done.
#|	Resolving deltas: 100% (2/2), done.
#|	:: change workdir to `sh3rr.sh-src/sh3rr.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` ::
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is shallow repository ~ true
#|	remote: Enumerating objects: 1116, done.
#|	remote: Counting objects: 100% (1116/1116), done.
#|	remote: Compressing objects: 100% (658/658), done.
#|	remote: Total 1075 (delta 489), reused 838 (delta 340), pack-reused 0 (from 0)
#|	Receiving objects: 100% (1075/1075), 234.76 KiB | 423.00 KiB/s, done.
#|	Resolving deltas: 100% (489/489), completed with 21 local objects.
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` ::
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21309 ms: Could not connect to server
#|	tried: 1 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21384 ms: Could not connect to server
#|	tried: 2 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21288 ms: Could not connect to server
#|	tried: 3 for remote update
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `sh3rr.sh-src/sh3rr.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/yhm-amber.git' yph.m-grp/yhm-amber.git` at '/e/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'yph.m-grp/yhm-amber.git'...
#|	remote: Enumerating objects: 137, done.
#|	remote: Counting objects: 100% (137/137), done.
#|	remote: Compressing objects: 100% (110/110), done.
#|	remote: Total 137 (delta 7), reused 113 (delta 7), pack-reused 0 (from 0)
#|	Receiving objects: 100% (137/137), 50.69 MiB | 76.00 KiB/s, done.
#|	Resolving deltas: 100% (7/7), done.
#|	:: change workdir to `yph.m-grp/yhm-amber.git` from `/e/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/e/repos/.syncing/yph.m-grp/yhm-amber.git` ::
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Recv failure: Connection was reset
#|	tried: 2 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21366 ms: Could not connect to server
#|	tried: 3 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21260 ms: Could not connect to server
#|	tried: 4 for unshallow
#|	remote: Enumerating objects: 2631, done.
#|	remote: Counting objects: 100% (2631/2631), done.
#|	remote: Compressing objects: 100% (872/872), done.
#|	remote: Total 2579 (delta 1460), reused 2518 (delta 1413), pack-reused 0 (from 0)
#|	Receiving objects: 100% (2579/2579), 526.21 KiB | 285.00 KiB/s, done.
#|	Resolving deltas: 100% (1460/1460), completed with 33 local objects.
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/e/repos/.syncing/yph.m-grp/yhm-amber.git` ::
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21359 ms: Could not connect to server
#|	tried: 1 for remote update
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `yph.m-grp/yhm-amber.git`. ::
#|	


#.	git-deck sp rmts a mabin.ls-src/mabynogion.spells.git \
#.		gh:https://github.com/pure-symbols/mabynogion.spells.git \
#.		cb:https://codeberg.org/pure-symbols/mabynogion.spells.git \
#.		dr:https://git.disroot.org/pure.symbols/mabynogion.spells.git \
#.		fr:https://framagit.org/pure.symbols/mabynogion.spells.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/mabynogion.spells.git` at '/mnt/.repo-syncs/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/mabynogion.spells.git` at '/mnt/.repo-syncs/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/mabynogion.spells.git` at '/mnt/.repo-syncs/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/mabynogion.spells.git` at '/mnt/.repo-syncs/mabin.ls-src/mabynogion.spells.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (push)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (push)
#|	fr      https://framagit.org/pure.symbols/mabynogion.spells.git (fetch)
#|	fr      https://framagit.org/pure.symbols/mabynogion.spells.git (push)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (push)

#.	git-deck sp rmts a pure.yph-src/pure.lexicals.git \
#.		gh:https://github.com/pure-symbols/pure.lexicals.git \
#.		cb:https://codeberg.org/pure-symbols/pure.lexicals.git \
#.		dr:https://git.disroot.org/pure.symbols/pure.lexicals.git \
#.		fr:https://framagit.org/pure.symbols/pure.lexicals.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/pure.lexicals.git` at '/mnt/.repo-syncs/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/pure.lexicals.git` at '/mnt/.repo-syncs/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/pure.lexicals.git` at '/mnt/.repo-syncs/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/pure.lexicals.git` at '/mnt/.repo-syncs/pure.yph-src/pure.lexicals.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (push)
#|	fr      https://framagit.org/pure.symbols/pure.lexicals.git (fetch)
#|	fr      https://framagit.org/pure.symbols/pure.lexicals.git (push)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (push)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (push)

#.	git-deck sp rmts a pure.symb-grp/pure-symbols.git \
#.		gh:https://github.com/pure-symbols/.github.git \
#.		cb:https://codeberg.org/pure-symbols/pure.symbols.git \
#.		dr:https://git.disroot.org/pure.symbols/pure.symbols.git \
#.		fr:https://framagit.org/pure.symbols/pure.symbols.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/.github.git` at '/mnt/.repo-syncs/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/pure.symbols.git` at '/mnt/.repo-syncs/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/pure.symbols.git` at '/mnt/.repo-syncs/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/pure.symbols.git` at '/mnt/.repo-syncs/pure.symb-grp/pure-symbols.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (push)
#|	fr      https://framagit.org/pure.symbols/pure.symbols.git (fetch)
#|	fr      https://framagit.org/pure.symbols/pure.symbols.git (push)
#|	gh      https://github.com/pure-symbols/.github.git (fetch)
#|	gh      https://github.com/pure-symbols/.github.git (push)
#|	origin  https://github.com/pure-symbols/.github.git (fetch)
#|	origin  https://github.com/pure-symbols/.github.git (push)

#.	git-deck sp rmts a contain.note-src/container-note.git \
#.		gh:https://github.com/yhm-amber/container-note.git \
#.		cb:https://codeberg.org/yhm-ypa/container-note.git \
#.		dr:https://git.disroot.org/ypayhm/container-note.git \
#.		fr:https://framagit.org/ypayhm/container-note.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/container-note.git` at '/mnt/.repo-syncs/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/container-note.git` at '/mnt/.repo-syncs/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/container-note.git` at '/mnt/.repo-syncs/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/container-note.git` at '/mnt/.repo-syncs/contain.note-src/container-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (push)
#|	fr      https://framagit.org/ypayhm/container-note.git (fetch)
#|	fr      https://framagit.org/ypayhm/container-note.git (push)
#|	gh      https://github.com/yhm-amber/container-note.git (fetch)
#|	gh      https://github.com/yhm-amber/container-note.git (push)
#|	origin  https://github.com/yhm-amber/container-note.git (fetch)
#|	origin  https://github.com/yhm-amber/container-note.git (push)

#.	git-deck sp rmts a lang.note-src/lang-note.git \
#.		gh:https://github.com/yhm-amber/lang-note.git \
#.		cb:https://codeberg.org/yhm-ypa/lang-note.git \
#.		dr:https://git.disroot.org/ypayhm/lang-note.git \
#.		fr:https://framagit.org/ypayhm/lang-note.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/lang-note.git` at '/mnt/.repo-syncs/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/lang-note.git` at '/mnt/.repo-syncs/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/lang-note.git` at '/mnt/.repo-syncs/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/lang-note.git` at '/mnt/.repo-syncs/lang.note-src/lang-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (push)
#|	fr      https://framagit.org/ypayhm/lang-note.git (fetch)
#|	fr      https://framagit.org/ypayhm/lang-note.git (push)
#|	gh      https://github.com/yhm-amber/lang-note.git (fetch)
#|	gh      https://github.com/yhm-amber/lang-note.git (push)
#|	origin  https://github.com/yhm-amber/lang-note.git (fetch)
#|	origin  https://github.com/yhm-amber/lang-note.git (push)

#.	git-deck sp rmts a sh3rr.sh-src/sh3rr.git \
#.		gh:https://github.com/yhm-amber/sh3rr.git \
#.		cb:https://codeberg.org/yhm-ypa/sh3rr.git \
#.		dr:https://git.disroot.org/ypayhm/sh3rr.git \
#.		fr:https://framagit.org/ypayhm/sh3rr.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/sh3rr.git` at '/mnt/.repo-syncs/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/sh3rr.git` at '/mnt/.repo-syncs/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/sh3rr.git` at '/mnt/.repo-syncs/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/sh3rr.git` at '/mnt/.repo-syncs/sh3rr.sh-src/sh3rr.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (push)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (push)
#|	fr      https://framagit.org/ypayhm/sh3rr.git (fetch)
#|	fr      https://framagit.org/ypayhm/sh3rr.git (push)
#|	gh      https://github.com/yhm-amber/sh3rr.git (fetch)
#|	gh      https://github.com/yhm-amber/sh3rr.git (push)
#|	origin  https://github.com/yhm-amber/sh3rr.git (fetch)
#|	origin  https://github.com/yhm-amber/sh3rr.git (push)

#.	git-deck sp rmts a yph.m-grp/yhm-amber.git \
#.		gh:https://github.com/yhm-amber/yhm-amber.git \
#.		cb:https://codeberg.org/yhm-ypa/yhm-ypa.git \
#.		dr:https://git.disroot.org/ypayhm/ypayhm.git \
#.		fr:https://framagit.org/ypayhm/ypayhm.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/yhm-amber.git` at '/mnt/.repo-syncs/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/yhm-ypa.git` at '/mnt/.repo-syncs/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/ypayhm.git` at '/mnt/.repo-syncs/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/ypayhm.git` at '/mnt/.repo-syncs/yph.m-grp/yhm-amber.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (push)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (push)
#|	fr      https://framagit.org/ypayhm/ypayhm.git (fetch)
#|	fr      https://framagit.org/ypayhm/ypayhm.git (push)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (push)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (push)

#|	$ git-deck sp all-sync *
#|	:: pulling from origin and all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch gh
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/container-note
#|	 * [new branch]        main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/container-note
#|	 * [new branch]        main       -> dr/main
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21371 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 1 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/container-note
#|	 * [new branch]        main       -> gh/main
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21338 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 2 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21272 ms: Could not connect to server
#|	error: could not fetch gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21664 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 3 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21295 ms: Could not connect to server
#|	error: could not fetch gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21316 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 4 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21289 ms: Could not connect to server
#|	error: could not fetch origin
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21352 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 5 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21341 ms: Could not connect to server
#|	error: could not fetch origin
#|	Fetching gh
#| ^C


#.	git-deck sp rmts x mabin.ls-src/mabynogion.spells.git fr
#.	git-deck sp rmts x pure.yph-src/pure.lexicals.git fr
#.	git-deck sp rmts x pure.symb-grp/pure-symbols.git fr
#.	git-deck sp rmts x contain.note-src/container-note.git fr
#.	git-deck sp rmts x lang.note-src/lang-note.git fr
#.	git-deck sp rmts x sh3rr.sh-src/sh3rr.git fr
#.	git-deck sp rmts x yph.m-grp/yhm-amber.git fr
#.	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (push)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (push)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (push)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (push)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (push)
#|	gh      https://github.com/pure-symbols/.github.git (fetch)
#|	gh      https://github.com/pure-symbols/.github.git (push)
#|	origin  https://github.com/pure-symbols/.github.git (fetch)
#|	origin  https://github.com/pure-symbols/.github.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/contain.note-src/container-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (push)
#|	gh      https://github.com/yhm-amber/container-note.git (fetch)
#|	gh      https://github.com/yhm-amber/container-note.git (push)
#|	origin  https://github.com/yhm-amber/container-note.git (fetch)
#|	origin  https://github.com/yhm-amber/container-note.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/lang.note-src/lang-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (push)
#|	gh      https://github.com/yhm-amber/lang-note.git (fetch)
#|	gh      https://github.com/yhm-amber/lang-note.git (push)
#|	origin  https://github.com/yhm-amber/lang-note.git (fetch)
#|	origin  https://github.com/yhm-amber/lang-note.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (push)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (push)
#|	gh      https://github.com/yhm-amber/sh3rr.git (fetch)
#|	gh      https://github.com/yhm-amber/sh3rr.git (push)
#|	origin  https://github.com/yhm-amber/sh3rr.git (fetch)
#|	origin  https://github.com/yhm-amber/sh3rr.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/e/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (push)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (push)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (push)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (push)
#|	

#|	$ git-deck sp all-sync *
#|	:: pulling from origin and all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_upgrade: updated in 'contain.note-src/container-note.git/'
#|	:: pulling all remotes in 'contain.note-src/container-note.git/' ::
#|	working: pull from remote 'cb' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/container-note
#|	 ! [rejected]          main       -> main  (non-fast-forward)
#|	 = [up to date]        main       -> cb/main
#|	tried: 1 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'contain.note-src/container-note.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	:: try-asking: rested times of push trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'dr' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/container-note
#|	 ! [rejected]          main       -> main  (non-fast-forward)
#|	 = [up to date]        main       -> dr/main
#|	tried: 2 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'contain.note-src/container-note.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	:: try-asking: rested times of push trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'gh' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/container-note
#|	 = [up to date]        main       -> main
#|	 = [up to date]        main       -> gh/main
#|	working: pull from remote 'origin' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/container-note
#|	 = [up to date]        main       -> main
#|	:: pulled all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/e/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_upgrade: updated in 'contain.note-src/container-note.git/'
#|	:: pushing all remotes in 'contain.note-src/container-note.git/' ::
#|	working: push to remote 'cb' for 'contain.note-src/container-note.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/container-note.git
#|	warning: auto-detection of host provider took too long (>2000ms)
#|	warning: see https://aka.ms/gcm/autodetect for more information.
#|	Enumerating objects: 325, done.
#|	Counting objects: 100% (325/325), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (141/141), done.
#|	Writing objects: 100% (297/297), 3.93 MiB | 8.04 MiB/s, done.
#|	Total 297 (delta 131), reused 280 (delta 114), pack-reused 0 (from 0)
#|	POST git-receive-pack (4118766 bytes)
#|	remote: Resolving deltas: 100% (131/131), completed with 10 local objects.
#|	To https://codeberg.org/yhm-ypa/container-note.git
#|	   5c573333..45e4dae0  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	working: push to remote 'dr' for 'contain.note-src/container-note.git/'
#|	Pushing to https://git.disroot.org/ypayhm/container-note.git
#|	Enumerating objects: 325, done.
#|	Counting objects: 100% (325/325), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (141/141), done.
#|	Writing objects: 100% (297/297), 3.93 MiB | 46.77 MiB/s, done.
#|	Total 297 (delta 131), reused 280 (delta 114), pack-reused 0 (from 0)
#|	POST git-receive-pack (4118766 bytes)
#|	remote: Resolving deltas: 100% (131/131), completed with 10 local objects.
#|	remote: Checking connectivity: 296, done.
#|	To https://git.disroot.org/ypayhm/container-note.git
#|	   5c573333..45e4dae0  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	working: push to remote 'gh' for 'contain.note-src/container-note.git/'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'contain.note-src/container-note.git/'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/lang-note
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/lang-note
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/lang-note
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pulling all remotes in 'lang.note-src/lang-note.git/' ::
#|	working: pull from remote 'cb' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/e/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pushing all remotes in 'lang.note-src/lang-note.git/' ::
#|	working: push to remote 'cb' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/lang-note.git
#|	To https://codeberg.org/yhm-ypa/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://git.disroot.org/ypayhm/lang-note.git
#|	To https://git.disroot.org/ypayhm/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * [new branch]      base       -> gh/base
#|	 * [new branch]      main       -> gh/main
#|	 * [new branch]      myrddin.R  -> gh/myrddin.R
#|	 * [new branch]      tylluan.sh -> gh/tylluan.sh
#|	Fetching cb
#|	From https://codeberg.org/pure-symbols/mabynogion.spells
#|	 * [new branch]      base       -> cb/base
#|	 * [new branch]      main       -> cb/main
#|	 * [new branch]      myrddin.R  -> cb/myrddin.R
#|	 * [new branch]      tylluan.sh -> cb/tylluan.sh
#|	Fetching dr
#|	From https://git.disroot.org/pure.symbols/mabynogion.spells
#|	 * [new branch]      base       -> dr/base
#|	 * [new branch]      main       -> dr/main
#|	 * [new branch]      myrddin.R  -> dr/myrddin.R
#|	 * [new branch]      tylluan.sh -> dr/tylluan.sh
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pulling all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	working: pull from remote 'cb' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> cb/base
#|	 = [up to date]      main       -> cb/main
#|	 = [up to date]      myrddin.R  -> cb/myrddin.R
#|	 = [up to date]      tylluan.sh -> cb/tylluan.sh
#|	working: pull from remote 'dr' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> dr/base
#|	 = [up to date]      main       -> dr/main
#|	 = [up to date]      myrddin.R  -> dr/myrddin.R
#|	 = [up to date]      tylluan.sh -> dr/tylluan.sh
#|	working: pull from remote 'gh' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> gh/base
#|	 = [up to date]      main       -> gh/main
#|	 = [up to date]      myrddin.R  -> gh/myrddin.R
#|	 = [up to date]      tylluan.sh -> gh/tylluan.sh
#|	working: pull from remote 'origin' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	:: pulled all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pushing origin to all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/e/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pushing all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	working: push to remote 'cb' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	To https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/cb/base'
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	updating local tracking ref 'refs/remotes/cb/myrddin.R'
#|	updating local tracking ref 'refs/remotes/cb/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	To https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/dr/base'
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	updating local tracking ref 'refs/remotes/dr/myrddin.R'
#|	updating local tracking ref 'refs/remotes/dr/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/gh/base'
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	updating local tracking ref 'refs/remotes/gh/myrddin.R'
#|	updating local tracking ref 'refs/remotes/gh/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	Everything up-to-date
#|	:: pushed all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/pure-symbols/.github
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/pure-symbols/pure.symbols
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/pure.symbols/pure.symbols
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pulling all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	working: pull from remote 'cb' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/.github
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/.github
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/e/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pushing all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	working: push to remote 'cb' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://codeberg.org/pure-symbols/pure.symbols.git
#|	To https://codeberg.org/pure-symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.symbols.git
#|	To https://git.disroot.org/pure.symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pulling all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	working: pull from remote 'cb' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 1 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 2
#|	:: try-asking: you inputed '2' as 2.
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 2 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of push trying: 1.
#|	:: try-asking: Then: 0
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 3 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 1
#|	:: try-asking: you inputed '1' as 1.
#|	:: try-asking: rested times of push trying: 0.
#|	:: try-asking: Then: -1
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 4 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 5 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of push trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'dr' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 6 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 3
#|	:: try-asking: you inputed '3' as 3.
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 7 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of push trying: 2.
#|	:: try-asking: Then: 1
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 8 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of push trying: 1.
#|	:: try-asking: Then: 0
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 9 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 10 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of push trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'gh' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/e/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pushing all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	working: push to remote 'cb' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://codeberg.org/pure-symbols/pure.lexicals.git
#|	Enumerating objects: 529, done.
#|	Counting objects: 100% (529/529), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (195/195), done.
#|	Writing objects: 100% (513/513), 189.12 KiB | 4.61 MiB/s, done.
#|	Total 513 (delta 340), reused 490 (delta 317), pack-reused 0 (from 0)
#|	POST git-receive-pack (193845 bytes)
#|	remote: Resolving deltas: 100% (340/340), completed with 11 local objects.
#|	To https://codeberg.org/pure-symbols/pure.lexicals.git
#|	   4416b93..608048c  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	working: push to remote 'dr' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	Enumerating objects: 55, done.
#|	Counting objects: 100% (55/55), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (26/26), done.
#|	Writing objects: 100% (49/49), 44.97 KiB | 3.00 MiB/s, done.
#|	Total 49 (delta 28), reused 44 (delta 23), pack-reused 0 (from 0)
#|	POST git-receive-pack (46230 bytes)
#|	remote: Checking connectivity: 49, done.
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	   8fbcd08..608048c  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	working: push to remote 'gh' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pulling from origin and all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/sh3rr
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/sh3rr
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/sh3rr
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pulling all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	working: pull from remote 'cb' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/sh3rr
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pushing origin to all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/e/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pushing all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	working: push to remote 'cb' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/sh3rr.git
#|	To https://codeberg.org/yhm-ypa/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://git.disroot.org/ypayhm/sh3rr.git
#|	To https://git.disroot.org/ypayhm/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pulling from origin and all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/yhm-ypa
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/ypayhm
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pulling all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	working: pull from remote 'cb' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/yhm-ypa
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/ypayhm
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	
#|	:: pushing origin to all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/e/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pushing all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	working: push to remote 'cb' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	To https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://git.disroot.org/ypayhm/ypayhm.git
#|	To https://git.disroot.org/ypayhm/ypayhm.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	

