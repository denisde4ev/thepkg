#!/bin/sh

# extract thepkg-patches to 2 files: 'thepkg' and 'thepkg-allpatched'



cd "${0%/*}/.." || exit


# too simple and not pure sh way:
#sed -n 's/^[ -]//p' thepkg.patch > thepkg
#sed -n 's/^[ +]//p' thepkg.patch > thepkg-allpatched


while IFS= read -r line; do
	case $line in
		[\-\ ]*) printf %s\\n "${line#?}" >&3;;
	esac
	case $line in
		[\+\ ]*) printf %s\\n "${line#?}" >&4;;
	esac
done <./src/thepkg.patch 3>./build/thepkg 4>./build/thepkg-allpatched


# same as my (using sed): /^/\ https://github.com/denisde4ev/bin/blob/master/patch-splitter

