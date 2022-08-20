#!/bin/sh

# Run this script by:
# curl -L  https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | DOWNLOADER='curl -L ' THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -x
# wget -O- https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | DOWNLOADER='wget -O-' THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -x



set -eu

: "${THEPKG_PREFIX:=''}" # by default install to root '/'

log() { printf %s\\n " -> $1"; }

trap '[ $? = 0 ] || printf %s\\n >&2 "x> failed!"' EXIT


case $THEPKG_PREFIX:$USER in *:root|*:root) ;; /:*|'':*)
	: "${THEPKG_PREFIX:=""}"
	printf %s\\n%s >&2 \
		"you are trying to install thepkg tor root dir '/' without root user" \
		"(^C to exit / Enter to continue): "
	read i || exit; case $i in ^C) exit; esac
esac



log "downloading the script..."; {
	: "${THEPKG_PREFIX:=""}"

	mkdir -pv "${THEPKG_PREFIX}/bin"
	${DOWNLOADER:-'curl -L'} https://github.com/denisde4ev/thepkg/raw/master/thepkg > "${THEPKG_PREFIX}/bin/thepkg"
	chmod -v 755 "${THEPKG_PREFIX}/bin/thepkg"
}



log "writing the db..."; { # in rorder thepkg to be able to uninstall itself
	: "${THEPKG_DBPATH:="$THEPKG_PREFIX/var/db/thepkg"}"

	mkdir -pv "${THEPKG_DBPATH}/thepkg"
	printf %s\\n "${THEPKG_PREFIX}/bin/thepkg" >> "${THEPKG_DBPATH}/thepkg/manifest"
}



log " -> apply changed vairables..."; {
	# consider: to skip patch when vars are unchanged / or to skip individual var?

	: "${THEPKG_PREFIX:=""}"
	: "${THEPKG_DBPATH:="$THEPKG_PREFIX/var/db/thepkg"}"

	printf %s\\n%s\\n%s >&2 \
		"do you want to apply your current vairables to current thepkg" \
		"from variables: THEPKG_PREFIX THEPKG_DBPATH `: and THEPKG_SUBDIR_PREFIX :`" \
		"(Y/N): "
	read i
	case $i in [Yy]|[Yy]es|YES)
		patch --forward --strip=1 "${THEPKG_PREFIX}/bin/thepkg" <<- EOF
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
