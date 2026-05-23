
b3sum *.tar.xz | while read -r -- hash name ; 
do 
	1>&2 echo - :from: "$name" && 
	1>&2 echo - :to: "$(dirname "$name")/$(basename -s .tar.xz -- "$name") - b3_${hash}.tar.xz" && 
	mv "$name" "$(dirname "$name")/$(basename -s .tar.xz -- "$name") - b3_${hash}.tar.xz" && 
	:; 
done
