
b3sum *.tar.xz | while read -r -- hash name ; 
do 
	( 
		1>&2 printf "--- :from: $name" && 
		1>&2 printf " ~ :to: $(dirname "$name")/$(basename -s .tar.xz -- "$name") - b3_${hash}.tar.xz" && 
		1>&2 echo && 
		: ) && 
	#: del the `:` if you really want those mv.
	: mv "$name" "$(dirname "$name")/$(basename -s .tar.xz -- "$name") - b3_${hash}.tar.xz" && 
	:; 
done
