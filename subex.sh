#!/bin/sh

# goes to all visible subdirectories sequentially and executes a command there
# dependencies: pure POSIX Shell

exec 2>/dev/null # supress errors

# show help
! (: "${*:?}" ) && echo 'Usage: subex [command_string ...]' && exit

dirs="$(printf '%s' */)" # list of every visible subdir
startdir="$PWD"          # remember where subex was executed
cmd="$*"                 # passed commands

# main function
do_stuff() {
	curdir="${dirs%%/*}" # first entry of dirs
	dirs="${dirs#*/}"    # removes first entry of dirs
	
	cd "$curdir" || { echo "$PWD: can't go to curdir: '$curdir'"; exit; }
	echo "$PWD"
	eval "$cmd"
	cd "$startdir" || { echo "$PWD: can't go to startdir: '$startdir'"; exit; }
}

# main loop
while :; do
	case "$dirs" in
		*/*/) do_stuff;;
		*/) do_stuff; break;; # for the last dir
	esac
done
