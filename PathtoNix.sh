#!/bin/bash

#   Copyright Ben Southall (github.com/stellarpower) 2015.
# Distributed under the Boost Software License, Version 1.0.
#    (See accompanying file LICENCE.txt or copy at
#          http://www.boost.org/LICENSE_1_0.txt)



count=$#

for i in "$@" ; do 
	response="$(  echo "$i" | sed -r  -e 's/\\/\//g' -e 's/^([^:]+):/\/\1/'  )"
	[ $count -le 1 ] && echo "$response" || echo -e "$response \c" 
	count=$(( $count - 1 ))
done

#echo


