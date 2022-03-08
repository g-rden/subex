#!/bin/sh
#
# goes to all visible subdirectories sequentially and executes a command there
# dependencies: POSIX Shell
#

# show help
[ ! "$*" ] && echo "Usage: subex [command_string ...]" && exit

startdir="$PWD" # remember where subex was executed

IFS='/'
# shellcheck disable=SC2294
for curdir in $(printf '%s' */); do
	cd "$curdir" || exit
	echo "$PWD"
	eval "$@"
	cd "$startdir" || exit
done
