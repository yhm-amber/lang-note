#### 别令速记
# ~~~~
	# git clone --no-single-branch -- ...
	# git clone --depth=1 --no-single-branch -- ...
	# git clone --deeprn=1 --no-single-branch -- ...
	
	# x_Retry git fetch --unshallow --all
	
	# git branch --all | cat # 可得全分支
	# git tag --no-column | cat # 可得全签记
# ~~~~



### worktree old-style define
# ~~~~
		# 	add () 
		# 	(
		# 		tags () 
		# 		{
		# 			return $( 
		# 			{
		# 				_name_input="$1" && shift 1 && 
		# 				{
		# 					git tag --format='%(refname:short)' --no-column --contains "$_name_input" || 
		# 					echo $? 1>&6 ;
		# 					:; 
		# 				} | 
		# 					tee >(awk -- '{ print "-",$0 } BEGIN { print "Contained tags: " }' 1>&2) | 
		# 					{
		# 						while read -r -- _name ;
		# 						do 
		# 							echo :: executing: worktree add "'../tags/$_name'" "'$_name'" $@ :: && 
		# 							git worktree add ../tags/"$_name" "$_name" "$@" && 
		# 							ls ../tags && 
		# 							:; 
		# 						done || 
		# 						echo $? 1>&6 ;
		# 					} | 
		# 					cat - 1>&7 && 
		# 					:;
		# 			} 6>&1 && : ) && :; } 7>&1 && 
		# 		
		# 		tree () 
		# 		{
		# 			return $( 
		# 			{
		# 				_name_input="$1" && shift 1 && 
		# 				{
		# 					git branch --format='%(refname:short)' --no-column --contains "$_name_input" || 
		# 					echo $? 1>&6 ;
		# 				} | 
		# 					tee >(awk -- '{ print "-",$0 } BEGIN { print "Contained branches: " }' 1>&2) | 
		# 					{
		# 						while read -r -- _name ;
		# 						do 
		# 							echo :: executing: worktree add "'../tree/$_name'" "'$_name'" $@ :: && 
		# 							git worktree add ../tree/"$_name" "$_name" "$@" && 
		# 							ls ../tree && 
		# 							:; 
		# 						done || 
		# 						echo $? 1>&6 ;
		# 					} | 
		# 					cat - 1>&7 && 
		# 					:;
		# 			} 6>&1 && : ) && :; } 7>&1 && 
		# 		
		# 		: :: && 
		# 		"$@" && 
		# 		: ) && 
		# 	
		# 	rm () 
		# 	(
		# 		tags () 
		# 		{
		# 			return $( 
		# 			{
		# 				_name_input="$1" && shift 1 && 
		# 				{
		# 					git tag --format='%(refname:short)' --no-column --contains "$_name_input" || 
		# 					echo $? 1>&6 ;
		# 					:; 
		# 				} | 
		# 					tee >(awk -- '{ print "-",$0 } BEGIN { print "Contained tags: " }' 1>&2) | 
		# 					{
		# 						while read -r -- _name ;
		# 						do 
		# 							echo :: executing: worktree remove "'../tags/$_name'" $@ :: && 
		# 							git worktree remove ../tags/"$_name" "$@" && 
		# 							ls ../tags && 
		# 							:; 
		# 						done || 
		# 						echo $? 1>&6 ;
		# 					} | 
		# 					cat - 1>&7 && 
		# 					:;
		# 			} 6>&1 && : ) && :; } 7>&1 && 
		# 		
		# 		tree () 
		# 		{
		# 			return $( 
		# 			{
		# 				_name_input="$1" && shift 1 && 
		# 				{
		# 					git branch --format='%(refname:short)' --no-column --contains "$_name_input" || 
		# 					echo $? 1>&6 ;
		# 				} | 
		# 					tee >(awk -- '{ print "-",$0 } BEGIN { print "Contained branches: " }' 1>&2) | 
		# 					{
		# 						while read -r -- _name ;
		# 						do 
		# 							echo :: executing: worktree remove "'../tree/$_name'" $@ :: && 
		# 							git worktree remove ../tree/"$_name" "$@" && 
		# 							ls ../tree && 
		# 							:; 
		# 						done || 
		# 						echo $? 1>&6 ;
		# 					} | 
		# 					cat - 1>&7 && 
		# 					:;
		# 			} 6>&1 && : ) && :; } 7>&1 && 
		# 		
		# 		: :: && 
		# 		"$@" && 
		# 		: ) && 
# ~~~~

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
