#!/bin/sh
#
# goes to all visible subdirectories sequentially and executes a command there
# dependencies: POSIX Shell
#
# shellcheck disable=SC2294

# show help
[ ! "$*" ] && echo "Usage: subex [-h] [command_string ...]" && exit

# hidden directory toggle
[ "$1" = -h ] && h=. H=' hidden' && shift

# remember where subex was executed
startdir="$PWD"

IFS=/
for curdir in "$h"*/; do
	[ "$curdir" = ./ ] || [ "$curdir" = ../ ] && continue
	if [ "$curdir" != '*/' ]; then
		cd -- "$curdir" || exit
		echo "$PWD"
		eval "$@"
		cd -- "$startdir" || exit
	else
		echo "No$H directories found in $startdir" && exit
	fi
done
