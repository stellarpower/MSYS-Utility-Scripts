#!/bin/bash

#   Copyright Ben Southall (github.com/stellarpower) 2015.
# Distributed under the Boost Software License, Version 1.0.
#    (See accompanying file LICENCE.txt or copy at
#          http://www.boost.org/LICENSE_1_0.txt)



count=$#

for i in "$@" ; do 
	response="$(echo "$i" | sed 's|^/\([a-z,A-Z]\)|\1:|' | sed 's|/|\\|g')"
	response="$(echo "$response" | sed 's/\\/\\\\/g')" #echo -e will try to interpret backslashes
	[ $count -le 1 ] && echo "$response" || echo -e "$response \c" 
	count=$(( $count - 1 ))
done

#echo
