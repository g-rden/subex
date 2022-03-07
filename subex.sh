#!/bin/sh
#
# goes to all visible subdirectories sequentially and executes a command there
# dependencies: POSIX Shell
#

# show help
[ ! "$*" ] && echo "Usage: subex [command_string ...]" && exit

startdir="$PWD" # remember where subex was executed
cmd="$*"        # passed commands

IFS='/'
for curdir in $(printf '%s' */); do
	cd "$curdir" || { echo "$PWD: can't go to curdir: $curdir"; exit;}
	echo "$PWD"
	eval "$cmd"
	cd "$startdir" || { echo "$PWD: can't go to startdir: $startdir"; exit;}
done
