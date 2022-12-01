#!/bin/sh
set -eu
cd "${0%/*}" || exit

err_rm() {
	printf %s\\n "E: build failed. '${1#../}'"
	rm -f "$1"
	exit $2
}

./thepkg.preprocess > ../thepkg || err_rm ../thepkg $?

THEPKGCONFIG__ALLPATCHED__=1 \
THEPKGCONFIG_NOERR_STAT0=1 \
THEPKGCONFIG_SUBDIR_PREFIX=1 \
THEPKGCONFIG_ADDFROMTAR=1 \
THEPKGCONFIG_THEPKGVER_ARG_PARSING=1 \
THEPKGCONFIG_UPGRADE=1 \
THEPKGCONFIG_METADATA_THEPKG_EXT=1 \
THEPKGCONFIG_EXTENDED_VERBOSE=1 \
THEPKGCONFIG_RMFAILED=1 \
THEPKGCONFIG_KEEP_ETC=1 \
./thepkg.preprocess > ../thepkg-allpatched \
|| err_rm ../thepkg-allpatched $?


chmod +x ../thepkg ../thepkg-allpatched
