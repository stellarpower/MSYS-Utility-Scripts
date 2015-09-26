#!/bin/bash

#   Copyright Ben Southall (github.com/stellarpower) 2015.
# Distributed under the Boost Software License, Version 1.0.
#    (See accompanying file LICENCE.txt or copy at
#          http://www.boost.org/LICENSE_1_0.txt)

JUNCTION='/c/Program Files/junction.exe' #Change this to match your setup or simply replace with junction.exe if it's in your PATH.

chompPath(){
	echo "$1" | sed 's/\(.*[^\/]\)\/*$/\1/'
}

thePath="$(chompPath "$1")"
"$JUNCTION" "$thePath" | grep Substitute | sed 's/.*Name: // ; s/(.*) *^/\1/'

