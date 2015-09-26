#!/bin/bash

#   Copyright Ben Southall (github.com/stellarpower) 2015.
# Distributed under the Boost Software License, Version 1.0.
#    (See accompanying file LICENCE.txt or copy at
#          http://www.boost.org/LICENSE_1_0.txt)

JUNCTION='/c/Program Files/junction.exe' #Change this to match your setup or simply replace with junction.exe if it's in your PATH.

chompPath(){
	##junction doesn't accept trailing slashes, so chomp them here:
	echo "$1" | sed 's/\(.*[^\/]\)\/*$/\1/'
}

isJunction(){
	thePath="$(chompPath "$1")"
	"$JUNCTION" "$thePath" | grep -ie '\(No Matching Files\)\|\(No reparse Points\)' >/dev/null 2>&1 
	return $(( 1 - $? ))
}

output(){
	out="$(echo "$1" | sed 's/\\/\\\\/g')"
	echo -e "$out \\c"
}

derefOnce(){

a="$1"
until [ "$a" == '/' ] ; do
	if isJunction "$a"; then
		#echo isj
		target="$(PathtoNix.sh "$(ReadLink.sh "$a")" )"

		##echo $suffix
		response="$target/$suffix"
		
		break
	else
		#echo isnotj
		[ -z "$suffix" ] && suffix="$(basename "$a")" || suffix="$(basename "$a")/$suffix" #Only add leading slash needed.
		a="`dirname "$a"`"
	fi
done

[ -z "$response" ] && response="$1"
echo "$response"


}

mode="$1"
[[ ("$mode" == 'once') || ("$mode" == 'full') ]] || (echo "Usage RealPath.sh (once|full) path1 [path2 [... ]] " ; exit -1)

shift 1


for i in "$@" ; do 
	if [ -e "$i" ] ; then
		if [ $mode == once ] ; then
			dereffed="$( derefOnce "$i" )"
		else
			current="$( derefOnce "$i" )"
			next="$( derefOnce "$current" )"
			
			while [ "$current" != "$next" ] ; do
				current="$next"
				next="$( derefOnce "$current" )"
			done
			dereffed="$next"
		fi
	else
		dereffed="$i"
	fi
	output "$dereffed"
done

echo
