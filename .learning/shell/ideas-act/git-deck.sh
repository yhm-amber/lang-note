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
					case "$(echo "${'"$NAME_EMBEDDED"':-'"$BOOL_DEFAULT"'}" | tr -- '"'"'[:lower:]'"'"' '"'"'[:upper:]'"'"')" 
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
		#. ... 9</dev/tty
		#. :
		#.	_taste_asking () 
		#.	(
		#.		eval "$(FD_TTY=9 _cmnd_tools _retry_asking init_codes)" && 
		#.		while true; do echo x ; eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && :; done && 
		#.		: ) 9</dev/tty && 
		#.	:
		#.	_taste_asking_x () 
		#.	(
		#.		0< <(
		#.			eval "$(FD_TTY=9 _cmnd_tools _retry_asking init_codes)" && 
		#.			while true; do echo x ; 1>&2 eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && :; done && 
		#.			: ) awk '{print "~~~",$0}' && 
		#.		: ) 9</dev/tty && 
		#.	:
		_retry_asking () 
		(
			PKG_ASKING="${PKG_ASKING:-_cmnd_tools _retry_asking}" && 
		#.	:
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
					echo :: try-asking: rested times of that trying: "$((_rests_tryasking))". && 
					if eval "$('"${PKG_ASKING}"' __chunk_chktiming)" ; 
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
			__chunk_chktiming () 
			(
				echo '
					_cmnd_tools _booled_returns "$((_rests_tryasking < 0))" && 
					: ' && 
				: ) && 
			
			init_codes () 
			(
				echo '
					local _rests_tryasking="${ASKING_MAXTRY:-${MAXTRY_ASKING:-0}}" && 
					: ' && 
				: ) && 
			body_codes () 
			(
				echo '
					if eval "$('"${PKG_ASKING}"' __chunk_asktiming)" ; 
					then 
						eval "$('"${PKG_ASKING}"' __chunk_asker)" && 
						eval "$('"${PKG_ASKING}"' __chunk_chktiming)" && 
						eval "$('"${PKG_ASKING}"' __chunk_verifier)" && 
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
		#. ASKING_MAXTRY=999 git-deck cp a https://github.com/denoland/deno.git --mirror
		#. ASKING_MAXTRY=999 git-deck cp a https://github.com/osquery/osquery.git --mirror
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
				1>&2 eval "$(FD_TTY=9 _cmnd_tools _retry_asking body_codes)" && : 其尝适询 && 
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
			} 6>&1 && : ) && 
			: ) 7>&1 && 
		
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
			echo '- ASKING_MAXTRY=9 git-deck sp all-sync *  # To taking control if net is not very good.' && 
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
		
		alias rmt=remote && remote () 
		(
			has () 
			(
				for rmt in "$@" ;
				do 
					if git config --get "remote.${rmt}.url" > >(
						1>&2 awk -v rmt="'${rmt}'" -v show=existed: -- '{ print show,rmt,$0 }' && 
						: ) ;
						then echo "${rmt}" ;
						else { 1>&2 echo unfound: "'${rmt}'" '<undefined>' ; return 59 ; } ;
					fi && 
					:; 
				done && 
				: ) && 
			
			_chkhas_codes () 
			(
				_emb_name="${1:-CHECK_REMOTE_EXISTS}" && 
				echo '
					eval "$(subs kwargs as_bool '"$_emb_name"' y)" && 
					if "$__'"$_emb_name"'__" ;
						then { has "$@" 1>/dev//null || return $? ; } ;
						else : ;
					fi && 
					: ' && 
				: ) && 
			
			#: [LIST_WITH_LOCAL=<y|N>] list_heads [<remote> ...]
			list_heads () 
			(
				# { set -o pipefail -e || :; } && 
				eval "$(_chkhas_codes CHECK_REMOTE_EXISTS)" && 
				for rmt in "$@" ;
				do 
					: 各支所執 && 
					while ! git ls-remote -- "${rmt}" 'refs/heads/*' ;
					do 1>&2 echo fail: "$((++_retried_ls_remote))" retried ls remote "'${rmt}'" ; 
					done | 
						awk -- '
							{ ref = $2; oid = $1; print oid,from,ref }
							BEGIN { OFS = "\t"; from = "'"${rmt}"'" }' | 
						cat - && 
					:; 
				done && 
				if eval "$(subs kwargs as_bool LIST_WITH_LOCAL no)" '&&' '$__LIST_WITH_LOCAL__' ;
					then git for-each-ref --format=$'%(objectname)\t.local\t%(refname)' -- 'refs/heads/*' ;
					else : ;
				fi && 
				: ) && 
			
			#: corresp_local [<remote> ...]
			corresp_local () 
			(
				eval "$(_chkhas_codes CHECK_REMOTE_EXISTS)" && 
				for rmt in "$@" ;
				do 
					join -t $'\t' -1 3 -2 3 -o '0,2.1,1.1' -a 1 -a 2 -e '_' -- <(
						CHECK_REMOTE_EXISTS=x LIST_WITH_LOCAL=y list_heads | sort -k 3 -t $'\t') <(
						CHECK_REMOTE_EXISTS=x list_heads "${rmt}" | sort -k 3 -t $'\t') | 
						awk -- '
							{ print from, $0 }
							BEGIN { OFS = "\t"; from = "'"${rmt}"'" }' | 
						cat - && 
					:;
				done && 
				: ) && 
			
			#: remote necessity check <pull|push> [<remote> ...] | rmt necessity apply <remote>
			#: remote necessity verific <remote> <pull|push>
			#. gd sp remote necessity verific origin pull ; echo ~~~ $?
			#. gd sp remote necessity verific origin push ; echo ~~~ $?
			necessity () 
			(
				verific () 
				(
					local remote="$1" && { shift || { 1>&2 echo Error: need to specify remote in param-1 ; return 26 ; } ; } && 
					local trmode="$1" && { shift || { 1>&2 echo Error: need to specify 'pull|push' in param-2 ; return 26 ; } ; } && 
					
					echo ::: chking: verificing the necessity of remote "'${remote}'" for "*${trmode}ing*" works.
					return $(
					shopt -u -q -- extglob ;
					{
						{ check "${trmode}" "${remote}" ; } | 
							{ apply "${remote}" || echo $? 1>&6 ; } | 
							cat - 1>&7 && 
						:;
					} 6>&1 && : ) && 
					: ) 7>&1 && 
				
				check () 
				(
					case "$(echo "${1}" | tr -- '[:upper:]' '[:lower:]')" 
					in 
						(pull)   __sub_mark__=pull  && shift ;; 
						(push)   __sub_mark__=push  && shift ;; 
						(_) 1>&2 echo Unknown sub cmd in necessity check: "'$1'" '(only support pull|push).' && return 16 ;;
					esac && 
					
					_esc_codes () 
					(
						echo '
							{ 
								{ _rsc='"${1:-\$?}"' ; echo "$_rmt" "$_rsc" ; } ; 
								{ 1>&2 HEAD_HINT=chked var_shower _rsc _rmt ref_path ; break ; } ; 
							}' && 
						: ) && 
					_cnt_codes () 
					(
						echo '
							{ 
								{ _rsc='"${1:-\$?}"' ; _pass_by='"${2:-}"' ; } ; 
								{ 1>&2 HEAD_HINT=pass var_shower _rsc _rmt ref_path ; continue ; } ; 
							}' && 
						: ) && 
					
					var_shower () 
					(
						_var_codes () 
						(
							for x in "$@" ;
							do echo '"'"${x}":'${'"${x}"'}''"' ; done | 
								pr -s --columns "$#" -t -- - | 
								awk -v OFS='\t' -- '{ print "echo", $0 }' | 
								cat - && 
							: ) && 
						
						eval "$(_var_codes "$@")" | 
							awk -v OFS='\t' -- '{ $NF = $NF; print "'"${HEAD_HINT:-chking}"':",$0 }' | 
							awk -F : -v OFS=': ' -- '{ $NF = $NF; print }' | 
							cat - && 
						: ) && 
					
					eval "$(_chkhas_codes CHECK_REMOTE_EXISTS)" && 
					for rmt in "$@" ;
					do 
						CHECK_REMOTE_EXISTS=x corresp_local "${rmt}" | while read -r -- _rmt ref_path hash_remote hash_local ;
						do 
							1>&2 var_shower _rmt ref_path hash_remote hash_local && 
							: 为头者过 同者过 && 
							{ 1>&2 test "$ref_path" != HEAD || eval "$(_cnt_codes $? .IS_HEAD)" ; } && 
							{ 1>&2 test "${hash_local}" != "${hash_remote}" || eval "$(_cnt_codes $? .EQUAL_HASH)" ; } && 
							: 取者 此不空 須遠为先或空而此为后者 可过 否則留作业之 && 
							: 去者 遠不空 須此为先或空而遠为后者 可过 否則留作业之 && 
							case "$__sub_mark__" 
							in 
								(pull)
									{ 1>&2 test -n "${hash_remote}" || eval "$(_cnt_codes $? BLK.RMT_HASH)" ; } && 
									{ 1>&2 test "${hash_remote}" != '_' || eval "$(_cnt_codes $? BLKD.RMT_HASH)" ; } && 
									{ 1>&2 test -n "${hash_local}" || eval "$(_esc_codes $?)" ; } && 
									{ 1>&2 test "${hash_local}" != '_' || eval "$(_esc_codes $?)" ; } && 
									{ 1>&2 git merge-base --is-ancestor "${hash_remote}" "${hash_local}" || eval "$(_esc_codes $?)" ; } && 
									: ;; 
								(push)
									{ 1>&2 test -n "${hash_local}" || eval "$(_cnt_codes $? BLK.LCO_HASH)" ; } && 
									{ 1>&2 test "${hash_local}" != '_' || eval "$(_cnt_codes $? BLKD.LCO_HASH)" ; } && 
									{ 1>&2 test -n "${hash_remote}" || eval "$(_esc_codes $?)" ; } && 
									{ 1>&2 test "${hash_remote}" != '_' || eval "$(_esc_codes $?)" ; } && 
									{ 1>&2 git merge-base --is-ancestor "${hash_local}" "${hash_remote}" || eval "$(_esc_codes $?)" ; } && 
									: ;; 
							esac && 
							:; 
						done && 
						:; 
					done && 
					: ) && 
				
				apply () 
				(
					local rmt="${1}" && 
					{ shift || { 1>&2 echo Error: must input a remote name to param-1. ; return 26 ; } ; } && 
					while read -r -- remote_name return_code ;
					do 
						if test "${remote_name}" = "${rmt}" ;
							then return "${return_code}" ;
							else : ;
						fi && 
						:; 
					done && 
					: ) && 
				
				: :: && 
				"$@" && 
				: ) && 
			
			: :: && 
			"$@" && 
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
			eval "$(_cmnd_tools _retry_asking init_codes)" && : 此尝适询 && 
			echo working: push to remote "'${_git_remote}'" for "'$(_cmnd_tools _curr_dir .)'" && 
			while 
			! { 
			if ! "${IS_BARE}" && : 其令选行 ;
				then git push "$@" --branches -- "${_git_remote}" ;
				else git push "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' ;
			fi || 
				remote necessity verific "${_git_remote}" push && 
			:; } ;
			do 
				: 此下 乃复试探 有询 && 
				: 曰回显 && 
				1>&2 echo tried: "$((++try_push))" for '`'"$(if ! "${IS_BARE}" && : 其显选出 ;
					then echo "git push $* --branches -- ${_git_remote}" ;
					else echo "git push $* -- ${_git_remote} 'refs/heads/*:refs/heads/*'" ;
				fi)"'`' in "'$(_cmnd_tools _curr_dir .)'" && 
				: 尝适询 && 
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
			eval "$(_cmnd_tools _retry_asking init_codes)" && : 此尝适询 && 
			echo working: pull from remote "'${_git_remote}'" for "'$(_cmnd_tools _curr_dir .)'" && 
			while 
			! { 
			if ! "${IS_BARE}" && : 其令选行 ;
				then git fetch "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' '^'"${_symbref_head}" ;
				else git fetch "$@" -- "${_git_remote}" 'refs/heads/*:refs/heads/*' ;
			fi || 
				remote necessity verific "${_git_remote}" pull && 
			:; } ;
			do 
				: 此下 乃复试探 有询 && 
				: 曰回显 && 
				1>&2 echo tried: "$((++try_pull))" for '`'"$(if ! "${IS_BARE}" && : 其显选出 ;
					then echo "git fetch $* -- ${_git_remote} 'refs/heads/*:refs/heads/*' '^${_symbref_head}'" ;
					else echo "git fetch $* -- ${_git_remote} 'refs/heads/*:refs/heads/*'" ;
				fi)"'`' in "'$(_cmnd_tools _curr_dir .)'" && 
				: 尝适询 && 
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
						push_full "${git_remote}" . "$@" && 
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
						pull_full "${git_remote}" . "$@" && 
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

