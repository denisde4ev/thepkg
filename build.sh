#!/bin/sh

# '/^/\ https:/github.com/denisde4ev/bin/~/bin/patch-splitter'

##sed -n 's/^[ -]//p' thepkg.patch > thepkg
##sed -n 's/^[ +]//p' thepkg.patch > thepkg-allpatched


while IFS= read -r line; do
	case $line in
		[\-\ ]*) printf %s\\n "${line#?}" >&3;;
	esac
	case $line in
		[\+\ ]*) printf %s\\n "${line#?}" >&4;;
	esac
done <thepkg.patch 3>thepkg 4>thepkg-allpatched
