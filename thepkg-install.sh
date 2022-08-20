#!/bin/sh

# Run this script by:
# curl -sL  https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | DOWNLOADER='curl -sL ' THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -
# wget -qO- https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | DOWNLOADER='wget -qO-' THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -


set -eu

: "${THEPKG_PREFIX:=""}" # by default install to root '/'
: "${THEPKG_DBPATH:="$THEPKG_PREFIX/var/db/thepkg"}"
: "${THEPKG_INSTALL_FILE:=thepkg}"
: "${THEPKG_INSTALL_PATH:="${THEPKG_PREFIX?}/bin/${THEPKG_INSTALL_FILE_TARGET:-${THEPKG_INSTALL_FILE:-thepkg}"}}"

# you can specify custom path by: `... | ... THEPKG_INSTALL_PATH=.local/bin/thepkg sh -`

# TODO: TEST IF ln WORKS AS EXPECTED
# to instal for user use: `... | ... THEPKG_PREFIX="$HOME/.local/bin" `

# and then add '~/.local/share/thepkg/bin:~/.local/share/thepkg/usr/bin' to your PATH var OR link files by: `
# mkdir -v -p ~/.local/bin # in case it does not exist yet
# cd ~/.local/share/thepkg && {
# mkdir -v -p usr
# ln -v -snT ../../../bin usr/bin
# ln -v -snT usr/bin bin
# ln -v -snT ../../../.config/thepkg-etc etc
# # note: there might be many more dirs to link but those are the main one
# `
# TODO:! better install some kind of filesystem-user

log() { printf %s\\n " -> $1"; }

trap '[ $? = 0 ] || printf %s\\n >&2 "x> failed!"' EXIT

case $THEPKG_PREFIX:$USER in *:root|*:root) ;; /:*|'':*)
	printf %s\\n%s >&2 \
		"install thepkg to '/' without root privileges is expected to fail" \
		"(Enter to continue / ^C to exit): "
	read i </dev/tty || exit; case $i in ^C) exit; esac
esac





log "downloading the script..."; {
	: "${THEPKG_PREFIX:=""}"
	: "${THEPKG_INSTALL_PATH:="${THEPKG_PREFIX?}/bin/thepkg"}"

	: "${THEPKG_INSTALL_PATH:?}"; mkdir -pv "${THEPKG_INSTALL_PATH%/*}"
	${DOWNLOADER:-'curl -sL'} \
		https://github.com/denisde4ev/thepkg/raw/master/"${THEPKG_INSTALL_FILE:-thepkg}" \
		> "${THEPKG_INSTALL_PATH:?}" \
	;
	chmod -v 755 "${THEPKG_PREFIX?}/bin/thepkg"
}



log "writing the db..."; { # in rorder thepkg to be able to uninstall itself
	: "${THEPKG_DBPATH:="$THEPKG_PREFIX/var/db/thepkg"}"

	mkdir -pv "${THEPKG_DBPATH:?}/thepkg"
	printf %s\\n "${THEPKG_PREFIX?}/bin/thepkg" >> "${THEPKG_DBPATH:?}/thepkg/manifest"
}



log " -> apply changed vairables..."; {
	# consider: to skip patch when vars are unchanged / or to skip individual var?

	: "${THEPKG_PREFIX:=""}"
	: "${THEPKG_DBPATH:="$THEPKG_PREFIX/var/db/thepkg"}"

	printf %s\\n%s\\n%s >&2 \
		"do you want to apply your current vairables to current thepkg" \
		"from variables: THEPKG_PREFIX THEPKG_DBPATH `: and THEPKG_SUBDIR_PREFIX :`" \
		"(Y/N): "
	read i </dev/tty || i=${i:=y}
	case $i in [Yy]|[Yy]es|YES)
		patch --forward --strip=1 "${THEPKG_PREFIX?}/bin/thepkg" <<- EOF
			--- thepkg
			+++ thepkg
			@@ -?,? +?,? @@
			 # thepkg config / env vars:
			-: "\${THEPKG_PREFIX:=""}"
			-: "\${THEPKG_DBPATH:="\$THEPKG_PREFIX/var/db/thepkg"}"
			+: "\${THEPKG_PREFIX:='$THEPKG_PREFIX'}"
			+: "\${THEPKG_DBPATH:='$THEPKG_DBPATH'}"
		EOF

		# TODO: for var THEPKG_SUBDIR_PREFIX: patch and detect patch + detect if var is defined and changed from default
		#-: "${THEPKG_SUBDIR_PREFIX:=""}"
		#+: "\${THEPKG_DBPATH:="$THEPKG_DBPATH"}"
	esac
}
