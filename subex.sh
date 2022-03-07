#!/bin/sh
#
# goes to all visible subdirectories sequentially and executes a command there
# dependencies: POSIX Shell
#

# show help
! (: "${*:?}") 2>/dev/null && echo 'Usage: subex [command_string ...]' && exit

startdir="$PWD" # remember where subex was executed

for curdir in $(echo */); do
	cd "$curdir" || { echo "$PWD: can't go to curdir: $curdir"; exit;}
	echo "$PWD"
	eval "$*"
	cd "$startdir" || { echo "$PWD: can't go to startdir: $startdir"; exit;}
done
